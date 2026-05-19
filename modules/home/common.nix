{
  pkgs,
  lib,
  username,
  ...
}:

let
  isDarwin = pkgs.stdenv.isDarwin;
in

{
  home.username = username;
  home.homeDirectory = if isDarwin then "/Users/${username}" else "/home/${username}";

  home.packages = with pkgs; [
    fastfetch
    btop
    ripgrep
    fd
    bat
    eza
    lazygit
  ];

  home.shellAliases = {
    ls = "eza";
    ll = "ls -lh";
    l = "ll -A";

    find = "fd";
    cat = "bat";

    cls = "clear";
  }
  // lib.optionalAttrs (!isDarwin) {
    sops = "SOPS_AGE_KEY=$(sudo ssh-to-age -private-key -i /etc/ssh/ssh_host_ed25519_key) sops";
  };

  programs.home-manager.enable = true;
}
