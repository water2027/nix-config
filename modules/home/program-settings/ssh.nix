{
  config,
  osConfig,
  lib,
  ...
}:

let
  publicKey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHWVsNhjx5eAEaXUXVAC5KGme6KNf6UJyv03khTHktVR water@w4ter.com";
in
{
  programs.ssh = {
    settings = {
      "github.com" = {
        HostName = "ssh.github.com";
        User = "git";
        Port = 443;
      };
    };
    extraConfig = ''
      Include ~/.ssh/config.local
    '';
  };

  home.activation.createSshDir = lib.hm.dag.entryBefore [ "checkLinkTargets" ] ''
    mkdir -p ${config.home.homeDirectory}/.ssh
    chmod 700 ${config.home.homeDirectory}/.ssh
  '';
  home.file = {
    ".ssh/id_ed25519".source = config.lib.file.mkOutOfStoreSymlink osConfig.sops.secrets.ssh_key.path;
    ".ssh/id_ed25519.pub".text = publicKey;
  };
}
