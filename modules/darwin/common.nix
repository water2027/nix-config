{
  inputs,
  pkgs,
  username,
  ...
}:

{
  imports = [
    inputs.home-manager.darwinModules.home-manager
    ../system/packages.nix
  ];

  system.primaryUser = username;

  users.users.${username}.home = "/Users/${username}";

  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;
    sharedModules = [
      inputs.nixvim.homeModules.nixvim
    ];
  };

  programs.zsh.enable = true;

  fonts.packages = with pkgs; [
    maple-mono.NF-CN
  ];

  environment.enableAllTerminfo = true;
  environment.variables = {
    EDITOR = "vim";
  };

}
