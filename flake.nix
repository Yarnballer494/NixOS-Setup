{
  description = "Your new nix config";
                                                  
  inputs = {
    # Nixpkgs
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    # You can access packages and modules from different nixpkgs revs
    # at the same time. Here's an working example:
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    # Also see the 'unstable-packages' overlay at 'overlays/default.nix'.

    # Home manager
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    
    # Nixvim
    nixvim.url = "github:nix-community/nixvim"; 
    
    # Sops
    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    # Nix jetbrains plugins
    nix-jetbrains-plugins.url = "github:nix-community/nix-jetbrains-plugins";

    # Stylix
    stylix.url = "github:nix-community/stylix/release-25.11";
    stylix.inputs.nixpkgs.follows = "nixpkgs";
    
    # Nixcord
    nixcord.url = "github:FlameFlag/nixcord";
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    sops-nix,
    stylix,
    ...
  } @ inputs: let
    # Supported systems for your flake packages, shell, etc.
    systems = [
      "aarch64-linux"
      "i686-linux"
      "x86_64-linux"
      "aarch64-darwin"
      "x86_64-darwin"
    ];
    # This is a function that generates an attribute by calling a function you
    # pass to it, with each system as an argument
    forAllSystems = nixpkgs.lib.genAttrs systems;
  in {
    # Your custom packages
    # Accessible through 'nix build', 'nix shell', etc
    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});
    # Formatter for your nix files, available through 'nix fmt'
    # Other options beside 'alejandra' include 'nixpkgs-fmt'
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    # Your custom packages and modifications, exported as overlays
    overlays = import ./overlays {inherit inputs;};
    # Reusable nixos modules you might want to export
    # These are usually stuff you would upstream into nixpkgs
    nixosModules = import ./modules/system;
    # Reusable home-manager modules you might want to export
    # These are usually stuff you would upstream into home-manager
    homeManagerModules = import ./modules/home;

    # NixOS configuration entrypoint
    # Available through 'nixos-rebuild --flake .#your-hostname'
    nixosConfigurations = {
      # FIXME add all hosts you need 
      surface = nixpkgs.lib.nixosSystem {
        specialArgs = {
	  inherit inputs;
	};
        modules = [
          # > Our main nixos configuration file <
          ./hosts/surface/configuration.nix  	
	  stylix.nixosModules.stylix
	  sops-nix.nixosModules.sops
        ];
      };
      homepc = nixpkgs.lib.nixosSystem {
        specialArgs = {
	  inherit inputs;
	};
        modules = [
          # > Our main nixos configuration file <
          ./hosts/homepc/configuration.nix  	
	  stylix.nixosModules.stylix
	  sops-nix.nixosModules.sops
        ];
      };
    };

    # Standalone home-manager configuration entrypoint
    # Available through 'home-manager --flake .#your-username@your-hostname'
    homeConfigurations = {
      # FIXME add all users@hosts you need 
      "yarn@surface" = home-manager.lib.homeManagerConfiguration {
        # Home-manager requires 'pkgs' instance
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
	  inherit inputs;
	  flake-inputs = inputs;
	};
        modules = [
          # > Our main home-manager configuration file <
          ./hosts/surface/home.nix
	  stylix.homeModules.stylix
      	  sops-nix.homeManagerModules.sops
        ];
      };
      "yarn@homepc" = home-manager.lib.homeManagerConfiguration {
        # Home-manager requires 'pkgs' instance
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
	  inherit inputs;
	  flake-inputs = inputs;
	};
        modules = [
          # > Our main home-manager configuration file <
          ./hosts/homepc/home.nix
	  stylix.homeModules.stylix
      	  sops-nix.homeManagerModules.sops
        ];
      };    
    };
  };
}
