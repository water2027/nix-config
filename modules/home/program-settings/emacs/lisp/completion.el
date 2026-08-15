(require 'vertico)
(require 'marginalia)
(require 'savehist)
(require 'orderless)
(require 'embark)

(use-package which-key
  :ensure nil
  :defer 1
  :config (which-key-mode 1))

(vertico-mode 1)
(marginalia-mode 1)
(savehist-mode 1)

(setq tab-always-indent 'complete
      completion-styles '(orderless basic)
      completion-category-defaults nil
      completion-category-overrides '((file (styles basic partial-completion))))

(setq prefix-help-command #'embark-prefix-help-command)

(global-set-key (kbd "C-.") #'embark-act)
(global-set-key (kbd "C-;") #'embark-dwim)
(global-set-key (kbd "C-h B") #'embark-bindings)

(defun water/insert-two-spaces ()
  (interactive)
  (insert "  "))

(defvar water/fixed-tab-mode-map
  (let ((map (make-sparse-keymap)))
    (define-key map (kbd "TAB") #'water/insert-two-spaces)
    (define-key map (kbd "<tab>") #'water/insert-two-spaces)
    map))

(define-minor-mode water/fixed-tab-mode
  "Make TAB insert two spaces instead of syntax indentation."
  :lighter nil
  :keymap water/fixed-tab-mode-map)

(with-eval-after-load 'corfu
  (define-key corfu-map (kbd "TAB") #'corfu-complete)
  (define-key corfu-map (kbd "<tab>") #'corfu-complete)
  (define-key corfu-map (kbd "M-TAB") #'corfu-complete))

(defun water/enable-corfu ()
  (require 'corfu)
  (setq corfu-cycle t
        corfu-auto t
        corfu-auto-delay 0.2
        corfu-auto-prefix 1
        corfu-preview-current nil
        corfu-preselect 'first
        corfu-on-exact-match nil
        global-corfu-modes '((not org-mode) t))
  (global-corfu-mode 1)
  (unless (display-graphic-p)
    (require 'corfu-terminal)
    (corfu-terminal-mode 1)))

(water/enable-corfu)

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
(add-hook 'prog-mode-hook #'water/fixed-tab-mode)

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
