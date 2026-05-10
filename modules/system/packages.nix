{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    sops
    ssh-to-age
    devenv

    zip
    unzip
    p7zip
    gnutar
    lz4
    zstd
  ];
}
