(vertico-mode 1)
(marginalia-mode 1)
(which-key-mode 1)
(global-corfu-mode 1)
(yas-global-mode 1)

(setq completion-styles '(orderless basic))
(setq completion-category-defaults nil)
(setq completion-category-overrides '((file (styles partial-completion))))

(setq corfu-auto t)
(setq corfu-auto-prefix 2)
(setq corfu-auto-delay 0.1)
(setq corfu-cycle t)
(setq corfu-preselect 'prompt)

(with-eval-after-load 'corfu
  (corfu-popupinfo-mode 1))
