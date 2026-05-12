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
      key = "<leader>lm";
      action = "<cmd>Leet<CR>";
      options.desc = "LeetCode menu";
    }
    {
      mode = "n";
      key = "<leader>ll";
      action = "<cmd>Leet list<CR>";
      options.desc = "LeetCode list";
    }
    {
      mode = "n";
      key = "<leader>lt";
      action = "<cmd>Leet run<CR>";
      options.desc = "LeetCode run";
    }
    {
      mode = "n";
      key = "<leader>ls";
      action = "<cmd>Leet submit<CR>";
      options.desc = "LeetCode submit";
    }
    {
      mode = "n";
      key = "<leader>ld";
      action = "<cmd>Leet daily<CR>";
      options.desc = "LeetCode daily";
    }
    {
      mode = "n";
      key = "<leader>lr";
      action = "<cmd>Leet random<CR>";
      options.desc = "LeetCode random";
    }
    {
      mode = "n";
      key = "<leader>lL";
      action = "<cmd>Leet lang<CR>";
      options.desc = "LeetCode language";
    }
    {
      mode = "n";
      key = "<leader>lu";
      action = "<cmd>Leet cookie update<CR>";
      options.desc = "LeetCode cookie";
    }
    {
      mode = "n";
      key = "<leader>e";
      action = "<cmd>Oil<CR>";
      options.desc = "Open file explorer";
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
      key = "<leader>cf";
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
      key = "<leader>/";
      action.__raw = ''
        function()
          require("Comment.api").toggle.linewise.current()
        end
      '';
      options.desc = "Toggle comment";
    }
    {
      mode = "x";
      key = "<leader>/";
      action.__raw = ''
        function()
          vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<ESC>", true, false, true), "nx", false)
          require("Comment.api").toggle.linewise(vim.fn.visualmode())
        end
      '';
      options.desc = "Toggle comment";
    }
    {
      mode = "t";
      key = "<Esc>";
      action = "<C-\\><C-n>";
      options.desc = "Exit terminal mode";
    }
    {
      mode = "n";
      key = "<leader>tt";
      action = "<cmd>ToggleTerm direction=float<CR>";
      options.desc = "Toggle terminal";
    }
    {
      mode = "n";
      key = "<C-t>";
      action = "<cmd>ToggleTerm direction=float<CR>";
      options.desc = "Toggle terminal";
    }
    {
      mode = "n";
      key = "<leader>th";
      action = "<cmd>ToggleTerm direction=horizontal<CR>";
      options.desc = "Horizontal terminal";
    }
    {
      mode = "n";
      key = "<leader>tv";
      action = "<cmd>ToggleTerm direction=vertical<CR>";
      options.desc = "Vertical terminal";
    }
    {
      mode = "t";
      key = "<C-t>";
      action = "<C-\\><C-n><cmd>ToggleTerm<CR>";
      options.desc = "Toggle terminal";
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
