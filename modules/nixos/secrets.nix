{
  config,
  inputs,
  ...
}:

{
  imports = [
    inputs.sops-nix.nixosModules.sops
    ../../secrets/sops.nix
  ];

  nix.extraOptions = ''
    !include ${config.sops.secrets.github_token_nix.path}
  '';
}
