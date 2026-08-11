{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
    ../../modules/home/program-settings/emacs.nix
    ../../modules/home/program-settings/obs.nix
  ];

  home.packages = (
    with pkgs;
    [
      wechat
      feishu

      typst
      tinymist

      maple-mono.NF-CN

      libreoffice-qt

      wireguard-tools
    ]
  );

  programs.emacs.enable = true;
}
