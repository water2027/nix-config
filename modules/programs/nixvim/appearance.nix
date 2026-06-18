{
  programs.nixvim = {
    colorscheme = "monokai-pro";
    opts.showtabline = 2;

    colorschemes = {
      monokai-pro = {
        enable = true;
        settings = {
          filter = "pro";
          transparent_background = true;
        };
      };
    };

    plugins = {
      web-devicons.enable = true;
      nui.enable = true;

      dashboard = {
        enable = true;
        settings = {
          theme = "hyper";
          change_to_vcs_root = true;
          config = {
            packages.enable = false;
            project.enable = false;
            mru = {
              limit = 8;
              cwd_only = false;
            };
            header = [
              ""
              "      N I X V I M"
              ""
            ];
            shortcut = [
              {
                icon = "F ";
                desc = "Find files";
                group = "Label";
                key = "f";
                action = "FzfLua files";
              }
              {
                icon = "G ";
                desc = "Live grep";
                group = "Label";
                key = "g";
                action = "FzfLua live_grep";
              }
              {
                icon = "R ";
                desc = "Recent files";
                group = "Label";
                key = "r";
                action = "FzfLua oldfiles";
              }
              {
                icon = "N ";
                desc = "New file";
                group = "Label";
                key = "n";
                action = "enew";
              }
              {
                icon = "Q ";
                desc = "Quit";
                group = "Label";
                key = "q";
                action = "qa";
              }
            ];
            footer = [ "Ready." ];
          };
        };
      };

      notify = {
        enable = true;
        settings = {
          timeout = 3000;
          render = "compact";
          stages = "fade_in_slide_out";
          top_down = false;
          background_colour = "#000000";
        };
      };

      noice = {
        enable = true;
        settings = {
          cmdline = {
            enabled = true;
            view = "cmdline_popup";
          };
          messages = {
            enabled = true;
            view = "notify";
            view_error = "notify";
            view_warn = "notify";
            view_history = "messages";
            view_search = "virtualtext";
          };
          notify = {
            enabled = true;
            view = "notify";
          };
          popupmenu = {
            enabled = true;
            backend = "nui";
          };
          lsp = {
            progress = {
              enabled = true;
              view = "mini";
            };
            override = {
              "vim.lsp.util.convert_input_to_markdown_lines" = true;
              "vim.lsp.util.stylize_markdown" = true;
              "cmp.entry.get_documentation" = true;
            };
          };
          presets = {
            bottom_search = true;
            command_palette = true;
            long_message_to_split = true;
            inc_rename = false;
            lsp_doc_border = true;
          };
        };
      };

      lualine = {
        enable = true;
        settings = {
          options = {
            globalstatus = true;
          };
          sections = {
            lualine_x = [
              {
                __unkeyed-1.__raw = ''
                  function()
                    local register = vim.fn.reg_recording()
                    if register == "" then
                      return ""
                    end

                    return "REC @" .. register
                  end
                '';
                color = {
                  fg = "#ff6188";
                  gui = "bold";
                };
              }
              "encoding"
              "fileformat"
              "filetype"
            ];
          };
          tabline = {
            lualine_a = [
              {
                __unkeyed-1 = "tabs";
                mode = 2;
                path = 0;
              }
            ];
            lualine_b = [ ];
            lualine_c = [ ];
            lualine_x = [ ];
            lualine_y = [ ];
            lualine_z = [ ];
          };
        };
      };
    };

    extraConfigLua = ''
      vim.api.nvim_create_autocmd({ "RecordingEnter", "RecordingLeave" }, {
        callback = function()
          vim.schedule(function()
            pcall(require("lualine").refresh, { place = { "statusline" } })
          end)
        end,
      })
    '';
  };
}
