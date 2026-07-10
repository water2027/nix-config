(require 'diff-hl)

(global-diff-hl-mode 1)

(when (fboundp 'diff-hl-flydiff-mode)
  (diff-hl-flydiff-mode 1))

(with-eval-after-load 'magit
  (add-hook 'magit-post-refresh-hook #'diff-hl-magit-post-refresh))

(global-set-key (kbd "C-x g") #'magit-status)

(define-prefix-command 'water/git-map)
(global-set-key (kbd "C-c g") 'water/git-map)
(define-key water/git-map (kbd "s") #'magit-status)
(define-key water/git-map (kbd "n") #'diff-hl-next-hunk)
(define-key water/git-map (kbd "p") #'diff-hl-previous-hunk)
(define-key water/git-map (kbd "r") #'diff-hl-revert-hunk)
(define-key water/git-map (kbd "d") #'diff-hl-show-hunk)
