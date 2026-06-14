{ pkgs, ... }:
{
  programs.nixvim.plugins = {
    treesitter = {
      enable = true;
      grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
        bash
        c
        cmake
        cpp
        css
        diff
        dockerfile
        go
        gomod
        gosum
        html
        javascript
        json
        json5
        lua
        markdown
        markdown_inline
        nix
        python
        regex
        rust
        toml
        typst
        tsx
        typescript
        vim
        vue
        yaml
      ];
      settings = {
        highlight.enable = true;
        indent.enable = true;
      };
    };

    treesitter-context.enable = true;

    nvim-ufo = {
      enable = true;
      setupLspCapabilities = true;
    };
  };
}
