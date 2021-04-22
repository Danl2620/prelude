;;; Code:
(prelude-require-package 'eglot)

(defvar *clangd-program* "/usr/local/Cellar/llvm/11.0.0/bin/clangd")

(require 'eglot)
(add-to-list 'eglot-server-programs '((c++-mode c-mode) *clangd-program*))
(add-hook 'c-mode-hook 'eglot-ensure)
(add-hook 'c++-mode-hook 'eglot-ensure)

(provide 'prelude-eglot)
