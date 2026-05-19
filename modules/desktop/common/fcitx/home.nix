{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  rimeDir = "${config.xdg.dataHome}/fcitx5/rime";
in

{
  xdg.dataFile = {
    "fcitx5/themes/OriLight".source = ./themes/OriLight;
    "fcitx5/themes/OriDark".source = ./themes/OriDark;
    "fcitx5/rime" = {
      source = inputs.rime-ice;
      recursive = true;
    };
    "fcitx5/rime/default.custom.yaml".text = ''
      patch:
        schema_list:
          - schema: double_pinyin_flypy
        menu/page_size: 7
    '';
    "fcitx5/rime/double_pinyin_flypy.custom.yaml".text = ''
      patch:
        switches/@1/reset: 1
    '';
    "fcitx5/rime/melt_eng.custom.yaml".text = ''
      patch:
        speller/algebra:
          __include: melt_eng.schema.yaml:/algebra_flypy
    '';
    "fcitx5/rime/radical_pinyin.custom.yaml".text = ''
      patch:
        speller/algebra:
          __include: radical_pinyin.schema.yaml:/algebra_flypy
    '';
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons
      fcitx5-rime
      qt6Packages.fcitx5-configtool
      fcitx5-gtk
    ];
    fcitx5.waylandFrontend = true;

    fcitx5.settings = {
      inputMethod = {
        "Groups/0" = {
          Name = "Default";
          "Default Layout" = "us";
          DefaultIM = "rime";
        };
        "Groups/0/Items/0" = {
          Name = "keyboard-us";
          Layout = "";
        };
        "Groups/0/Items/1" = {
          Name = "rime";
          Layout = "";
        };
      };

      globalOptions = {
        Hotkey = {
          EnumerateWithTriggerKeys = true;
          AltTriggerKeys = "";
          EnumerateForwardKeys = "";
          EnumerateBackwardKeys = "";
          EnumerateSkipFirst = false;
          ModifierOnlyKeyTimeout = 248;
        };

        "Hotkey/TriggerKeys" = {
          "0" = "Super+space";
        };

        "Hotkey/ActivateKeys" = {
          "0" = "Hangul_Hanja";
        };

        "Hotkey/DeactivateKeys" = {
          "0" = "Hangul_Romaja";
        };

        "Hotkey/EnumerateGroupForwardKeys" = {
          "0" = "Super+space";
        };

        "Hotkey/EnumerateGroupBackwardKeys" = {
          "0" = "Shift+Super+space";
        };

        "Hotkey/PrevPage" = {
          "0" = "Up";
        };

        "Hotkey/NextPage" = {
          "0" = "Down";
        };

        "Hotkey/PrevCandidate" = {
          "0" = "Shift+Tab";
        };

        "Hotkey/NextCandidate" = {
          "0" = "Tab";
        };

        "Hotkey/TogglePreedit" = {
          "0" = "Control+Alt+P";
        };

        Behavior = {
          ActiveByDefault = false;
          resetStateWhenFocusIn = "No";
          ShareInputState = "No";
          PreeditEnabledByDefault = true;
          ShowInputMethodInformation = true;
          showInputMethodInformationWhenFocusIn = false;
          CompactInputMethodInformation = true;
          ShowFirstInputMethodInformation = true;
          DefaultPageSize = 5;
          OverrideXkbOption = false;
          CustomXkbOption = "";
          EnabledAddons = "";
          DisabledAddons = "";
          PreloadInputMethod = true;
          AllowInputMethodForPassword = false;
          ShowPreeditForPassword = false;
          AutoSavePeriod = 30;
        };
      };

      addons = {
        classicui.globalSection = {
          "Vertical Candidate List" = false;
          WheelForPaging = true;
          Font = "Maple Mono NF CN 10";
          MenuFont = "Maple Mono NF CN 10";
          TrayFont = "Maple Mono NF CN SemiBold Demi-Bold 10";
          TrayOutlineColor = "#000000";
          TrayTextColor = "#ffffff";
          PreferTextIcon = false;
          ShowLayoutNameInIcon = true;
          UseInputMethodLanguageToDisplayText = true;
          Theme = "OriDark";
          DarkTheme = "OriDark";
          UseDarkTheme = true;
          UseAccentColor = true;
          PerScreenDPI = false;
          ForceWaylandDPI = 0;
          EnableFractionalScale = true;
        };

        pinyin = {
          globalSection = {
            ShuangpinProfile = "Xiaohe";
            ShowShuangpinMode = true;
            PageSize = 7;
            FullWidthPunctuation = false;
            SpellEnabled = true;
            SymbolsEnabled = true;
            ChaiziEnabled = true;
            ExtBEnabled = true;
            StrokeCandidateEnabled = true;
            CloudPinyinEnabled = true;
            CloudPinyinIndex = 2;
            CloudPinyinAnimation = true;
            KeepCloudPinyinPlaceHolder = false;
            PreeditMode = "Composing pinyin";
            PreeditCursorPositionAtBeginning = true;
            PinyinInPreedit = false;
            Prediction = false;
            KeepCurrentContext = true;
            PredictionSize = 49;
            BackspaceBehaviorOnPrediction = "Backspace when not using on-screen keyboard";
            SwitchInputMethodBehavior = "Commit current preedit";
            SecondCandidate = "";
            ThirdCandidate = "";
            UseKeypadAsSelection = false;
            BackSpaceToUnselect = true;
            "Number of sentence" = 2;
            WordCandidateLimit = 15;
            LongWordLengthLimit = 4;
            QuickPhraseKey = "semicolon";
            VAsQuickphrase = true;
            FirstRun = false;
          };

          sections = {
            ForgetWord = {
              "0" = "Control+7";
            };

            PrevPage = {
              "0" = "minus";
              "1" = "Up";
              "2" = "KP_Up";
              "3" = "Page_Up";
            };

            NextPage = {
              "0" = "equal";
              "1" = "Down";
              "2" = "KP_Down";
              "3" = "Next";
            };

            PrevCandidate = {
              "0" = "Shift+Tab";
            };

            NextCandidate = {
              "0" = "Tab";
            };

            CurrentCandidate = {
              "0" = "space";
              "1" = "KP_Space";
            };

            CommitRawInput = {
              "0" = "Return";
              "1" = "KP_Enter";
              "2" = "Control+Return";
              "3" = "Control+KP_Enter";
              "4" = "Shift+Return";
              "5" = "Shift+KP_Enter";
              "6" = "Control+Shift+Return";
              "7" = "Control+Shift+KP_Enter";
            };

            ChooseCharFromPhrase = {
              "0" = "bracketleft";
              "1" = "bracketright";
            };

            FilterByStroke = {
              "0" = "grave";
            };

            QuickPhraseTriggerRegex = {
              "0" = ".(/|@)$";
              "1" = "^(www|bbs|forum|mail|bbs)\\.";
              "2" = "^(http|https|ftp|telnet|mailto):";
            };

            Fuzzy = {
              VE_UE = true;
              NG_GN = true;
              Inner = true;
              InnerShort = true;
              PartialFinal = true;
              PartialSp = false;
              V_U = false;
              AN_ANG = false;
              EN_ENG = false;
              IAN_IANG = false;
              IN_ING = false;
              U_OU = false;
              UAN_UANG = false;
              C_CH = false;
              F_H = false;
              L_N = false;
              L_R = false;
              S_SH = false;
              Z_ZH = false;
              Correction = "None";
            };
          };

        };

        cloudpinyin = {
          globalSection = {
            Backend = "Baidu";
            MinimumPinyinLength = 2;
          };
        };
      };
    };

    fcitx5.ignoreUserConfig = true;
  };

  home.activation.deployRimeIce = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    rime_dir="${rimeDir}"

    if [ -e "$rime_dir/build/default.yaml" ] && ! ${pkgs.gnugrep}/bin/grep -q "double_pinyin_flypy" "$rime_dir/build/default.yaml"; then
      mv "$rime_dir/build" "$rime_dir/build.before-rime-ice"
    fi

    cd "$rime_dir"
    ${pkgs.librime}/bin/rime_deployer --build "$rime_dir" "$rime_dir" "$rime_dir/build"
    ${pkgs.librime}/bin/rime_deployer --set-active-schema double_pinyin_flypy
  '';

  home.sessionVariables = {
    #GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus";
  };
}
