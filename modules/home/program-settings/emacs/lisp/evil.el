(setq evil-want-keybinding nil)
(setq evil-want-C-u-scroll t)
(setq evil-want-C-i-jump nil)
(evil-mode 1)

(with-eval-after-load 'evil-collection
  (evil-collection-init))
