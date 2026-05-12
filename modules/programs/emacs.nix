{ pkgs, ... }:

{
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;

    extraPackages = epkgs: with epkgs; [
      consult
      corfu
      elfeed
      magit
      marginalia
      markdown-mode
      orderless
      org-roam
      vertico
      which-key
    ];
  };

  home.file.".emacs.d/init.el".text = ''
    (setq inhibit-startup-screen t)
    (setq make-backup-files nil)
    (setq auto-save-default nil)

    (global-display-line-numbers-mode 1)
    (column-number-mode 1)

    (setq org-directory "~/org")
    (setq org-agenda-files (list org-directory))
    (global-set-key (kbd "C-c a") #'org-agenda)

    (with-eval-after-load 'org
      (setq org-log-done 'time))

    (setq org-roam-directory (file-truename "~/org/roam"))

    (vertico-mode 1)
    (marginalia-mode 1)
    (which-key-mode 1)
    (global-corfu-mode 1)

    (setq completion-styles '(orderless basic))
    (setq completion-category-defaults nil)
    (setq completion-category-overrides '((file (styles partial-completion))))
  '';
}
