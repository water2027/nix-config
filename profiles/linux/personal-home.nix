{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ../../modules/home/common.nix
    ../../modules/home/program-settings/direnv.nix
    ../../modules/home/program-settings/emacs.nix
    ../../modules/home/program-settings/git.nix
    ../../modules/home/program-settings/kitty.nix
    ../../modules/home/program-settings/proxychains.nix
    ../../modules/home/program-settings/ssh.nix
    ../../modules/shell/zsh.nix
    ../../modules/desktop/hyprland/home.nix
    ../../modules/home/program-settings/nixvim.nix
    ../../modules/themes/gtk/tokyo-night.nix
  ];

  programs = {
    home-manager.enable = true;
    git.enable = true;
    direnv.enable = true;
    emacs = {
      enable = true;
      package = pkgs.emacs-pgtk;
    };
    fzf.enable = true;
    kitty.enable = true;
    nixvim.enable = true;
    ssh.enable = true;
    starship.enable = true;
    waybar.enable = true;
    wlogout.enable = true;
    zoxide.enable = true;
    zsh.enable = true;
  };

  wayland.windowManager.hyprland.enable = true;

  i18n.inputMethod.enable = true;

  my.git = {
    userName = "water";
    userEmail = "136900643+water2027@users.noreply.github.com";
  };

  gtk = {
    enable = true;
  };

  fonts.fontconfig.enable = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "inode/directory" = "thunar.desktop";
      "application/x-directory" = "thunar.desktop";
      "text/html" = "google-chrome.desktop";
      "x-scheme-handler/http" = "google-chrome.desktop";
      "x-scheme-handler/https" = "google-chrome.desktop";
      "x-scheme-handler/about" = "google-chrome.desktop";
      "x-scheme-handler/unknown" = "google-chrome.desktop";
      "x-scheme-handler/clash" = "clash-verge.desktop";
      "x-scheme-handler/clash-verge" = "clash-verge.desktop";
    };
  };

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
      firefox

      translate-shell

      codex
      pi-coding-agent
    ]);

  home.stateVersion = "25.11";
}
