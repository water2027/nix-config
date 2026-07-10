{ pkgs, ... }:

{
  home.packages = with pkgs; [
    clang-tools
    typescript
    typescript-language-server
  ];

  programs.emacs = {
    extraPackages =
      epkgs: with epkgs; [
        cape
        consult
        corfu
        corfu-terminal
        diff-hl
        elfeed
        embark
        embark-consult
        envrc
        magit
        marginalia
        markdown-mode
        modus-themes
        nix-mode
        org-modern
        orderless
        org-roam
        pdf-tools
        typescript-mode
        vertico
        which-key
        yasnippet
        yasnippet-snippets
      ];
  };
}
