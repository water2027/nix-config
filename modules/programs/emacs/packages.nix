{ pkgs, ... }:

{
  programs.emacs = {
    extraPackages =
      epkgs: with epkgs; [
        consult
        cape
        corfu
        elfeed
        evil
        evil-collection
        magit
        marginalia
        markdown-mode
        orderless
        org-roam
        pdf-tools
        vertico
        which-key
        yasnippet
        yasnippet-snippets
      ];
  };
}
