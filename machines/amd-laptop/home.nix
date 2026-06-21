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
    ../../modules/programs/proxychains.nix
    ../../modules/programs/ssh.nix
    ../../modules/shell/zsh.nix
    ../../modules/desktop/hyprland/home.nix
    # ../../modules/programs/vscode.nix
    ../../modules/programs/nixvim.nix
    ../../modules/themes/gtk/tokyo-night.nix
  ];

  my.git = {
    enable = true;
  };

  home.stateVersion = "25.11";

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
      qq
      wechat
      feishu

      translate-shell

      obsidian

      firefox

      codex
      pi-coding-agent

      typst
      tinymist

      zathura
      zathuraPkgs.zathura_pdf_mupdf

      maple-mono.NF-CN

      libreoffice-qt
    ]);
}
