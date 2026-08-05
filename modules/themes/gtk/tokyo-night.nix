{ pkgs, ... }:
let
  myIconTheme = pkgs.papirus-icon-theme.override { color = "black"; };
in
{
  # 安装相关包
  home.packages = with pkgs; [
    colloid-gtk-theme
    # 推荐搭配的图标
    # (papirus-icon-theme.override { color = "black"; })
  ];

  # 声明式写入系统颜色偏好，Chrome 等应用通过
  # org.gnome.desktop.interface.color-scheme 感知深色模式。
  dconf = {
    enable = true;
    settings."org/gnome/desktop/interface".color-scheme = "prefer-dark";
  };

  gtk = {
    gtk4.theme = null;

    theme = {
      name = "Colloid-Dark"; # 请确保名字与包内路径一致
      package = pkgs.colloid-gtk-theme;
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
    "${pkgs.colloid-gtk-theme}/share/themes/Colloid-Dark/gtk-4.0/assets";
  xdg.configFile."gtk-4.0/gtk.css".source =
    "${pkgs.colloid-gtk-theme}/share/themes/Colloid-Dark/gtk-4.0/gtk.css";
  xdg.configFile."gtk-4.0/gtk-dark.css".source =
    "${pkgs.colloid-gtk-theme}/share/themes/Colloid-Dark/gtk-4.0/gtk-dark.css";
}
