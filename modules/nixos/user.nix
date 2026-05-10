{ username, ... }:

{
  users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    openssh.authorizedKeys.keys = [
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHWVsNhjx5eAEaXUXVAC5KGme6KNf6UJyv03khTHktVR water@w4ter.com"
    ];
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
}
