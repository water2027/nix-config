{
  username,
  hostname,
  ...
}:

{
  imports = [
    ../../profiles/darwin/personal-system.nix
  ];

  home-manager.users.${username}.imports = [
    ../../profiles/darwin/personal-home.nix
    ./home.nix
  ];

  networking.hostName = hostname;

  system.stateVersion = 4;
}
