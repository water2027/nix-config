{
  description = "water's nixos config";

  inputs = {
    nixpkgs = {
      url = "github:nixos/nixpkgs/nixos-unstable";
    };

    darwin = {
      url = "github:lnl7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
    };

    claude-code = {
      url = "github:ryoppippi/nix-claude-code";
    };

    devenv = {
      url = "github:cachix/devenv";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:Mic92/sops-nix";
    };

    rime-ice = {
      url = "github:iDvel/rime-ice";
      flake = false;
    };
  };

  outputs =
    {
      nixpkgs,
      darwin,
      ...
    }@inputs:
    let
      mkPkgs =
        system:
        import nixpkgs {
          inherit system;
          config.allowUnfree = true;
          overlays = [
            inputs.nix-vscode-extensions.overlays.default
          ];
        };
      mkHost =
        {
          system,
          username,
          hostname,
        }:
        nixpkgs.lib.nixosSystem {
          system = system;
          pkgs = mkPkgs system;
          specialArgs = {
            inherit inputs;
            username = username;
            hostname = hostname;
          };
          modules = [
            ./machines/${hostname}/configuration.nix
          ];
        };
      mkDarwinHost =
        {
          system,
          username,
          hostname,
        }:
        darwin.lib.darwinSystem {
          system = system;
          pkgs = mkPkgs system;
          specialArgs = {
            inherit inputs;
            username = username;
            hostname = hostname;
          };
          modules = [
            ./machines/${hostname}/configuration.nix
          ];
        };
    in
    {
      nixosConfigurations = {
        "linux-dev" = mkHost {
          hostname = "linux-dev";
          system = "x86_64-linux";
          username = "water";
        };
        "amd-laptop" = mkHost {
          hostname = "amd-laptop";
          system = "x86_64-linux";
          username = "water";
        };
      };
      darwinConfigurations = {
        "macbook" = mkDarwinHost {
          hostname = "macbook";
          system = "aarch64-darwin";
          username = "water";
        };
      };
    };
}
