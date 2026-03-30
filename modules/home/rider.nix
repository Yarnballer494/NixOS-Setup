{ config, lib, pkgs, flake-inputs, ... }:

let 
  cfg = config.rider;
  # https://huantian.dev/blog/unity3d-rider-nixos/
  rider = pkgs.jetbrains.rider.overrideAttrs (attrs: {
    postInstall = ''
      # Wrap rider with extra tools and libraries
      mv $out/bin/rider $out/bin/.rider-toolless
      makeWrapper $out/bin/.rider-toolless $out/bin/rider \
        --argv0 rider \
        --prefix PATH : "${lib.makeBinPath extra-path}" \
        --prefix LD_LIBRARY_PATH : "${lib.makeLibraryPath extra-lib}"
  
      # Making unity rider plugin work
      # The plugin expects the binary to be at /rider/bin/rider, with bundled files at /rider/
      # It does this by going up two directories from the binary path
      # Our rider binary is at $out/bin/rider, so we need to link $out/rider/ to $out/
      shopt -s extglob
      ln -s $out/rider/!(bin) $out/
      shopt -u extglob
      '' + attrs.postInstall or "";
  });
  extra-path = with pkgs; [
      # Add any extra binaries you want accessible to rider
  ];
  extra-lib = with pkgs; [
    # Add any extra libraries you want accessible to rider
  ];

in
{
  options = {
    rider.enable = lib.mkEnableOption "Enable rider";
  };  

  config = lib.mkIf cfg.enable {
    home.packages = with pkgs; [
      (flake-inputs.nix-jetbrains-plugins.lib.buildIdeWithPlugins pkgs "rider" [
      # Add plugins here (potentially need more setup, check repo of nix-jetbrains-plugins)
      ])
      # Needed for unity development
      dotnet-sdk_9
      dotnet-runtime_9
    ];

    # Create dummy desktop file to allow unity to find rider
    home.file = {
      ".local/share/applications/jetbrains-rider.desktop".source =
        let
          desktopFile = pkgs.makeDesktopItem {
            name = "jetbrains-rider";
            desktopName = "Rider";
            exec = "\"${rider}/bin/rider\"";
            icon = "rider";
            type = "Application";
            # Don't show desktop icon in search or run launcher
            extraConfig.NoDisplay = "true";
          };
        in
        "${desktopFile}/share/applications/jetbrains-rider.desktop";
    }; 
  };
}
