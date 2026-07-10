(setq org-directory (expand-file-name "~/org"))

(make-directory org-directory t)

(setq org-default-notes-file (expand-file-name "inbox.org" org-directory)
      org-agenda-files (directory-files-recursively org-directory "\\.org$")
      org-refile-targets '((org-agenda-files . (:maxlevel . 3)))
      org-outline-path-complete-in-steps nil
      org-refile-use-outline-path 'file
      org-capture-templates
      `(("t" "Todo" entry
         (file ,(expand-file-name "inbox.org" org-directory))
         "* TODO %?\n  %U\n")
        ("n" "Note" entry
         (file ,(expand-file-name "inbox.org" org-directory))
         "* %?\n  %U\n")
        ("j" "Journal" entry
         (file+datetree ,(expand-file-name "journal.org" org-directory))
         "* %?\n  %U\n")))

(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

(with-eval-after-load 'org
  (setq org-log-done 'time
        org-startup-indented t
        org-hide-emphasis-markers t))

(setq org-roam-directory (file-truename "~/org/roam"))
(global-set-key (kbd "C-c n f") #'org-roam-node-find)
(global-set-key (kbd "C-c n i") #'org-roam-node-insert)
(global-set-key (kbd "C-c n c") #'org-roam-capture)
(global-set-key (kbd "C-c n l") #'org-roam-buffer-toggle)

(with-eval-after-load 'org-roam
  (org-roam-db-autosync-mode 1))
