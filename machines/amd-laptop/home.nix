{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ../../modules/home/common.nix
    ../../modules/programs/direnv.nix
    ../../modules/programs/emacs.nix
    ../../modules/programs/git.nix
    ../../modules/programs/kitty.nix
    ../../modules/programs/ssh.nix
    ../../modules/shell/zsh.nix
    ../../modules/desktop/hyprland/home.nix
    ../../modules/programs/vscode.nix
    ../../modules/programs/nixvim.nix
    ../../modules/themes/gtk/tokyo-night.nix
  ];

  my.git = {
    enable = true;
  };

  home.stateVersion = "25.11";

  fonts.fontconfig.enable = true;

  home.pointerCursor = {
    name = "Nordzy-cursors";
    package = pkgs.nordzy-cursor-theme;
    size = 24;
    gtk.enable = true; # 自动为 GTK 应用配置光标
    x11.enable = true; # 自动为 X11 / XWayland 应用配置光标
  };

  home.packages =
    (with inputs; [
      claude-code.packages.${pkgs.stdenv.hostPlatform.system}.default
    ])
    ++ (with pkgs; [
      google-chrome
      qq
      wechat
      feishu

      obsidian

      firefox

      codex

      maple-mono.NF-CN

      libreoffice-qt
    ]);
}
