{
  imports = [
    ../../modules/home/common.nix
    ../../modules/programs/direnv.nix
    ../../modules/programs/git.nix
    ../../modules/programs/nixvim.nix
    ../../modules/programs/vscode.nix
    ../../modules/shell/zsh.nix
  ];

  my.git = {
    enable = true;
  };

  home.stateVersion = "25.11";
}
