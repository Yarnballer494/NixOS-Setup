{
    description = "Flake of Yarn";
	
    inputs = {
		# Home Manager
		nixpkgs.url = "nixpkgs/nixos-25.11";
		nixpkgs-stable.url = "nixpkgs/nixos-25.11";

		home-manager = {
			url = "github:nix-community/home-manager/release-25.11";
			inputs.nixpkgs.follows = "nixpkgs";
		};
	};

	outputs = { nixpkgs, home-manager, ... }: { 
		nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
			system = "x86_64-linux";
			modules = [
				./configuration.nix
				home-manager.nixosModules.home-manager
				{
	    			home-manager = {
						useGlobalPkgs = true;
						useUserPackages = true;
						users.yarn = import ./home.nix;
						backupFileExtension = "backup";
					};
				}
			];
	    };
    };
}
