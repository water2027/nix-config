{ pkgs, ... }:

let
  clip2path = pkgs.writeShellApplication {
    name = "clip2path";
    runtimeInputs = with pkgs; [
      coreutils
      gnugrep
      kitty
      wl-clipboard
    ];
    text = ''
      set -euo pipefail

      paste_from_clipboard() {
        kitten @ action --no-response paste_from_clipboard
      }

      mime_types="$(wl-paste --list-types 2>/dev/null || true)"
      image_type=""

      for mime in image/png image/jpeg image/jpg image/webp image/gif image/bmp image/tiff image/svg+xml; do
        if printf '%s\n' "$mime_types" | grep -Fxq "$mime"; then
          image_type="$mime"
          break
        fi
      done

      if [ -z "$image_type" ]; then
        image_type="$(printf '%s\n' "$mime_types" | grep -E '^image/' | head -n 1 || true)"
      fi

      if [ -z "$image_type" ]; then
        paste_from_clipboard
        exit 0
      fi

      case "$image_type" in
        image/png) ext="png" ;;
        image/jpeg | image/jpg) ext="jpg" ;;
        image/webp) ext="webp" ;;
        image/gif) ext="gif" ;;
        image/bmp) ext="bmp" ;;
        image/tiff) ext="tiff" ;;
        image/svg+xml) ext="svg" ;;
        *) ext="img" ;;
      esac

      image_dir="''${XDG_CACHE_HOME:-$HOME/.cache}/kitty-clipboard-images"
      mkdir -p "$image_dir"
      image_path="$image_dir/clipboard-$(date +%Y%m%d-%H%M%S)-$$.$ext"

      if wl-paste --no-newline --type "$image_type" > "$image_path"; then
        printf '%s' "$image_path" | kitten @ send-text --stdin --bracketed-paste auto
      else
        rm -f "$image_path"
        paste_from_clipboard
      fi
    '';
  };
in

{
  programs.kitty = {
    enable = true;

    font = {
      name = "Maple Mono NF CN";
      # size = 12;
    };

    settings = {
      background_opacity = "0.8";
      allow_remote_control = "yes";
      auto_reload_config = "-1";
    };

    keybindings = {
      "ctrl+v" =
        "launch --type=background --allow-remote-control --keep-focus ${clip2path}/bin/clip2path";
      "ctrl+shift+enter" = "launch --cwd=current";
      "alt+shift+[" = "previous_tab";
      "alt+shift+]" = "next_tab";
    };
  };

  home.shellAliases = {
    cpd = "kitten clipboard";
    icat = "kitten icat";
  };

  home.packages = [
    clip2path
  ];
}
