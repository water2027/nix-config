{ pkgs, ... }:
{
  programs.nixvim = {
    extraPlugins = with pkgs.vimPlugins; [
      competitest-nvim
    ];

    extraConfigLua = ''
      require("competitest").setup({
        received_problems_path = "$(HOME)/code/competitive/$(JUDGE)/$(PROBLEM).$(FEXT)",
        received_contests_directory = "$(HOME)/code/competitive/$(JUDGE)/$(CONTEST)",
        received_contests_problems_path = "$(PROBLEM).$(FEXT)",
        testcases_directory = "$(HOME)/code/competitive/testcases",
        companion_port = 27121,
        open_received_problems = true,
        open_received_contests = true,
      })
    '';

  };
}
