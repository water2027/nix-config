{
  pkgs,
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
  proxyEnv = {
    http_proxy = proxy;
    https_proxy = proxy;
    HTTP_PROXY = proxy;
    HTTPS_PROXY = proxy;
    no_proxy = noProxy;
    NO_PROXY = noProxy;
  };
in
{
  # environment.variables = proxyEnv;

  nix.envVars = proxyEnv;

  nix.settings = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://mirrors.ustc.edu.cn/nix-channels/store"
      "https://mic92.cachix.org"
      "https://cache.nixos.org/"
      "https://cachix.cachix.org"
    ];
    trusted-public-keys = [
      "mic92.cachix.org-1:989jAFSSgnOO13fBvEL8S2tCbcH8AfQNHkOIdSiv9Ww="
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "cachix.cachix.org-1:eWNHQldwUO7G2VkjpnjDbWwy4KQ/HNxht7H4SSoMckM="
    ];
    trusted-users = [
      username
    ]
    ++ lib.optionals pkgs.stdenv.isLinux [ "@wheel" ]
    ++ lib.optionals pkgs.stdenv.isDarwin [ "@admin" ];
  };

  nix.gc = {
    automatic = true;
    options = "--delete-older-than 7d";
  }
  // lib.optionalAttrs pkgs.stdenv.isLinux {
    dates = "weekly";
  }
  // lib.optionalAttrs pkgs.stdenv.isDarwin {
    interval = {
      Weekday = 0;
      Hour = 3;
      Minute = 15;
    };
  };
}
