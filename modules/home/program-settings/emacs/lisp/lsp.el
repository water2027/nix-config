(require 'eglot)
(require 'seq)

(setq eglot-autoshutdown t
      eglot-extend-to-xref t)

(dolist (capability '(:documentFormattingProvider :documentRangeFormattingProvider))
  (add-to-list 'eglot-ignored-server-capabilities capability))

(dolist (mode '(("\\.ts\\'" . typescript-mode)
                ("\\.tsx\\'" . typescript-mode)
                ("\\.mts\\'" . typescript-mode)
                ("\\.cts\\'" . typescript-mode)
                ("\\.vue\\'" . vue-mode)
                ("\\.css\\'" . css-mode)
                ("\\.scss\\'" . scss-mode)
                ("\\.less\\'" . less-css-mode)))
  (add-to-list 'auto-mode-alist mode))

(defun water/typescript-sdk-path ()
  (when-let* ((tsserver (executable-find "tsserver"))
              (tsserver-dir (file-name-directory (file-truename tsserver)))
              (package-dir (file-name-directory (directory-file-name tsserver-dir))))
    (seq-find (lambda (dir)
                (file-exists-p (expand-file-name "tsserverlibrary.js" dir)))
              (list (expand-file-name "lib" package-dir)
                    (expand-file-name "lib/node_modules/typescript/lib" package-dir)))))

(defun water/vue-language-server-command ()
  (append '("vue-language-server" "--stdio")
          (when-let ((tsdk (water/typescript-sdk-path)))
            (list :initializationOptions `(:typescript (:tsdk ,tsdk))))))

(add-to-list 'eglot-server-programs
             '((typescript-mode typescript-ts-mode tsx-ts-mode) .
               ("typescript-language-server" "--stdio")))

(add-to-list 'eglot-server-programs
             `((vue-mode) . ,(water/vue-language-server-command)))

(add-to-list 'eglot-server-programs
             '((css-mode scss-mode less-css-mode) .
               ("vscode-css-language-server" "--stdio")))

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
                vue-mode-hook
                css-mode-hook scss-mode-hook less-css-mode-hook
                c-mode-hook c++-mode-hook c-ts-mode-hook c++-ts-mode-hook objc-mode-hook))
  (add-hook hook #'eglot-ensure))

(defun water/eglot-setup ()
  (local-set-key (kbd "C-c l a") #'eglot-code-actions)
  (local-set-key (kbd "C-c l f") #'apheleia-format-buffer)
  (local-set-key (kbd "C-c l F") #'apheleia-format-buffer)
  (local-set-key (kbd "C-c l r") #'eglot-rename))

(add-hook 'eglot-managed-mode-hook #'water/eglot-setup)
