{
  pkgs,
  inputs,
  ...
}:

{
  imports = [
    inputs.silentSDDM.nixosModules.default
  ];

  boot.initrd.kernelModules = [ "amdgpu" ];
  services.xserver.videoDrivers = [ "amdgpu" ];

  programs.silentSDDM = {
    enable = true;
    theme = "silvia";
    settings = {
      "General" = {
        scale = 1.6;
      };
    };
  };

  services.displayManager.sddm = {
    settings = {
      Theme = {
        CursorTheme = "Nordzy-cursors";
        CursorSize = 24;
      };
    };
  };

  environment.systemPackages = [ pkgs.nordzy-cursor-theme ];
}
