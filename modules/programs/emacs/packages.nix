{ pkgs, ... }:

{
  home.packages = with pkgs; [
    texlab
  ];

  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;

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
        auctex
        cdlatex
      ];
  };
}
