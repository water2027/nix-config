{
  imports = [
    ../../modules/home/common.nix
    ../../modules/home/program-settings/direnv.nix
    ../../modules/home/program-settings/git.nix
    ../../modules/home/program-settings/kitty.nix
    ../../modules/home/program-settings/nixvim.nix
    ../../modules/home/program-settings/vscode.nix
    ../../modules/shell/zsh.nix
  ];

  programs = {
    home-manager.enable = true;
    git.enable = true;
    direnv.enable = true;
    fzf.enable = true;
    kitty.enable = true;
    nixvim.enable = true;
    starship.enable = true;
    vscode = {
      enable = true;
      package = null;
    };
    zoxide.enable = true;
    zsh.enable = true;
  };

  home.stateVersion = "25.11";
}
