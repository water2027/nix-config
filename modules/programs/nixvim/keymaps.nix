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
      action = "<cmd>FzfLua files<CR>";
      options.desc = "Find files";
    }
    {
      mode = "n";
      key = "<leader>fg";
      action = "<cmd>FzfLua live_grep<CR>";
      options.desc = "Live grep";
    }
    {
      mode = "n";
      key = "<leader>fb";
      action = "<cmd>FzfLua buffers<CR>";
      options.desc = "Find buffers";
    }
    {
      mode = "n";
      key = "<leader>fr";
      action = "<cmd>FzfLua oldfiles<CR>";
      options.desc = "Recent files";
    }
    {
      mode = "n";
      key = "<leader>fh";
      action = "<cmd>FzfLua helptags<CR>";
      options.desc = "Help tags";
    }
    {
      mode = "n";
      key = "<leader>fd";
      action = "<cmd>FzfLua diagnostics_workspace<CR>";
      options.desc = "Diagnostics";
    }
    {
      mode = "n";
      key = "<leader>fs";
      action = "<cmd>FzfLua lsp_document_symbols<CR>";
      options.desc = "Document symbols";
    }
    {
      mode = "n";
      key = "<leader>fS";
      action = "<cmd>FzfLua lsp_workspace_symbols<CR>";
      options.desc = "Workspace symbols";
    }
    {
      mode = "n";
      key = "<leader>fl";
      action = "<cmd>FzfLua lsp_finder<CR>";
      options.desc = "LSP finder";
    }
    {
      mode = "n";
      key = "<leader>fq";
      action = "<cmd>FzfLua quickfix<CR>";
      options.desc = "Quickfix";
    }
    {
      mode = "n";
      key = "<leader>fk";
      action = "<cmd>FzfLua keymaps<CR>";
      options.desc = "Keymaps";
    }
    {
      mode = "n";
      key = "<leader>fc";
      action = "<cmd>FzfLua commands<CR>";
      options.desc = "Commands";
    }
    {
      mode = "n";
      key = "<leader>f/";
      action = "<cmd>FzfLua blines<CR>";
      options.desc = "Buffer lines";
    }
    {
      mode = "n";
      key = "<leader>sr";
      action = "<cmd>GrugFar<CR>";
      options.desc = "Search and replace";
    }
    {
      mode = "x";
      key = "<leader>sr";
      action.__raw = ''
        function()
          require("grug-far").with_visual_selection()
        end
      '';
      options.desc = "Search selection";
    }
    {
      mode = "n";
      key = "<leader>sw";
      action.__raw = ''
        function()
          require("grug-far").open({
            prefills = {
              search = vim.fn.expand("<cword>"),
              flags = "--fixed-strings --word-regexp",
            },
          })
        end
      '';
      options.desc = "Search word";
    }
    {
      mode = "n";
      key = "<leader>sR";
      action.__raw = ''
        function()
          require("grug-far").open({
            prefills = {
              paths = vim.fn.expand("%"),
            },
          })
        end
      '';
      options.desc = "Search file";
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
      action = "<cmd>lua MiniFiles.open(vim.api.nvim_buf_get_name(0), false)<CR>";
      options.desc = "Open file explorer";
    }
    {
      mode = "n";
      key = "<leader>yp";
      action.__raw = ''
        function()
          local path = vim.fn.expand("%:p")
          if path == "" then
            vim.notify("No file path to copy", vim.log.levels.WARN)
            return
          end

          vim.fn.setreg("+", path)
          vim.notify("Copied file path: " .. path)
        end
      '';
      options.desc = "Copy file path";
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
      key = "<leader>cr";
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
      key = "<leader>dB";
      action.__raw = ''
        function()
          require("dap").clear_breakpoints()
        end
      '';
      options.desc = "DAP clear breakpoints";
    }
    {
      mode = "n";
      key = "<leader>db";
      action = "<cmd>lua require('dap').toggle_breakpoint()<CR>";
      options.desc = "DAP breakpoint";
    }
    {
      mode = "n";
      key = "<leader>dc";
      action.__raw = ''
        function()
          vim.ui.input({ prompt = "Breakpoint condition: " }, function(condition)
            if condition and condition ~= "" then
              require("dap").set_breakpoint(condition)
            end
          end)
        end
      '';
      options.desc = "DAP conditional breakpoint";
    }
    {
      mode = "n";
      key = "<leader>dh";
      action.__raw = ''
        function()
          vim.ui.input({ prompt = "Hit condition: " }, function(hit_condition)
            if hit_condition and hit_condition ~= "" then
              require("dap").set_breakpoint(nil, hit_condition)
            end
          end)
        end
      '';
      options.desc = "DAP hit condition breakpoint";
    }
    {
      mode = "n";
      key = "<leader>dl";
      action.__raw = ''
        function()
          vim.ui.input({ prompt = "Log point message: " }, function(log_message)
            if log_message and log_message ~= "" then
              require("dap").set_breakpoint(nil, nil, log_message)
            end
          end)
        end
      '';
      options.desc = "DAP log point";
    }
    {
      mode = "n";
      key = "<leader>dq";
      action.__raw = ''
        function()
          require("dap").terminate()
          require("dapui").close()
        end
      '';
      options.desc = "DAP terminate";
    }
    {
      mode = "n";
      key = "<leader>dw";
      action.__raw = ''
        function()
          require("dap.ui.widgets").hover()
        end
      '';
      options.desc = "DAP hover variable";
    }
    {
      mode = "v";
      key = "<leader>dw";
      action.__raw = ''
        function()
          require("dap.ui.widgets").visual_hover()
        end
      '';
      options.desc = "DAP hover selection";
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
      key = "<leader>dL";
      action = "<cmd>lua require('dap').run_last()<CR>";
      options.desc = "DAP run last";
    }
  ];
}
