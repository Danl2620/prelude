;; Set misc. variables
;;
(setq-default
 tab-width 4
 truncate-lines t)
(setq
 inhibit-startup-message t
 frame-title-format '("Emacs " " - " " [%b (%f)%+]")
 window-min-height 2
 visible-bell t
 line-number-mode t
 column-number-mode t
 transient-mark-mode t
 cursor-in-non-selected-windows nil
 ;; p4-file-refresh-timer-time 0
 ;; p4-do-find-file nil
 scroll-step 1
 scroll-conservatively 50
 tab-width 4
 truncate-partial-width-windows t

 mac-option-modifier 'meta
 mac-command-modifier 'super

 cua-enable-cursor-indications t
 cua-mode-global-mark-cursor-color "cyan"
 cua-normal-cursor-color "green2"
 cua-overwrite-cursor-color "yellow"
 cua-read-only-cursor-color "darkgreen"

 mouse-wheel-scroll-amount '(1)
 mouse-wheel-progressive-speed t

 show-parens-mode t
 next-line-add-newlines nil
 mouse-yank-at-point t
 auto-save-default nil
 make-backup-files nil)

(setq mac-option-modifier 'meta)
(setq mac-command-modifier 'super)

(windmove-default-keybindings 'meta)


(setq-default
 cua-mode t
 tool-bar-mode -1
 delete-selection-mode 1
 )



(fset 'yes-or-no-p 'y-or-n-p)


(setq projectile-project-search-path '("~/proj/ws"))
(setq *exclude-list* '("SourceAssets" "tdp1.unity" "tdp1.unreal/Content" "tdp1.unreal/Intermediate" "tdp1.unreal/Binaries" "*.uasset" "*.umap" "*.png" ".d"))
(setq projectile-git-command
	  (format "git ls-files -zco --exclude-standard -- . %s"
			  (mapconcat (lambda (path)
						   (format "':!:%s'" path))
						 *exclude-list*
						 " ")))

(push '("\\.frc$" . racket-mode) auto-mode-alist)

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
(c-add-style "my-style"
	     '("stroustrup"
	       (indent-tabs-mode . t)			; use tabs to indent because Unreal
	       (c-basic-offset . 4)			; indent by four spaces
	       (c-offsets-alist . ((inline-open . 0)	; custom indentation rules
				   (brace-list-open . 0)
				   (substatement-open . 0)
				   (statement-case-open . +)
				   ))))

(defun my-c++-mode-hook ()
  (c-set-style "my-style")        ; use my-style defined above
  (auto-fill-mode)
  (c-toggle-auto-hungry-state 1))

(add-hook 'c++-mode-hook 'my-c++-mode-hook)
(add-hook 'c-mode-hook 'my-c++-mode-hook)
