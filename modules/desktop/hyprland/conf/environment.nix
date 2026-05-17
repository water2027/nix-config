{ config, ... }:
{
  wayland.windowManager.hyprland.settings = {
    env = [
      {
        _args = [
          "GTK_THEME"
          "Tokyonight-Dark"
        ];
      }
      {
        _args = [
          "XCURSOR_THEME"
          "Nordzy-cursors"
        ];
      }
      {
        _args = [
          "XCURSOR_SIZE"
          "24"
        ];
      }
      {
        _args = [
          "HYPRCURSOR_SIZE"
          "24"
        ];
      }

      {
        _args = [
          "HYPRLAND_INTERACTIVE_SCREENSHOT_SAVEDIR"
          "${config.home.homeDirectory}/Pictures/Screenshots/"
        ];
      }
    ];
  };
}
