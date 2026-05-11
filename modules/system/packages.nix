{ inputs, pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    vim
    wget
    curl
    sops
    ssh-to-age
    inputs.devenv.packages.${pkgs.stdenv.hostPlatform.system}.devenv

    zip
    unzip
    p7zip
    gnutar
    lz4
    zstd
  ];
}
