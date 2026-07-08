{ pkgs, ... }:

{
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
        elfeed
        magit
        marginalia
        markdown-mode
        modus-themes
        nix-mode
        org-roam
        pdf-tools
        vertico
        which-key
        yasnippet
        yasnippet-snippets
      ];
  };
}
