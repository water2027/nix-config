{ pkgs, ... }:

let
  marketplace = pkgs.vscode-marketplace;
  commonExtensions = with marketplace; [
    streetsidesoftware.code-spell-checker
    eamodio.gitlens
    mrmlnc.vscode-json5
    shd101wyy.markdown-preview-enhanced
    yzhang.markdown-all-in-one
    gruntfuggly.todo-tree
    tomoki1207.pdf
    ms-vscode-remote.remote-ssh
    eserozvataf.one-dark-pro-monokai-darker
    ms-vscode.remote-explorer
    russell.any-rule
    ms-vscode-remote.remote-ssh-edit
    vscodevim.vim
    usernamehw.errorlens
  ];
  commonSettings = {
    "editor.fontFamily" = "'Maple Mono NF CN', 'JetBrainsMono Nerd Font'";
    "workbench.colorTheme" = "One Dark Pro Monokai Darker";
    "editor.formatOnSave" = true;
    "editor.guides.bracketPairs" = "active";
    "editor.fontLigatures" = true;

    "editor.smoothScrolling" = true; # 平滑滚动，视觉更舒服
    "editor.cursorSmoothCaretAnimation" = "on"; # 光标移动动画（肉眼可见的丝滑）
    "editor.linkedEditing" = true; # 修改 HTML 标签头，尾部自动同步修改
    "workbench.secondarySideBar.defaultVisibility" = "hidden";

    "files.trimTrailingWhitespace" = true; # 保存时自动删除行尾空格
    "files.insertFinalNewline" = true; # 保存时在文件末尾插入新行（符合 POSIX 标准）
    "files.autoSave" = "onFocusChange"; # 窗口失去焦点时自动保存

    "workbench.list.smoothScrolling" = true;

    "vim.useSystemClipboard" = true; # 使用系统剪贴板
    "vim.hlsearch" = true; # 高亮搜索内容
    "vim.easymotion" = true; # 开启 easymotion 快速跳转

    "remote.SSH.useLocalServer" = false;
    "remote.SSH.showLoginTerminal" = true;
  };
in
{
  programs.vscode = {
    enable = true;
    package = if pkgs.stdenv.hostPlatform.isDarwin then null else pkgs.vscode;
    profiles.default = {
      extensions = commonExtensions;

      userSettings = commonSettings;
    };

    profiles.rust = {
      extensions =
        commonExtensions
        ++ (with marketplace; [
          rust-lang.rust-analyzer
          tamasfe.even-better-toml
        ]);

      userSettings = commonSettings // {
        "rust-analyzer.check.command" = "clippy";
        "rust-analyzer.procMacro.enable" = true;
      };
    };

    profiles.python = {
      extensions =
        commonExtensions
        ++ (with marketplace; [
          ms-python.python
          ms-python.debugpy
          ms-python.vscode-python-envs
          ms-python.vscode-pylance
        ]);

      userSettings = commonSettings;
    };

    profiles.frontend = {
      extensions =
        commonExtensions
        ++ (with marketplace; [
          astro-build.astro-vscode
          dbaeumer.vscode-eslint
          howardzuo.vscode-npm-dependency
          nrwl.angular-console
          ririd.packages
          esbenp.prettier-vscode
          chrmarti.regex
          stylelint.vscode-stylelint
          antfu.unocss
          vue.volar
          vitest.explorer
          antfu.iconify
          naumovs.color-highlight
        ]);

      userSettings = commonSettings // {
        "eslint.format.enable" = true;
      };
    };

    profiles.nix = {
      extensions =
        commonExtensions
        ++ (with marketplace; [
          jnoortheen.nix-ide

        ]);

      userSettings = commonSettings // {
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nil";
        "nix.formatterPath" = "alejandra";
        "[nix]" = {
          "editor.defaultFormatter" = "jnoortheen.nix-ide";
          "editor.formatOnSave" = true;
        };
      };
    };

    # extensions = commonExtensions ++ (with pkgs.vscode-extensions; [

    # ]) ++ (with marketplace; [

    # ]);
  };
}
