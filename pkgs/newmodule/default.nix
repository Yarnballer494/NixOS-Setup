{ pkgs }:

pkgs.writeShellScriptBin "newmodule" (builtins.readFile ./newmodule.sh)
