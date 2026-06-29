{ hyprctl }:

{
  bar = {
    background-opacity = 90;
    layout = [
      {
        center = [
        ];
        left = [
          "hyprland-workspaces"
          "systray"
        ];
        monitor = "*";
        right = [
          "battery"
          "bluetooth"
          "network"
          "clock"
          "volume"
          "notifications"
          "dashboard"
        ];
        show = true;
      }
    ];
  };
  general = {
    font-mono = "Maple Mono NF CN";
  };
  modules = {
    dashboard = {
      dropdown-logout-command = "${hyprctl} dispatch exit";
    };
    hyprland-workspaces = {
      min-workspace-count = 5;
    };
    weather = {
      time-format = "24h";
    };
    window-title = {
      label-max-length = 25;
    };
  };
  styling = {
    palette = {
      bg = "#16161e";
      blue = "#7dcfff";
      elevated = "#292e42";
      fg = "#c0caf5";
      fg-muted = "#a9b1d6";
      green = "#9ece6a";
      primary = "#7aa2f7";
      red = "#f7768e";
      surface = "#1a1b26";
      yellow = "#e0af68";
    };
  };
  wallpaper = {
    engine-enabled = false;
  };
}
