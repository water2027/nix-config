{ config, lib, ... }:

with lib;
{
  options.my.git = {
    userName = mkOption {
      type = types.str;
      default = "water";
      description = "Git user name to use.";
    };

    userEmail = mkOption {
      type = types.str;
      default = "136900643+water2027@users.noreply.github.com";
      description = "Git user email to use.";
    };
  };

  config = {
    programs.git = {
      settings = {
        user = {
          name = config.my.git.userName;
          email = config.my.git.userEmail;
        };

        http."https://github.com/".proxy = "http://127.0.0.1:20171";
        http."https://www.github.com/".proxy = "http://127.0.0.1:20171";
      };
    };
  };
}
