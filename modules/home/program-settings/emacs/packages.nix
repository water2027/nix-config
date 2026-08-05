{ pkgs, lib, ... }:

{
  home.packages =
    (with pkgs; [
      clang-tools
      eslint_d
      prettier
      typstyle
      typescript
      typescript-language-server
      vtsls
      vscode-langservers-extracted
      vue-language-server
    ])
    ++ lib.optionals (!pkgs.stdenv.hostPlatform.isDarwin) (
      with pkgs;
      [
        wl-clipboard
      ]
    );

  programs.emacs = {
    extraPackages =
      epkgs: with epkgs; [
        apheleia
        cape
        consult
        corfu
        corfu-terminal
        diff-hl
        elfeed
        embark
        embark-consult
        envrc
        flymake-eslint
        less-css-mode
        magit
        marginalia
        markdown-mode
        modus-themes
        nix-mode
        org-download
        org-modern
        orderless
        org-roam
        pdf-tools
        typst-preview
        typst-ts-mode
        vertico
        vue-mode
        which-key
        yasnippet
        yasnippet-snippets
      ];
  };
}
