{
  programs.nixvim.keymaps = [
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "s";
      action.__raw = ''
        function()
          require("flash").jump()
        end
      '';
      options.desc = "Flash jump";
    }
    {
      mode = [
        "n"
        "x"
        "o"
      ];
      key = "S";
      action.__raw = ''
        function()
          require("flash").treesitter()
        end
      '';
      options.desc = "Flash treesitter";
    }
    {
      mode = "n";
      key = "<leader>ff";
      action = "<cmd>Telescope find_files<CR>";
      options.desc = "Find files";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>Telescope live_grep<CR>";
      options.desc = "Live grep";
    }
    {
      mode = "n";
      key = "<leader>fb";
      action = "<cmd>Telescope buffers<CR>";
      options.desc = "Find buffers";
    }
    {
      mode = "n";
      key = "<leader>fr";
      action = "<cmd>Telescope oldfiles<CR>";
      options.desc = "Recent files";
    }
    {
      mode = "n";
      key = "<leader>fh";
      action = "<cmd>Telescope help_tags<CR>";
      options.desc = "Help tags";
    }
    {
      mode = "n";
      key = "<leader>fd";
      action = "<cmd>Telescope diagnostics<CR>";
      options.desc = "Diagnostics";
    }
    {
      mode = "n";
      key = "<leader>cr";
      action = "<cmd>CompetiTest run<CR>";
      options.desc = "Run competitive tests";
    }
    {
      mode = "n";
      key = "<leader>cp";
      action = "<cmd>CompetiTest receive problem<CR>";
      options.desc = "Receive problem";
    }
    {
      mode = "n";
      key = "<leader>cc";
      action = "<cmd>CompetiTest receive contest<CR>";
      options.desc = "Receive contest";
    }
    {
      mode = "n";
      key = "<leader>ct";
      action = "<cmd>CompetiTest edit_testcase<CR>";
      options.desc = "Edit testcases";
    }
    {
      mode = "n";
      key = "<leader>xx";
      action = "<cmd>Trouble diagnostics toggle<CR>";
      options.desc = "Diagnostics";
    }
    {
      mode = "n";
      key = "<leader>xX";
      action = "<cmd>Trouble diagnostics toggle filter.buf=0<CR>";
      options.desc = "Buffer diagnostics panel";
    }
    {
      mode = "n";
      key = "gd";
      action = "<cmd>lua vim.lsp.buf.definition()<CR>";
      options.desc = "Go to definition";
    }
    {
      mode = "n";
      key = "gD";
      action = "<cmd>lua vim.lsp.buf.declaration()<CR>";
      options.desc = "Go to declaration";
    }
    {
      mode = "n";
      key = "gr";
      action = "<cmd>lua vim.lsp.buf.references()<CR>";
      options.desc = "References";
    }
    {
      mode = "n";
      key = "gi";
      action = "<cmd>lua vim.lsp.buf.implementation()<CR>";
      options.desc = "Implementation";
    }
    {
      mode = "n";
      key = "K";
      action = "<cmd>lua vim.lsp.buf.hover()<CR>";
      options.desc = "Hover";
    }
    {
      mode = "n";
      key = "<leader>ca";
      action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
      options.desc = "Code action";
    }
    {
      mode = "n";
      key = "[d";
      action = "<cmd>lua vim.diagnostic.jump({ count = -1, float = true })<CR>";
      options.desc = "Previous diagnostic";
    }
    {
      mode = "n";
      key = "]d";
      action = "<cmd>lua vim.diagnostic.jump({ count = 1, float = true })<CR>";
      options.desc = "Next diagnostic";
    }
    {
      mode = "n";
      key = "<leader>p";
      action = "<cmd>lua require('conform').format({ lsp_fallback = true })<CR>";
      options.desc = "Format file";
    }
    {
      mode = "n";
      key = "<leader>rn";
      action = "<cmd>lua vim.lsp.buf.rename()<CR>";
      options.desc = "Rename symbol";
    }
    {
      mode = "n";
      key = "<F5>";
      action = "<cmd>lua require('dap').continue()<CR>";
      options.desc = "DAP continue";
    }
    {
      mode = "n";
      key = "<F10>";
      action = "<cmd>lua require('dap').step_over()<CR>";
      options.desc = "DAP step over";
    }
    {
      mode = "n";
      key = "<F11>";
      action = "<cmd>lua require('dap').step_into()<CR>";
      options.desc = "DAP step into";
    }
    {
      mode = "n";
      key = "<F12>";
      action = "<cmd>lua require('dap').step_out()<CR>";
      options.desc = "DAP step out";
    }
    {
      mode = "n";
      key = "<leader>b";
      action = "<cmd>lua require('dap').toggle_breakpoint()<CR>";
      options.desc = "DAP breakpoint";
    }
    {
      mode = "n";
      key = "<leader>dr";
      action = "<cmd>DapToggleRepl<CR>";
      options.desc = "DAP toggle REPL";
    }
    {
      mode = "n";
      key = "<leader>du";
      action = "<cmd>lua require('dapui').toggle()<CR>";
      options.desc = "DAP toggle UI";
    }
    {
      mode = "n";
      key = "<leader>dl";
      action = "<cmd>lua require('dap').run_last()<CR>";
      options.desc = "DAP run last";
    }
  ];
}
