(require 'eglot)
(require 'flymake-eslint)
(require 'json)
(require 'seq)

(when (require 'treesit nil t)
  (add-to-list 'treesit-load-name-override-list
               '(tsx "libtree-sitter-tsx" "tree_sitter_typescript")))

(autoload 'typst-ts-mode "typst-ts-mode" "Major mode for Typst." t)

(setq eglot-autoshutdown t
      eglot-extend-to-xref t)

(setq flymake-eslint-executable-name "eslint_d"
      flymake-eslint-prefer-json-diagnostics t
      flymake-eslint-project-markers '("eslint.config.js"
                                       "eslint.config.cjs"
                                       "eslint.config.mjs"
                                       "eslint.config.ts"
                                       "eslint.config.cts"
                                       "eslint.config.mts"
                                       ".eslintrc"
                                       ".eslintrc.js"
                                       ".eslintrc.cjs"
                                       ".eslintrc.mjs"
                                       ".eslintrc.json"
                                       ".eslintrc.yaml"
                                       ".eslintrc.yml"))

(defconst water/eslint-config-files flymake-eslint-project-markers)

(defun water/package-json-has-eslint-config-p (file)
  (when (file-readable-p file)
    (with-temp-buffer
      (insert-file-contents file)
      (condition-case nil
          (gethash "eslintConfig" (json-parse-buffer :object-type 'hash-table))
        (json-parse-error nil)
        (error nil)))))

(defun water/eslint-project-root ()
  (locate-dominating-file
   default-directory
   (lambda (directory)
     (or (seq-some
          (lambda (file)
            (file-exists-p (expand-file-name file directory)))
          water/eslint-config-files)
         (water/package-json-has-eslint-config-p
          (expand-file-name "package.json" directory))))))

(defun water/flymake-eslint-enable-maybe ()
  (when-let ((root (water/eslint-project-root)))
    (setq-local flymake-eslint-project-root root)
    (flymake-eslint-enable)))

(dolist (capability '(:documentFormattingProvider :documentRangeFormattingProvider))
  (add-to-list 'eglot-ignored-server-capabilities capability))

(dolist (mode '(("\\.ts\\'" . typescript-ts-mode)
                ("\\.tsx\\'" . tsx-ts-mode)
                ("\\.mts\\'" . typescript-ts-mode)
                ("\\.cts\\'" . typescript-ts-mode)
                ("\\.vue\\'" . vue-mode)
                ("\\.typ\\'" . typst-ts-mode)
                ("\\.css\\'" . css-mode)
                ("\\.scss\\'" . scss-mode)
                ("\\.less\\'" . less-css-mode)))
  (add-to-list 'auto-mode-alist mode))

(setq typst-preview-browser "default"
      typst-preview-executable "tinymist"
      typst-preview-invert-colors "auto"
      typst-preview-partial-rendering t)

(with-eval-after-load 'typst-ts-mode
  (setq typst-ts-mode-indent-offset 2)
  (define-key typst-ts-mode-map (kbd "C-c C-v") #'typst-preview-mode)
  (define-key typst-ts-mode-map (kbd "C-c C-j") #'typst-preview-send-position))

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

(defun water/typescript-language-server-command ()
  (if (executable-find "vtsls")
      '("vtsls" "--stdio")
    '("typescript-language-server" "--stdio")))

(add-to-list 'eglot-server-programs
             `((typescript-mode typescript-ts-mode tsx-ts-mode
                js-mode js-ts-mode js-jsx-mode) .
               ,(water/typescript-language-server-command)))

(add-to-list 'eglot-server-programs
             `((vue-mode) . ,(water/vue-language-server-command)))

(add-to-list 'eglot-server-programs
             '((css-mode scss-mode less-css-mode) .
               ("vscode-css-language-server" "--stdio")))

(add-to-list 'eglot-server-programs
             '((typst-ts-mode) . ("tinymist")))

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
                js-mode-hook js-ts-mode-hook js-jsx-mode-hook
                vue-mode-hook
                css-mode-hook scss-mode-hook less-css-mode-hook
                typst-ts-mode-hook
                c-mode-hook c++-mode-hook c-ts-mode-hook c++-ts-mode-hook objc-mode-hook))
  (add-hook hook #'eglot-ensure))

(dolist (hook '(typescript-mode-hook typescript-ts-mode-hook tsx-ts-mode-hook
                js-mode-hook js-ts-mode-hook js-jsx-mode-hook
                vue-mode-hook))
  (add-hook hook #'water/flymake-eslint-enable-maybe))

(setq-default eglot-workspace-configuration
              '(:vtsls
                (:autoUseWorkspaceTsdk t)
                :tinymist
                (:exportPdf "onSave"
                 :formatterMode "typstyle"
                 :formatterPrintWidth 100
                 :syntaxOnly "auto")))

(defun water/eglot-setup ()
  (local-set-key (kbd "C-c l a") #'eglot-code-actions)
  (local-set-key (kbd "C-c l f") #'apheleia-format-buffer)
  (local-set-key (kbd "C-c l F") #'apheleia-format-buffer)
  (local-set-key (kbd "C-c l r") #'eglot-rename))

(add-hook 'eglot-managed-mode-hook #'water/eglot-setup)
