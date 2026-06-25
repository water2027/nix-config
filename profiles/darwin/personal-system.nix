{
  inputs,
  username,
  ...
}:

{
  imports = [
    ../../modules/nix/common.nix
    ../../modules/darwin/common.nix
  ];

  home-manager = {
    extraSpecialArgs = { inherit inputs username; };
  };

  programs.zsh.enable = true;

  system = {
    defaults = {
      dock = {
        # Disable all Hot Corners.
        wvous-tl-corner = 1;
        wvous-tr-corner = 1;
        wvous-bl-corner = 1;
        wvous-br-corner = 1;
      };

      hitoolbox.AppleFnUsageType = "Do Nothing";

      NSGlobalDomain = {
        "com.apple.keyboard.fnState" = true;
        "com.apple.mouse.tapBehavior" = 1;
      };

      trackpad.Clicking = true;
    };

    keyboard = {
      enableKeyMapping = true;
      remapCapsLockToEscape = true;
    };

  };

  security.pam.services.sudo_local.touchIdAuth = true;

  homebrew = {
    enable = true;

    onActivation.cleanup = "none";

    # 自动更新 Homebrew 本身及包
    onActivation.autoUpdate = false;
    onActivation.upgrade = false;

    brews = [
      "mas" # 用于通过命令行下载 Mac App Store 的软件
    ];

    # 图形界面软件 (brew install --cask xxx)
    casks = [
      "google-chrome"
      "visual-studio-code"
      "kitty"
      "oneclip"
    ];

    # Mac App Store 软件
    # App Store 里的 App ID可以通过 `mas search <应用名>` 获取
    masApps = {
    };
  };

  environment.variables = {
    HOMEBREW_API_DOMAIN = "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles/api";
    HOMEBREW_BOTTLE_DOMAIN = "https://mirrors.tuna.tsinghua.edu.cn/homebrew-bottles";
    HOMEBREW_BREW_GIT_REMOTE = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/brew.git";
    HOMEBREW_CORE_GIT_REMOTE = "https://mirrors.tuna.tsinghua.edu.cn/git/homebrew/homebrew-core.git";
  };
}
