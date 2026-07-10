{ pkgs, ... }:

{
  home.packages = with pkgs; [
    clang-tools
    typescript
    typescript-language-server
  ];

  programs.emacs = {
    overrides = self: super: {
      org = super.org.overrideAttrs (old: {
        src = pkgs.fetchurl {
          inherit (old.src) urls;
          hash = "sha256-QyrhwAW55Y4vtgMbIjSQOkNr+8uTSmXdumi2qc8dTIE=";
        };
      });
    };

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
