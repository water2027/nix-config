(setq-default indent-tabs-mode nil
              tab-width 2
              fill-column 100)

(setq require-final-newline t
      sentence-end-double-space nil)

(defun water/show-trailing-whitespace ()
  (setq-local show-trailing-whitespace t))

(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(add-hook 'prog-mode-hook #'water/show-trailing-whitespace)

(add-hook 'text-mode-hook #'visual-line-mode)
(add-hook 'org-mode-hook #'visual-line-mode)
