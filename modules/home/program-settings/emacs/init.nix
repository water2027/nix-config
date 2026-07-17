{ pkgs, ... }:

let
  treesitLibrarySuffix = if pkgs.stdenv.hostPlatform.isDarwin then "dylib" else "so";
in
{
  home.file = {
    ".emacs.d/init.el".text = ''
      (let ((config-dir (expand-file-name "lisp" user-emacs-directory)))
        (dolist (file '("core.el"
                        "editing.el"
                        "formatting.el"
                        "appearance.el"
                        "org.el"
                        "git.el"
                        "feed.el"
                        "completion.el"
                        "navigation.el"
                        "files.el"
                        "env.el"
                        "lsp.el"))
          (load-file (expand-file-name file config-dir))))
    '';

    ".emacs.d/lisp/core.el".source = ./lisp/core.el;
    ".emacs.d/lisp/editing.el".source = ./lisp/editing.el;
    ".emacs.d/lisp/formatting.el".source = ./lisp/formatting.el;
    ".emacs.d/lisp/appearance.el".source = ./lisp/appearance.el;
    ".emacs.d/lisp/org.el".source = ./lisp/org.el;
    ".emacs.d/lisp/git.el".source = ./lisp/git.el;
    ".emacs.d/lisp/feed.el".source = ./lisp/feed.el;
    ".emacs.d/lisp/completion.el".source = ./lisp/completion.el;
    ".emacs.d/lisp/navigation.el".source = ./lisp/navigation.el;
    ".emacs.d/lisp/files.el".source = ./lisp/files.el;
    ".emacs.d/lisp/env.el".source = ./lisp/env.el;
    ".emacs.d/lisp/lsp.el".source = ./lisp/lsp.el;

    ".emacs.d/tree-sitter/libtree-sitter-typescript.${treesitLibrarySuffix}".source =
      "${pkgs.tree-sitter-grammars.tree-sitter-typescript}/parser";
    ".emacs.d/tree-sitter/libtree-sitter-tsx.${treesitLibrarySuffix}".source =
      "${pkgs.tree-sitter-grammars.tree-sitter-tsx}/parser";
    ".emacs.d/tree-sitter/libtree-sitter-typst.${treesitLibrarySuffix}".source =
      "${pkgs.tree-sitter-grammars.tree-sitter-typst}/parser";
  };
}
