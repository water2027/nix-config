{
  username,
  ...
}:

{
  sops = {
    # 默认加密文件路径
    defaultSopsFile = ./keys.yaml;
    # 默认导入格式
    defaultSopsFormat = "yaml";

    age.sshKeyPaths = [ "/etc/ssh/ssh_host_ed25519_key" ];

    secrets = {
      github_token_nix = {
        owner = username;
      };
      ssh_key = {
        owner = username;
        group = "users";

        mode = "0400";
      };
      dsapi_key = {
        owner = username;
        group = "users";

        mode = "0400";
      };
    };
  };
}
