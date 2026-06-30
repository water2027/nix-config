{ pkgs, ... }:

{
  services.v2raya = {
    cliPackage = pkgs.xray;
  };
}
