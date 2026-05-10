{ ... }:

{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };
  programs.zsh = {
    enable = true;

    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      if command -v devenv >/dev/null 2>&1; then
        eval "$(devenv hook zsh)"
      fi

      proxy() {
        export http_proxy="http://127.0.0.1:20171"
        export https_proxy="http://127.0.0.1:20171"
        echo "Proxy enabled: $http_proxy"
      }

      unproxy() {
        unset http_proxy
        unset https_proxy
        echo "Proxy disabled."
      }

      toggle_proxy() {
        if [[ -n "$http_proxy" ]]; then
          unproxy
        else
          proxy
        fi
      }

      # 注册为 ZLE 部件并绑定快捷键 Ctrl + ]
      zle -N toggle_proxy
      bindkey '^]' toggle_proxy
    '';
  };

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
    options = [ "--cmd=cd" ];
  };
}
