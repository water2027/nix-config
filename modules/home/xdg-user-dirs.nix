{ ... }:

{
  # Pin XDG user directories. XFCE runs xdg-user-dirs-update at session start,
  # which under the zh_CN locale points Documents at ~/文档; WeChat resolves its
  # data directory against the XDG Documents location, so it started a fresh
  # profile under ~/文档/documents/xwechat_files.
  # Keeping documents as $HOME makes WeChat use ~/documents/xwechat_files again,
  # matching the behavior before 2026-08-12. All other dirs use English names.
  xdg.userDirs = {
    enable = true;
    createDirectories = false;

    desktop = "$HOME/Desktop";
    download = "$HOME/Downloads";
    documents = "$HOME";
    music = "$HOME/Music";
    pictures = "$HOME/Pictures";
    publicShare = "$HOME/Public";
    templates = "$HOME/Templates";
    videos = "$HOME/Videos";
    projects = "$HOME/Projects";
  };
}
