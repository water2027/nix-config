(setq org-directory "~/org")
(setq org-agenda-files (list org-directory))
(global-set-key (kbd "C-c a") #'org-agenda)

(with-eval-after-load 'org
  (setq org-log-done 'time))

(setq org-roam-directory (file-truename "~/org/roam"))
