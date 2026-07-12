(require 'apheleia)

(setq apheleia-formatters-respect-indent-level nil)

(setf (alist-get 'eslint-d apheleia-formatters)
      '("eslint_d" "--fix-to-stdout" "--stdin" "--stdin-filename" filepath))

(dolist (mode '(typescript-mode typescript-ts-mode tsx-ts-mode
                js-mode js-ts-mode js-jsx-mode
                vue-mode))
  (setf (alist-get mode apheleia-mode-alist) 'eslint-d))

(apheleia-global-mode 1)
