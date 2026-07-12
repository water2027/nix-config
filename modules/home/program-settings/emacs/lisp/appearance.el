;; Keep terminal Emacs readable on dark/transparent terminal backgrounds.
(load-theme 'modus-vivendi t)

(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))

(defvar water/gui-font-family "Maple Mono NF CN")
(defvar water/gui-font-size 16)
(defvar water/gui-font-default-size 16)

(defun water/gui-font-spec ()
  (format "%s-%d" water/gui-font-family water/gui-font-size))

(defun water/update-default-frame-font ()
  (setq default-frame-alist (assq-delete-all 'font default-frame-alist))
  (add-to-list 'default-frame-alist `(font . ,(water/gui-font-spec))))

(defun water/apply-gui-font (&optional frame)
  (let ((frame (or frame (selected-frame))))
    (when (display-graphic-p frame)
      (set-frame-font (water/gui-font-spec) nil (list frame)))))

(defun water/set-gui-font-size (size)
  (interactive "nGUI font size: ")
  (setq water/gui-font-size (max 8 size))
  (water/update-default-frame-font)
  (dolist (frame (frame-list))
    (water/apply-gui-font frame))
  (message "GUI font size: %d" water/gui-font-size))

(defun water/increase-gui-font-size ()
  (interactive)
  (water/set-gui-font-size (1+ water/gui-font-size)))

(defun water/decrease-gui-font-size ()
  (interactive)
  (water/set-gui-font-size (1- water/gui-font-size)))

(defun water/reset-gui-font-size ()
  (interactive)
  (water/set-gui-font-size water/gui-font-default-size))

(water/update-default-frame-font)
(water/apply-gui-font)
(add-hook 'after-make-frame-functions #'water/apply-gui-font)

(global-set-key (kbd "C-c C-+") #'water/increase-gui-font-size)
(global-set-key (kbd "C-c C-=") #'water/increase-gui-font-size)
(global-set-key (kbd "C-c C--") #'water/decrease-gui-font-size)
(global-set-key (kbd "C-c C-0") #'water/reset-gui-font-size)
