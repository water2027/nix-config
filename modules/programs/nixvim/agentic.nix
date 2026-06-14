{ pkgs, ... }:

let
  agentic-nvim = pkgs.vimUtils.buildVimPlugin {
    pname = "agentic.nvim";
    version = "2026-06-11";

    src = pkgs.fetchFromGitHub {
      owner = "carlos-algms";
      repo = "agentic.nvim";
      rev = "a19fee663aa8be5f46f0af6fc0b46427b0e75cf2";
      hash = "sha256-ZT1ME4E8jwC6DPLVpEgCudL8go91q7PkfJn5ylajmYA=";
    };
  };
in
{
  home.packages = [
    pkgs.codex-acp
  ];

  programs.nixvim = {
    extraPlugins = [
      agentic-nvim
    ];

    extraConfigLua = ''
      require("agentic").setup({
        provider = "codex-acp",
      })
    '';

    keymaps = [
      {
        mode = [
          "n"
          "v"
          "i"
        ];
        key = "<C-\\>";
        action.__raw = ''
          function()
            require("agentic").toggle()
          end
        '';
        options.desc = "Toggle Agentic chat";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<C-'>";
        action.__raw = ''
          function()
            require("agentic").add_selection_or_file_to_context()
          end
        '';
        options.desc = "Add file or selection to Agentic context";
      }
      {
        mode = [
          "n"
          "v"
          "i"
        ];
        key = "<C-,>";
        action.__raw = ''
          function()
            require("agentic").new_session()
          end
        '';
        options.desc = "New Agentic session";
      }
      {
        mode = [
          "n"
          "v"
          "i"
        ];
        key = "<A-i>r";
        action.__raw = ''
          function()
            require("agentic").restore_session()
          end
        '';
        options.desc = "Restore Agentic session";
      }
      {
        mode = "n";
        key = "<leader>ad";
        action.__raw = ''
          function()
            require("agentic").add_current_line_diagnostics()
          end
        '';
        options.desc = "Add current diagnostic to Agentic";
      }
      {
        mode = "n";
        key = "<leader>aD";
        action.__raw = ''
          function()
            require("agentic").add_buffer_diagnostics()
          end
        '';
        options.desc = "Add buffer diagnostics to Agentic";
      }
    ];
  };
}
