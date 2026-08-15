{ pkgs, ... }:
{
  environment.systemPackages = [
    pkgs.bubblewrap
  ];
}
