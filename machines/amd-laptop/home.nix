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

      maple-mono.NF-CN

      libreoffice-qt
    ]
  );
}
