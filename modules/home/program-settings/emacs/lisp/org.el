(setq org-directory (expand-file-name "~/org"))

(make-directory org-directory t)

(defvar water/org-agenda-file-names '("inbox.org" "todo.org" "projects.org"))

(defun water/org-file (file)
  (expand-file-name file org-directory))

(defvar water/org-diary-directory (water/org-file "diary"))

(defun water/org-diary-file-for-date (&optional time)
  "Return the diary file path for TIME, creating parent directories."
  (let* ((decoded-time (decode-time (or time (current-time))))
         (day (nth 3 decoded-time))
         (month (nth 4 decoded-time))
         (year (nth 5 decoded-time))
         (dir (expand-file-name (format "%d/%d" year month)
                                water/org-diary-directory))
         (path (expand-file-name (format "%d.org" day) dir)))
    (make-directory dir t)
    (unless (file-exists-p path)
      (with-temp-file path
        (insert (format "#+title: %04d-%d-%d\n\n" year month day))))
    path))

(defun water/org-diary-file-for-today ()
  "Return today's diary file path."
  (water/org-diary-file-for-date))

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
         (file water/org-diary-file-for-today)
         "* %?\n  %U\n"
         :empty-lines 1)))

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
  (setq org-startup-with-inline-images t
        org-image-actual-width nil)
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

(defvar water/org-roam-assets-directory
  (expand-file-name "assets" org-roam-directory)
  "Directory for images inserted into org-roam notes.")

(defun water/org-download-clipboard-method ()
  "Return a shell command that writes the clipboard image to %s."
  (cond
   ((and (eq system-type 'gnu/linux)
         (executable-find "wl-paste"))
    "wl-paste --type image/png > %s")
   ((and (eq system-type 'gnu/linux)
         (executable-find "xclip"))
    "xclip -selection clipboard -t image/png -o > %s")
   ((and (memq system-type '(darwin berkeley-unix))
         (executable-find "pngpaste"))
    "pngpaste %s")
   (t
    (user-error "No clipboard image command available"))))

(defun water/org-download-screenshot-method ()
  "Return a shell command that saves an interactive screenshot to %s."
  (cond
   ((and (eq system-type 'gnu/linux)
         (executable-find "grim")
         (executable-find "slurp"))
    "grim -g \"$(slurp -w 0)\" %s")
   ((and (memq system-type '(darwin berkeley-unix))
         (executable-find "screencapture"))
    "screencapture -i %s")
   (t
    (user-error "No screenshot command available"))))

(defun water/org-download-insert-command-image (command basename)
  "Run COMMAND to create BASENAME, then insert it with org-download."
  (require 'org-download)
  (let ((image-file (expand-file-name basename temporary-file-directory)))
    (when (file-exists-p image-file)
      (delete-file image-file))
    (unwind-protect
        (let ((exit-code (shell-command
                          (format command (shell-quote-argument image-file)))))
          (unless (and (integerp exit-code)
                       (zerop exit-code)
                       (file-exists-p image-file)
                       (> (file-attribute-size (file-attributes image-file)) 0))
            (user-error "No image was written"))
          (org-download-image image-file))
      (when (file-exists-p image-file)
        (delete-file image-file)))))

(defun water/org-download-clipboard ()
  "Insert the current clipboard image into the Org buffer."
  (interactive)
  (water/org-download-insert-command-image
   (water/org-download-clipboard-method)
   "clipboard.png"))

(defun water/org-download-screenshot ()
  "Take a screenshot and insert it into the Org buffer."
  (interactive)
  (water/org-download-insert-command-image
   (water/org-download-screenshot-method)
   "screenshot.png"))

(make-directory org-roam-directory t)
(make-directory water/org-roam-assets-directory t)
(global-set-key (kbd "C-c n f") #'org-roam-node-find)
(global-set-key (kbd "C-c n i") #'org-roam-node-insert)
(global-set-key (kbd "C-c n c") #'org-roam-capture)
(global-set-key (kbd "C-c n l") #'org-roam-buffer-toggle)

(with-eval-after-load 'org
  (when (require 'org-download nil t)
    (setq org-download-method 'directory
          org-download-image-org-width 700
          org-download-annotate-function (lambda (_link) "")
          org-download-abbreviate-filename-function #'file-relative-name)
    (setq-default org-download-heading-lvl nil)

    (defun water/org-download-image-dir ()
      (if-let ((file (buffer-file-name)))
          (let ((dir (expand-file-name "assets" (file-name-directory file))))
            (make-directory dir t)
            dir)
        water/org-roam-assets-directory))

    (defun water/org-set-download-dir ()
      (setq-local org-download-image-dir (water/org-download-image-dir)))

    (add-hook 'org-mode-hook #'water/org-set-download-dir)
    (define-key org-mode-map (kbd "C-c i p") #'water/org-download-clipboard)
    (define-key org-mode-map (kbd "C-c i s") #'water/org-download-screenshot)))

(with-eval-after-load 'org-roam
  (org-roam-db-autosync-mode 1))
