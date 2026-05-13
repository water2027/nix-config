(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq TeX-save-query nil)
(setq TeX-PDF-mode t)
(setq-default TeX-engine 'xetex)
(setq TeX-source-correlate-mode t)
(setq TeX-source-correlate-method 'synctex)
(setq TeX-source-correlate-start-server t)

(with-eval-after-load 'tex
  (add-to-list
   'TeX-command-list
   '("LatexMk"
     "latexmk -xelatex -synctex=1 -interaction=nonstopmode -file-line-error %s"
     TeX-run-TeX nil t
     :help "Run latexmk"))
  (setq TeX-command-default "LatexMk")
  (setq TeX-view-program-selection '((output-pdf "PDF Tools")))
  (add-hook 'TeX-after-compilation-finished-functions
            #'TeX-revert-document-buffer))

(with-eval-after-load 'eglot
  (add-to-list
   'eglot-server-programs
   '((LaTeX-mode latex-mode plain-TeX-mode) . ("texlab"))))

(defun water/latex-completion-setup ()
  (setq-local completion-at-point-functions
              (append completion-at-point-functions
                      '(cape-file cape-dabbrev)))
  (eglot-ensure))

(add-hook 'LaTeX-mode-hook #'visual-line-mode)
(add-hook 'LaTeX-mode-hook #'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook #'turn-on-reftex)
(add-hook 'LaTeX-mode-hook #'turn-on-cdlatex)
(add-hook 'LaTeX-mode-hook #'water/latex-completion-setup)

(setq reftex-plug-into-AUCTeX t)

(pdf-tools-install)
