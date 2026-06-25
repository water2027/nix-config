{ username, ... }:

{
  users.users."${username}".extraGroups = [ "libvirtd" ];
}
