{
  wayland.windowManager.hyprland.settings = {
    config = {
      general = {
        gaps_in = 0;
        gaps_out = 15;
        border_size = 1;

        "col.active_border" = {
          colors = [
            "rgba(33ccffee)"
            "rgba(00ff99ee)"
          ];
          angle = 45;
        };
        "col.inactive_border" = "rgba(595959aa)";

        resize_on_border = false;
        allow_tearing = false;
        layout = "scrolling";
      };

      render = {
        direct_scanout = true;
      };
    };
  };
}
