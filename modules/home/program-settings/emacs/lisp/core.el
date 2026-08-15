(setq inhibit-startup-screen t
      use-short-answers t
      ring-bell-function 'ignore)

(require 'use-package)
(setq use-package-always-ensure nil)

;; 启动阶段临时提高 GC 阈值，减少启动时 GC 停顿。
(setq gc-cons-threshold (* 100 1024 1024)
      gc-cons-percentage 0.6)
(add-hook 'emacs-startup-hook
          (lambda ()
            (setq gc-cons-threshold (* 16 1024 1024)
                  gc-cons-percentage 0.1)))

(require 'server)

(unless (or noninteractive (server-running-p))
  (server-start))

(dolist (dir '("backups" "auto-save"))
  (make-directory (expand-file-name dir user-emacs-directory) t))

(setq backup-directory-alist `(("." . ,(expand-file-name "backups/" user-emacs-directory)))
      auto-save-file-name-transforms `((".*" ,(expand-file-name "auto-save/" user-emacs-directory) t))
      auto-save-list-file-prefix (expand-file-name "auto-save/sessions-" user-emacs-directory)
      backup-by-copying t
      version-control t
      kept-new-versions 6
      kept-old-versions 2
      delete-old-versions t
      auto-save-default t
      auto-save-timeout 20
      auto-save-interval 200
      create-lockfiles nil)

(setq display-line-numbers-type 'relative)

(global-display-line-numbers-mode 1)
(column-number-mode 1)

(recentf-mode 1)
(save-place-mode 1)
(delete-selection-mode 1)
(global-auto-revert-mode 1)
(winner-mode 1)
(repeat-mode 1)
(show-paren-mode 1)
(electric-pair-mode 1)

(setq recentf-max-saved-items 200
      recentf-auto-cleanup 'never
      global-auto-revert-non-file-buffers t
      auto-revert-verbose nil)

(global-set-key (kbd "C-c r") #'recentf-open-files)
(global-set-key (kbd "C-c R") #'revert-buffer)
(global-set-key (kbd "C-c <left>") #'winner-undo)
(global-set-key (kbd "C-c <right>") #'winner-redo)
