{ pkgs, ... }:

{
  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  services.displayManager.sddm = {
    wayland.enable = true;
    wayland.compositor = "kwin";
    extraPackages = [
      pkgs.nordzy-cursor-theme
    ];
    settings = {
      Theme = {
        CursorTheme = "Nordzy-cursors";
      };
    };
  };

  systemd.services.display-manager.environment = {
    KWIN_FORCE_SW_CURSOR = "1";
    KWIN_DRM_NO_AMS = "1";

    XCURSOR_THEME = "Nordzy-cursors";
    XCURSOR_SIZE = "24";
    KWIN_DRM_USE_MODIFIERS = "0";
    XCURSOR_PATH = "/run/current-system/sw/share/icons";
  };

  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    KWIN_FORCE_SW_CURSOR = "1";
    KWIN_DRM_NO_AMS = "1";
    XCURSOR_THEME = "Nordzy-cursors";
    XCURSOR_SIZE = "24";
  };
  environment.systemPackages = with pkgs; [
    nordzy-cursor-theme
  ];
}
