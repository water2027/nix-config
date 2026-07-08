{
  home.file = {
    ".emacs.d/init.el".text = ''
      (let ((config-dir (expand-file-name "lisp" user-emacs-directory)))
        (dolist (file '("core.el"
                        "appearance.el"
                        "org.el"
                        "completion.el"))
          (load-file (expand-file-name file config-dir))))
    '';

    ".emacs.d/lisp/core.el".source = ./lisp/core.el;
    ".emacs.d/lisp/appearance.el".source = ./lisp/appearance.el;
    ".emacs.d/lisp/org.el".source = ./lisp/org.el;
    ".emacs.d/lisp/completion.el".source = ./lisp/completion.el;
  };
}
