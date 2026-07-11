(require 'subr-x)

(setq-default indent-tabs-mode nil
              tab-width 2
              fill-column 100)

(setq require-final-newline t
      sentence-end-double-space nil)

(setq select-enable-clipboard t
      save-interprogram-paste-before-kill t)

(defun water/wl-copy (text)
  (when-let ((wl-copy (executable-find "wl-copy")))
    (let ((process-connection-type nil))
      (with-temp-buffer
        (insert text)
        (call-process-region (point-min) (point-max) wl-copy nil nil nil)))))

(defun water/wl-paste ()
  (when-let ((wl-paste (executable-find "wl-paste")))
    (let ((text (with-temp-buffer
                  (when (zerop (call-process wl-paste nil t nil "--no-newline"))
                    (buffer-string)))))
      (unless (string-empty-p text)
        text))))

(when (and (not (display-graphic-p))
           (executable-find "wl-copy")
           (executable-find "wl-paste"))
  (setq interprogram-cut-function #'water/wl-copy
        interprogram-paste-function #'water/wl-paste))

(defun water/show-trailing-whitespace ()
  (setq-local show-trailing-whitespace t))

(add-hook 'prog-mode-hook #'display-fill-column-indicator-mode)
(add-hook 'prog-mode-hook #'water/show-trailing-whitespace)

(add-hook 'text-mode-hook #'visual-line-mode)
(add-hook 'org-mode-hook #'visual-line-mode)
