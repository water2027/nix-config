{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ../../modules/home/program-settings/emacs.nix
  ];

  home.packages = (
    with pkgs;
    [
      qq
      wechat
      feishu

      obsidian

      typst
      tinymist

      xmind

      maple-mono.NF-CN

      libreoffice-qt

      wireguard-tools
    ]
  );

  programs.emacs.enable = true;
}
