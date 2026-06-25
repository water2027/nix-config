{
  imports = [
    ../../modules/home/common.nix
    ../../modules/programs/direnv.nix
    ../../modules/programs/git.nix
    ../../modules/programs/kitty.nix
    ../../modules/programs/nixvim.nix
    ../../modules/programs/vscode.nix
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

  my.git = {
    userName = "water";
    userEmail = "136900643+water2027@users.noreply.github.com";
  };

  home.stateVersion = "25.11";
}
