{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    proxychains-ng
    sops
    ssh-to-age

    zip
    unzip
    p7zip
    gnutar
    lz4
    zstd
  ];
}
