(require 'eglot)

(setq eglot-autoshutdown t
      eglot-extend-to-xref t)

(dolist (mode '(("\\.ts\\'" . typescript-mode)
                ("\\.tsx\\'" . typescript-mode)
                ("\\.mts\\'" . typescript-mode)
                ("\\.cts\\'" . typescript-mode)))
  (add-to-list 'auto-mode-alist mode))

(add-to-list 'eglot-server-programs
             '((typescript-mode typescript-ts-mode tsx-ts-mode) .
               ("typescript-language-server" "--stdio")))

(add-to-list 'eglot-server-programs
             '((c-mode c++-mode c-ts-mode c++-ts-mode objc-mode) .
               ("clangd"
                "--background-index"
                "--clang-tidy"
                "--completion-style=detailed"
                "--header-insertion=iwyu"
                "--function-arg-placeholders"
                "--fallback-style=llvm")))

(defun water/eglot-completion-at-point (capf &rest args)
  (require 'cape)
  (apply #'cape-wrap-buster capf args))

(advice-add 'eglot-completion-at-point :around #'water/eglot-completion-at-point)

(add-hook 'nix-mode-hook #'eglot-ensure)

(dolist (hook '(typescript-mode-hook typescript-ts-mode-hook tsx-ts-mode-hook
                c-mode-hook c++-mode-hook c-ts-mode-hook c++-ts-mode-hook objc-mode-hook))
  (add-hook hook #'eglot-ensure))

(defun water/eglot-setup ()
  (local-set-key (kbd "C-c l a") #'eglot-code-actions)
  (local-set-key (kbd "C-c l f") #'eglot-format)
  (local-set-key (kbd "C-c l F") #'eglot-format-buffer)
  (local-set-key (kbd "C-c l r") #'eglot-rename))

(add-hook 'eglot-managed-mode-hook #'water/eglot-setup)
