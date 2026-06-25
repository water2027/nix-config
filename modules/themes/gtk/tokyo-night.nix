{ pkgs, ... }:
let
  myIconTheme = pkgs.papirus-icon-theme.override { color = "black"; };
in
{
  # 安装相关包
  home.packages = with pkgs; [
    tokyonight-gtk-theme
    # 推荐搭配的图标
    # (papirus-icon-theme.override { color = "black"; })
  ];

  gtk = {
    gtk4.theme = null;

    theme = {
      name = "Tokyonight-Dark"; # 请确保名字与包内路径一致
      package = pkgs.tokyonight-gtk-theme;
    };

    iconTheme = {
      name = "Papirus-Dark";
      package = myIconTheme;
    };

    # cursorTheme = {
    #   name = "Bibata-Modern-Ice";
    #   package = pkgs.bibata-cursors;
    # };

    gtk3.extraConfig.gtk-application-prefer-dark-theme = 1;
    gtk2.extraConfig = ''
      gtk-application-prefer-dark-theme = 1
    '';

  };
  xdg.configFile."gtk-4.0/assets".source =
    "${pkgs.tokyonight-gtk-theme}/share/themes/Tokyo-Night-Dark/gtk-4.0/assets";
  xdg.configFile."gtk-4.0/gtk.css".source =
    "${pkgs.tokyonight-gtk-theme}/share/themes/Tokyo-Night-Dark/gtk-4.0/gtk.css";
  xdg.configFile."gtk-4.0/gtk-dark.css".source =
    "${pkgs.tokyonight-gtk-theme}/share/themes/Tokyo-Night-Dark/gtk-4.0/gtk-dark.css";
}
