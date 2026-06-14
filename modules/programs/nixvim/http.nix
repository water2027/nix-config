{
  lib,
  pkgs,
  ...
}:
{
  programs.nixvim = {
    filetype.extension = {
      http = "http";
      rest = "rest";
    };

    plugins.kulala = {
      enable = true;
      settings.curl_path = lib.getExe pkgs.curl;
    };

    keymaps = [
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>Rs";
        action.__raw = ''
          function()
            require("kulala").run()
          end
        '';
        options.desc = "Send request";
      }
      {
        mode = [
          "n"
          "v"
        ];
        key = "<leader>Ra";
        action.__raw = ''
          function()
            require("kulala").run_all()
          end
        '';
        options.desc = "Send all requests";
      }
      {
        mode = "n";
        key = "<leader>Rr";
        action.__raw = ''
          function()
            require("kulala").replay()
          end
        '';
        options.desc = "Replay request";
      }
      {
        mode = "n";
        key = "<leader>Rb";
        action.__raw = ''
          function()
            require("kulala").scratchpad()
          end
        '';
        options.desc = "Open scratchpad";
      }
      {
        mode = "n";
        key = "<leader>Ro";
        action.__raw = ''
          function()
            require("kulala").open()
          end
        '';
        options.desc = "Open Kulala";
      }
      {
        mode = "n";
        key = "<leader>Re";
        action.__raw = ''
          function()
            require("kulala").set_selected_env()
          end
        '';
        options.desc = "Select environment";
      }
      {
        mode = "n";
        key = "<leader>Ri";
        action.__raw = ''
          function()
            require("kulala").inspect()
          end
        '';
        options.desc = "Inspect request";
      }
      {
        mode = "n";
        key = "<leader>Rc";
        action.__raw = ''
          function()
            require("kulala").copy()
          end
        '';
        options.desc = "Copy as cURL";
      }
    ];
  };
}
