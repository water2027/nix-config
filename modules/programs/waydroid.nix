{ pkgs, ... }:

{
  virtualisation.waydroid = {
    enable = true;
    package = pkgs.waydroid-nftables;
  };
  networking.firewall.trustedInterfaces = [ "waydroid0" ];
}
