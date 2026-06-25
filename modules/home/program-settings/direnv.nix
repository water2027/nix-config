{ ... }:

{
  programs.direnv = {
    nix-direnv.enable = true;
    enableZshIntegration = true;
  };
}
