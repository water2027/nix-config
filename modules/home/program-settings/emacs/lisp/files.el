(require 'dired)
(require 'dired-x)

(setq dired-listing-switches "-alh"
      dired-dwim-target t
      dired-recursive-copies 'always
      dired-recursive-deletes 'top
      delete-by-moving-to-trash t)

(when (boundp 'dired-kill-when-opening-new-dired-buffer)
  (setq dired-kill-when-opening-new-dired-buffer t))

(add-hook 'dired-mode-hook #'dired-hide-details-mode)
(add-hook 'dired-mode-hook #'dired-omit-mode)

(add-hook 'emacs-startup-hook
          (lambda ()
            (when (display-graphic-p)
              (pdf-tools-install))))

(global-set-key (kbd "C-c j") #'dired-jump)
