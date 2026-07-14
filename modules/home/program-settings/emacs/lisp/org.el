(setq org-directory (expand-file-name "~/org"))

(make-directory org-directory t)

(defvar water/org-agenda-file-names '("inbox.org" "todo.org" "projects.org"))

(defun water/org-file (file)
  (expand-file-name file org-directory))

(dolist (file water/org-agenda-file-names)
  (let ((path (water/org-file file)))
    (unless (file-exists-p path)
      (with-temp-file path))))

(setq org-default-notes-file (water/org-file "inbox.org")
      org-agenda-files (mapcar #'water/org-file water/org-agenda-file-names)
      org-refile-targets '((org-agenda-files . (:maxlevel . 3)))
      org-refile-allow-creating-parent-nodes 'confirm
      org-outline-path-complete-in-steps nil
      org-refile-use-outline-path 'file
      org-archive-location "%s_archive::"
      org-todo-keywords '((sequence "TODO(t)" "NEXT(n)" "WAIT(w@)" "|" "DONE(d!)" "CANCELED(c@)"))
      org-log-into-drawer t
      org-capture-templates
      `(("i" "Inbox" entry
         (file ,(water/org-file "inbox.org"))
         "* TODO %?\n  %U\n")
        ("t" "Todo" entry
         (file ,(water/org-file "todo.org"))
         "* TODO %?\n  %U\n")
        ("j" "Journal" entry
         (file+datetree ,(water/org-file "journal.org"))
         "* %?\n  %U\n")))

(global-set-key (kbd "C-c a") #'org-agenda)
(global-set-key (kbd "C-c c") #'org-capture)

(with-eval-after-load 'org
  (setq org-log-done 'time
        org-startup-indented nil
        org-hide-emphasis-markers t
        org-src-window-setup 'current-window
        org-src-preserve-indentation t
        org-edit-src-content-indentation 0
        org-src-tab-acts-natively t)
  (org-babel-do-load-languages
   'org-babel-load-languages
   '((shell . t)
     (js . t)))
  (setq org-confirm-babel-evaluate t
        org-babel-js-cmd "node"
        org-babel-default-header-args:shell '((:results . "output"))
        org-babel-default-header-args:js '((:results . "output"))
        org-babel-default-header-args:typescript '((:results . "output"))
        org-babel-default-header-args:ts '((:results . "output")))
  (dolist (lang-mode '(("typescript" . typescript-ts)
                       ("ts" . typescript-ts)))
    (add-to-list 'org-src-lang-modes lang-mode))
  (dolist (lang-ext '(("typescript" . "ts")
                      ("ts" . "ts")))
    (add-to-list 'org-babel-tangle-lang-exts lang-ext))
  (when (require 'org-modern nil t)
    (global-org-modern-mode 1)))

(defvar water/org-babel-typescript-command "node"
  "Default command used to execute TypeScript Org Babel blocks.")

(defun water/org-babel-typescript-resolve-command ()
  (or (executable-find water/org-babel-typescript-command)
      (executable-find "bun")
      (executable-find "node")
      (user-error "Neither node nor bun is available for TypeScript Babel blocks")))

(defun org-babel-execute:typescript (body params)
  "Execute a TypeScript source block with Node's type stripping or Bun."
  (let* ((tmp-file (org-babel-temp-file "typescript-" ".ts"))
         (cmd (mapconcat #'shell-quote-argument
                         (list (water/org-babel-typescript-resolve-command) tmp-file)
                         " ")))
    (with-temp-file tmp-file
      (insert (org-babel-expand-body:generic body params)))
    (org-babel-eval cmd "")))

(defalias 'org-babel-execute:ts #'org-babel-execute:typescript)

(setq org-roam-directory (file-truename "~/org/roam")
      org-roam-completion-everywhere t
      org-roam-capture-templates
      '(("d" "default" plain
         "%?"
         :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n")
         :unnarrowed t)
        ("t" "tagged note" plain
         "%?"
         :target (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                            "#+title: ${title}\n#+filetags: :%^{tags}:\n")
         :unnarrowed t)))

(make-directory org-roam-directory t)
(global-set-key (kbd "C-c n f") #'org-roam-node-find)
(global-set-key (kbd "C-c n i") #'org-roam-node-insert)
(global-set-key (kbd "C-c n c") #'org-roam-capture)
(global-set-key (kbd "C-c n l") #'org-roam-buffer-toggle)

(with-eval-after-load 'org-roam
  (org-roam-db-autosync-mode 1))
