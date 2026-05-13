{
  home.file = {
    ".emacs.d/init.el".text = ''
      (let ((config-dir (expand-file-name "lisp" user-emacs-directory)))
        (dolist (file '("core.el"
                        "org.el"
                        "evil.el"
                        "completion.el"
                        "latex.el"))
          (load-file (expand-file-name file config-dir))))
    '';

    ".emacs.d/lisp/core.el".source = ./lisp/core.el;
    ".emacs.d/lisp/org.el".source = ./lisp/org.el;
    ".emacs.d/lisp/evil.el".source = ./lisp/evil.el;
    ".emacs.d/lisp/completion.el".source = ./lisp/completion.el;
    ".emacs.d/lisp/latex.el".source = ./lisp/latex.el;
  };
}
