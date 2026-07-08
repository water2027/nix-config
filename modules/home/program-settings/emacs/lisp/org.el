(setq org-directory "~/org")
(setq org-agenda-files (list org-directory))
(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

(with-eval-after-load 'org
  (setq org-log-done 'time))

(setq org-roam-directory (file-truename "~/org/roam"))
(global-set-key (kbd "C-c n f") #'org-roam-node-find)
(global-set-key (kbd "C-c n i") #'org-roam-node-insert)
(global-set-key (kbd "C-c n c") #'org-roam-capture)
(global-set-key (kbd "C-c n l") #'org-roam-buffer-toggle)

(with-eval-after-load 'org-roam
  (org-roam-db-autosync-mode 1))

(global-set-key (kbd "C-x g") #'magit-status)
(global-set-key (kbd "C-c e") #'elfeed)
