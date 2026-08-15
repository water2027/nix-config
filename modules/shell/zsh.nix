{ ... }:

{
  programs.fzf = {
    enableZshIntegration = true;
  };
  programs.starship = {
    enableZshIntegration = true;
    settings = {
      custom.proxy = {
        command = "echo proxy";
        when = ''test -n "$http_proxy$https_proxy$all_proxy$HTTP_PROXY$HTTPS_PROXY$ALL_PROXY"'';
        symbol = "󰖟 ";
        style = "bold yellow";
        format = "[$symbol$output]($style) ";
      };
    };
  };
  programs.zsh = {
    enableCompletion = true;
    completionInit = ''
      # Keep Zim-like substring matching, e.g. ".md" completes "123.md".
      zstyle ':completion:*' matcher-list "" "m:{a-zA-Z}={A-Za-z}" "r:|[._-]=* r:|=*" "l:|=* r:|=*"

      autoload -U compinit && compinit
    '';
    autocd = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    defaultKeymap = "emacs";
    shellAliases = {
      e = ''emacsclient -nw -a ""'';
    };

    initContent = ''
      eval "$(fnm env --use-on-cd --shell zsh)"

      proxy() {
        export http_proxy="http://127.0.0.1:20171"
        export https_proxy="http://127.0.0.1:20171"
        export HTTP_PROXY="$http_proxy"
        export HTTPS_PROXY="$https_proxy"
        export no_proxy="127.0.0.1,localhost,::1,mirrors.tuna.tsinghua.edu.cn,.tuna.tsinghua.edu.cn,mirrors.ustc.edu.cn,.ustc.edu.cn"
        export NO_PROXY="$no_proxy"
      }

      unproxy() {
        unset http_proxy
        unset https_proxy
        unset HTTP_PROXY
        unset HTTPS_PROXY
        unset all_proxy
        unset ALL_PROXY
        unset no_proxy
        unset NO_PROXY
      }

      toggle_proxy() {
        if [[ -n "$http_proxy" ]]; then
          unproxy
        else
          proxy
        fi

        if [[ -n "''${ZLE_STATE-}" ]]; then
          zle reset-prompt
        fi
      }

      # 注册为 ZLE 部件并绑定快捷键 Ctrl + ]
      zle -N toggle_proxy
      bindkey '^]' toggle_proxy
    '';
  };

  programs.zoxide = {
    enableZshIntegration = true;
    options = [ "--cmd=cd" ];
  };
}
