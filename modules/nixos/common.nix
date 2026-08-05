{
  pkgs,
  inputs,
  lib,
  username,
  ...
}:

let
  proxy = "http://127.0.0.1:20172";
  noProxy = lib.concatStringsSep "," [
    "127.0.0.1"
    "localhost"
    "::1"
    ".cn"
    "mirrors.tuna.tsinghua.edu.cn"
    ".tuna.tsinghua.edu.cn"
    "mirrors.ustc.edu.cn"
    ".ustc.edu.cn"
  ];
in
{
  imports = [
    ../nix/common.nix
    ../system/packages.nix
    inputs.home-manager.nixosModules.home-manager
  ];

  systemd.tmpfiles.rules = [
    "d /home/${username}/.ssh 0700 ${username} users - -"
  ];

  time.timeZone = lib.mkDefault "Asia/Shanghai";
  i18n.defaultLocale = lib.mkDefault "zh_CN.UTF-8";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  nix.settings.auto-optimise-store = true;

  systemd.services.nix-daemon.environment = {
    http_proxy = proxy;
    https_proxy = proxy;
    HTTP_PROXY = proxy;
    HTTPS_PROXY = proxy;
    no_proxy = noProxy;
    NO_PROXY = noProxy;
  };

  environment.enableAllTerminfo = false;

  environment.sessionVariables = {
    EDITOR = "vim";
    NIXOS_OZONE_WL = "1";
  };

  environment.systemPackages = with pkgs; [
    unrar
  ];
}
