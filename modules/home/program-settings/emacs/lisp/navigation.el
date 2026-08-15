(use-package consult
  :ensure nil
  :defer t)

(use-package embark-consult
  :ensure nil
  :after (embark consult))

(require 'project)

(defun water/project-root ()
  (when-let ((project (project-current)))
    (project-root project)))

(defun water/consult-ripgrep-project ()
  (interactive)
  (consult-ripgrep (or (water/project-root) default-directory)))

(defun water/project-dired ()
  (interactive)
  (dired (or (water/project-root) default-directory)))

(global-set-key (kbd "C-s") #'consult-line)
(global-set-key (kbd "C-x b") #'consult-buffer)
(global-set-key (kbd "M-y") #'consult-yank-pop)
(global-set-key (kbd "M-g g") #'consult-goto-line)
(global-set-key (kbd "M-g o") #'consult-outline)
(global-set-key (kbd "C-c s") #'consult-ripgrep)
(global-set-key (kbd "C-c f") #'consult-find)

(add-hook 'embark-collect-mode-hook #'consult-preview-at-point-mode)

(define-prefix-command 'water/project-map)
(global-set-key (kbd "C-c p") 'water/project-map)
(define-key water/project-map (kbd "p") #'project-switch-project)
(define-key water/project-map (kbd "f") #'project-find-file)
(define-key water/project-map (kbd "b") #'consult-project-buffer)
(define-key water/project-map (kbd "s") #'water/consult-ripgrep-project)
(define-key water/project-map (kbd "d") #'water/project-dired)
(define-key water/project-map (kbd "k") #'project-kill-buffers)
