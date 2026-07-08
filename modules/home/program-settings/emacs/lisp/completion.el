(require 'vertico)
(require 'marginalia)
(require 'which-key)
(require 'savehist)
(require 'consult)

(vertico-mode 1)
(marginalia-mode 1)
(which-key-mode 1)
(savehist-mode 1)

(setq tab-always-indent 'complete
      completion-styles '(basic substring partial-completion flex)
      completion-category-overrides '((file (styles basic partial-completion)))
      corfu-cycle t
      corfu-auto t
      corfu-auto-delay 0.2
      corfu-auto-prefix 2
      corfu-preview-current nil
      corfu-preselect 'first
      corfu-on-exact-match nil
      eglot-autoshutdown t
      eglot-extend-to-xref t)

(defun water/enable-corfu ()
  (require 'corfu)
  (global-corfu-mode 1)
  (unless (display-graphic-p)
    (require 'corfu-terminal)
    (corfu-terminal-mode 1)))

(run-with-idle-timer 0.2 nil #'water/enable-corfu)

(defvar water/yasnippet-ready nil)

(defun water/enable-yasnippet ()
  (unless water/yasnippet-ready
    (require 'yasnippet)
    (dolist (dir load-path)
      (let ((snippets-dir (expand-file-name "snippets" dir)))
        (when (file-directory-p snippets-dir)
          (add-to-list 'yas-snippet-dirs snippets-dir t))))
    (define-key yas-minor-mode-map (kbd "TAB") nil)
    (define-key yas-minor-mode-map (kbd "<tab>") nil)
    (define-key yas-minor-mode-map (kbd "C-c y") #'yas-expand)
    (yas-reload-all)
    (setq water/yasnippet-ready t))
  (yas-minor-mode 1))

(add-hook 'prog-mode-hook #'water/enable-yasnippet)

(defun water/cape-file (&optional interactive)
  (require 'cape)
  (cape-file interactive))

(defun water/cape-keyword (&optional interactive)
  (require 'cape-keyword)
  (cape-keyword interactive))

(defun water/cape-dabbrev (&optional interactive)
  (require 'cape)
  (cape-dabbrev interactive))

(dolist (capf '(water/cape-file water/cape-keyword water/cape-dabbrev))
  (add-to-list 'completion-at-point-functions capf t))

(defun water/eglot-completion-at-point (capf &rest args)
  (require 'cape)
  (apply #'cape-wrap-buster capf args))

(advice-add 'eglot-completion-at-point :around #'water/eglot-completion-at-point)

(add-hook 'nix-mode-hook #'eglot-ensure)

(defun water/eglot-setup ()
  (local-set-key (kbd "C-c l a") #'eglot-code-actions)
  (local-set-key (kbd "C-c l f") #'eglot-format)
  (local-set-key (kbd "C-c l F") #'eglot-format-buffer)
  (local-set-key (kbd "C-c l r") #'eglot-rename))

(add-hook 'eglot-managed-mode-hook #'water/eglot-setup)

(global-set-key (kbd "C-s") #'consult-line)
(global-set-key (kbd "C-x b") #'consult-buffer)
(global-set-key (kbd "M-y") #'consult-yank-pop)
(global-set-key (kbd "M-g g") #'consult-goto-line)
(global-set-key (kbd "M-g o") #'consult-outline)
(global-set-key (kbd "C-c s") #'consult-ripgrep)
(global-set-key (kbd "C-c f") #'consult-find)
