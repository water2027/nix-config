(require 'vertico)
(require 'marginalia)
(require 'which-key)
(require 'savehist)
(require 'orderless)
(require 'embark)

(vertico-mode 1)
(marginalia-mode 1)
(which-key-mode 1)
(savehist-mode 1)

(setq tab-always-indent 'complete
      completion-styles '(orderless basic)
      completion-category-defaults nil
      completion-category-overrides '((file (styles basic partial-completion)))
      corfu-cycle t
      corfu-auto t
      corfu-auto-delay 0.2
      corfu-auto-prefix 1
      corfu-preview-current nil
      corfu-preselect 'first
      corfu-on-exact-match nil)

(setq prefix-help-command #'embark-prefix-help-command)

(global-set-key (kbd "C-.") #'embark-act)
(global-set-key (kbd "C-;") #'embark-dwim)
(global-set-key (kbd "C-h B") #'embark-bindings)

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
