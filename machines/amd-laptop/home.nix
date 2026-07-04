{
  inputs,
  pkgs,
  ...
}:

{
  imports = [
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
}
