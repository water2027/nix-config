{
  config,
  inputs,
  pkgs,
  username,
  ...
}:

{
  imports = [
    ../../modules/home/common.nix
    ../../modules/programs/direnv.nix
    ../../modules/programs/git.nix
    ../../modules/shell/zsh.nix
  ];

  my.git = {
    enable = true;
  };

  home.stateVersion = "25.11";

  home.packages = with pkgs; [
  ];
}
