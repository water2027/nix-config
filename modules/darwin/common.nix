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

  fonts.packages = with pkgs; [
    maple-mono.NF-CN
  ];

  environment.variables = {
    EDITOR = "vim";
  };

}
