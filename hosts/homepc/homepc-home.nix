{ config, lib, pkgs, ... }:
{
  wayland.windowManager.hyprland.settings.monitor = [
    "DP-1, 2560x1440@144, 0x0, 1"
    "DP-2, 2560x1440@144, 2560x0, 1"
    ", preferred, auto, 1"
  ];
  wayland.windowManager.hyprland.settings.workspace = [
    "1, monitor:DP-1"
    "2, monitor:DP-2"
  ];
}
