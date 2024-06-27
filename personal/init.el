;;
;; My customization!!
;;

;; Set misc. variables
;;
(setq-default
 tab-width 4
 truncate-lines t
 indent-tabs-mode nil
 )

(setq
 inhibit-startup-message t
 indent-tabs-mode nil
 frame-title-format '(Emacs  " - " " [%b (%f)%+]")
 window-min-height 2
 visible-bell t
 cursor-in-non-selected-windows nil
 ;; p4-file-refresh-timer-time 0
 ;; p4-do-find-file nil
 scroll-step 1
 scroll-conservatively 50
 truncate-partial-width-windows t

 mac-option-modifier 'meta
 mac-command-modifier 'super
 mac-right-command-modifier 'super

 ;;mouse-wheel-scroll-amount 1
 ;;mouse-wheel-progressive-speed t
 next-line-add-newlines nil
 ;;mouse-yank-at-point t
 auto-save-default nil
 make-backup-files nil
 )


(delete-selection-mode 1)
(tool-bar-mode -1)
(cua-mode t)
(line-number-mode t)
(column-number-mode t)
(transient-mark-mode t)

(fset 'yes-or-no-p 'y-or-n-p)

;; set up git
(with-eval-after-load 'magit
  (require 'forge))


(push '("\\.frc$" . racket-mode) auto-mode-alist)
(push '("\\.rkt$" . racket-mode) auto-mode-alist)

(defun ws-build ()
  (interactive)
  (let ((buf (get-buffer "*compilation*")))
    (when buf
      (when (get-buffer-window buf)
        (select-window (get-buffer-window buf)))

      (switch-to-buffer buf)))

  (save-some-buffers t)
  (when (equal "*compilation*" (buffer-name))
    (goto-char (point-max)))
  (call-interactively 'compile))


;; setup c++ mode
(c-add-style "rs-style"
             '("stroustrup"
               (c-basic-offset . 4)         ; indent by four spaces
               (c-offsets-alist . ((inline-open . 0)    ; custom indentation rules
                                   (brace-list-open . 0)
                                   (substatement-open . 0)
                                   (statement-case-open . 0)
				                   (case-label . +)
				                   (statement-cont . 0)
                                   (innamespace . [0])
                                   ))))

(c-add-style "unreal-style"
         '("stroustrup"
           (indent-tabs-mode . t)           ; use tabs to indent because Unreal
           (c-basic-offset . 4)         ; indent by four spaces
           (c-offsets-alist . ((inline-open . 0)    ; custom indentation rules
                   (brace-list-open . 0)
                   (substatement-open . 0)
                   (statement-case-open . 0)
				   (case-label . +)
				   (statement-cont . 0)
                   ))))

(defun my-c++-mode-hook ()
  (c-set-style "rs-style")
  (auto-fill-mode)
  (c-toggle-auto-hungry-state 1))

(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(add-hook 'c-mode-hook 'my-c++-mode-hook)

;; set up Nickel mode
(require 'nickel-mode)
(require 'lsp-mode)

(add-to-list 'lsp-language-id-configuration '(nickel-mode . "nickel"))
(lsp-register-client (make-lsp-client
                      :new-connection (lsp-stdio-connection "nls")
			          :activation-fn (lsp-activate-on "nickel")
                      :server-id 'nls
                      :major-modes 'nickel-mode))
(add-hook 'nickel-mode-hook 'lsp-deferred)


;; keys
(global-set-key [f1] 'help)
(global-set-key [f3] 'projectile-find-other-file)
(global-set-key [f4] 'comment-region)
(global-set-key [S-f4] 'uncomment-region)
(global-set-key [f7] 'ws-build)
(global-set-key [f8] 'projectile-ag)
(global-set-key [f11] 'other-window)
(global-set-key [S-f11] 'delete-other-windows)
(global-set-key [f12] 'save-buffer)
(global-set-key [C-tab] 'ivy-switch-buffer)
(global-set-key "\C-b" 'ibuffer)
(global-set-key "\C-d" 'ivy-dired)
(global-set-key "\C-f" 'swiper)
(global-set-key "\C-h" 'query-replace)
(global-set-key "\C-j" 'goto-line)
;; (global-set-key [s-right] 'end-of-line)
;; (global-set-key [s-left] 'beginning-of-line)
(global-set-key [M-left] 'backward-sexp)
(global-set-key [M-right] 'forward-sexp)
;; (global-set-key [C-up] 'pager-row-up)
;; (global-set-key [C-down] 'pager-row-down)

;; set up project
(projectile-register-project-type
 'keystone
 '("Keystone.code-workspace")
 :project-file "Keystone.code-workspace"
 :compile "bazel build //..."
 )


;; (defun run-tdp1 ()
;;   (interactive)
;;   (let ((buf (get-buffer "*tdp1-log*")))
;;     (when buf
;;       (when (get-buffer-window buf)
;;         (select-window (get-buffer-window buf)))

;;       (switch-to-buffer buf)
;;       )

;;     (goto-char (point-max))
;;     (call-interactively )

;;     ))

;; theme!
(load-theme 'wombat t)

(set-face-attribute 'default nil :height 180)


(provide 'init)
;;; init.el ends here
