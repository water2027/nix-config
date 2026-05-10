{
  pkgs,
  inputs,
  username,
  ...
}:

{
  imports = [
    ../../modules/nix/common.nix
    ../../modules/darwin/common.nix
  ];

  # 管理系统环境
  home-manager = {
    extraSpecialArgs = { inherit inputs username; };
    users.${username} = import ./home.nix;
  };

  homebrew = {
    enable = true;

    onActivation.cleanup = "none";

    # 自动更新 Homebrew 本身及包
    onActivation.autoUpdate = true;
    onActivation.upgrade = true;

    taps = [
      "homebrew/services"
    ];

    brews = [
      "mas" # 用于通过命令行下载 Mac App Store 的软件
    ];

    # 图形界面软件 (brew install --cask xxx)
    casks = [
      "google-chrome"
      "visual-studio-code"
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

  system.stateVersion = 4;
}
