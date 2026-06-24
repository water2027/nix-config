{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

let
  rimeDir = "${config.xdg.dataHome}/fcitx5/rime";
  essayZhHans = pkgs.runCommand "essay-zh-hans.txt" { } ''
    ${pkgs.gawk}/bin/awk -F '\t' 'BEGIN { OFS="\t" } /^#/ || /^$/ || /^---$/ || /^\.\.\.$/ { next } NF >= 3 && $3 ~ /^[0-9]+$/ { print $1, $3 }' \
      ${inputs.rime-ice}/cn_dicts/8105.dict.yaml > "$out"
  '';
  radicalPinyinDict = pkgs.runCommand "radical_pinyin.dict.yaml" { } ''
    ${pkgs.gawk}/bin/awk '
      /^sort: original$/ { print "# sort: original"; next }
      /^# vocabulary: essay-zh-hans/ { print "vocabulary: essay-zh-hans # 简体字频"; next }
      /^# max_phrase_length: 1/ && !enabledMaxPhraseLength { print "max_phrase_length: 1 # 仅调整单字"; enabledMaxPhraseLength = 1; next }
      { print }
    ' ${inputs.rime-ice}/radical_pinyin.dict.yaml > "$out"
  '';
  rimeIce = pkgs.runCommand "rime-ice-patched" { } ''
    mkdir -p "$out"
    cp -R ${inputs.rime-ice}/. "$out/"
    chmod -R u+w "$out"
    cp ${essayZhHans} "$out/essay-zh-hans.txt"
    cp ${radicalPinyinDict} "$out/radical_pinyin.dict.yaml"
  '';
in

{
  xdg.dataFile = {
    "fcitx5/themes/OriLight".source = ./themes/OriLight;
    "fcitx5/themes/OriDark".source = ./themes/OriDark;
    "fcitx5/rime" = {
      source = rimeIce;
      recursive = true;
    };
    "fcitx5/rime/default.custom.yaml".text = ''
      patch:
        schema_list:
          - schema: double_pinyin_flypy
        menu/page_size: 7
        switcher/save_options:
          - traditionalization
          - emoji
          - full_shape
          - search_single_char
        ascii_composer/switch_key/Shift_L: noop
        ascii_composer/switch_key/Shift_R: noop
    '';
    "fcitx5/rime/double_pinyin_flypy.custom.yaml".text = ''
      patch:
        switches/@1/reset: 1
        radical_lookup/prism: radical_pinyin
    '';
    "fcitx5/rime/melt_eng.custom.yaml".text = ''
      patch:
        speller/algebra:
          __include: melt_eng.schema.yaml:/algebra_double_pinyin_flypy
    '';
    "fcitx5/rime/radical_pinyin.custom.yaml".text = ''
      patch:
        speller/algebra:
          __include: radical_pinyin.schema.yaml:/algebra_double_pinyin_flypy
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
        build_dir="$rime_dir/build"
        stamp_file="$build_dir/.nix-rime-ice-stamp"
        desired_stamp="$(${pkgs.coreutils}/bin/cat <<EOF
    rimeIce=${rimeIce}
    librime=${pkgs.librime}
    default.custom=$(${pkgs.coreutils}/bin/readlink "$rime_dir/default.custom.yaml" || true)
    double_pinyin_flypy.custom=$(${pkgs.coreutils}/bin/readlink "$rime_dir/double_pinyin_flypy.custom.yaml" || true)
    melt_eng.custom=$(${pkgs.coreutils}/bin/readlink "$rime_dir/melt_eng.custom.yaml" || true)
    radical_pinyin.custom=$(${pkgs.coreutils}/bin/readlink "$rime_dir/radical_pinyin.custom.yaml" || true)
    EOF
    )"

        if [ -e "$build_dir/default.yaml" ] \
          && [ -e "$stamp_file" ] \
          && [ "$(${pkgs.coreutils}/bin/cat "$stamp_file")" = "$desired_stamp" ]; then
          echo "Rime Ice build is current; skipping deploy."
        else
          if [ -e "$build_dir/default.yaml" ] && ! ${pkgs.gnugrep}/bin/grep -q "double_pinyin_flypy" "$build_dir/default.yaml"; then
            ${pkgs.coreutils}/bin/rm -rf "$rime_dir/build.before-rime-ice"
            mv "$build_dir" "$rime_dir/build.before-rime-ice"
          fi

          mkdir -p "$build_dir"
          ${pkgs.findutils}/bin/find "$build_dir" -mindepth 1 ! -name .gitkeep -exec ${pkgs.coreutils}/bin/rm -rf {} +

          cd "$rime_dir"
          ${pkgs.librime}/bin/rime_deployer --build "$rime_dir" "$rime_dir" "$build_dir"
          ${pkgs.librime}/bin/rime_deployer --set-active-schema double_pinyin_flypy
          ${pkgs.coreutils}/bin/printf '%s\n' "$desired_stamp" > "$stamp_file"
        fi
  '';

  home.sessionVariables = {
    #GTK_IM_MODULE = "fcitx";
    QT_IM_MODULE = "fcitx";
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";
    GLFW_IM_MODULE = "ibus";
  };
}
