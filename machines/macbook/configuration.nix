{
  username,
  hostname,
  ...
}:

{
  imports = [
    ../../profiles/macbook/system.nix
  ];

  home-manager.users.${username}.imports = [
    ../../profiles/macbook/home.nix
    ./home.nix
  ];

  networking.hostName = hostname;

  system.stateVersion = 4;
}
