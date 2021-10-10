;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "Anonymice Nerd Font" :size 15 ))
(setq doom-themes-treemacs-variable-pitch-face nil)

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-zenburn)
(setq doom-themes-treemacs-theme "doom-colors")

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; tsx
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (tide-setup))))

;; twittering
(setq twittering-use-master-password t)
(setq twittering-allow-insecure-server-cert t)

;; powerline fonts fix
(setq doom-emoji-fallback-font-families nil)

;; formatting
(setq-default tab-width 2)
(setq tide-format-options '(:tabSize 2 :indentSize 2))
(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'web-mode-hook 'prettier-js-mode)
(add-hook 'tide-mode-hook 'prettier-js-mode)

;; elcord icons
(setq elcord-editor-icon "emacs_material_icon")
(setq elcord-mode-icon-alist '((web-mode . "typescript-mode_icon")))

;; keybinds
(map! :localleader
        (:map tide-mode-map
        :desc "Code Actions"
        "." #'tide-fix))

;; setting PATH
(setenv "PATH" "/opt/homebrew/opt/curl/bin:/opt/homebrew/bin:/opt/homebrew/opt/llvm/bin:/opt/homebrew/opt/libarchive/bin:/opt/homebrew/opt/ncurses/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/Library/Apple/usr/bin")

;; org
(setq org-directory "~/Dropbox/Org/")
(setq org-agenda-files '("~/Dropbox/Org/"))
(add-hook 'org-mode-hook 'org-bullets-mode)

;; battery
(unless (equal "Battery status not available"
               (battery))
  (display-battery-mode 1))

;; pseudocode
(defun sam/to-pseudocode ()
    (interactive)
    (save-window-excursion
      (shell-command (concat "translate-py "(buffer-file-name)))))
(map! :localleader
      (:map anaconda-mode-map
       :desc "Convert to pseudocode"
       "p" #'sam/to-pseudocode))
