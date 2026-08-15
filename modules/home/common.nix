{
  pkgs,
  lib,
  username,
  ...
}:

let
  isDarwin = pkgs.stdenv.isDarwin;
  pnpmHome = if isDarwin then "$HOME/Library/pnpm" else "$HOME/.local/share/pnpm";
  fnmHome = if isDarwin then "$HOME/Library/Application Support/fnm" else "$HOME/.local/share/fnm";
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
    fnm
    pnpm
    python3
  ];

  home.sessionVariables = {
    PNPM_HOME = pnpmHome;
    FNM_DIR = fnmHome;
  };

  home.sessionPath = [
    "${pnpmHome}/bin"
    pnpmHome
    "${fnmHome}/aliases/default/bin"
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

}
