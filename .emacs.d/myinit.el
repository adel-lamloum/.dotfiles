(scroll-bar-mode -1) ; Disable visible scrollbar
(tool-bar-mode -1) ; Disable tool bar
(tooltip-mode -1) ; Disable tooltips
(set-fringe-mode 10) ; Give some breathing room
(menu-bar-mode -1) ; Disable menu bar
(setq inhibit-startup-message t) ; Disable startup message
(global-hl-line-mode) ; Enable line highlighting
(setq visible-bell t) ; Enable visible bell (disable sound bell)

(set-face-attribute 'default nil :font "FiraCode Nerd Font") ; Set default font
(add-to-list 'default-frame-alist '(font . "FiraCode Nerd Font"))

;; Enable bidi (bidirectional) text support in Emacs
(setq-default bidi-display-reordering t)
(setq-default bidi-paragraph-direction 'left-to-right) ; Set default text direction to LTR

;; Ensure LTR direction in Org-mode
(add-hook 'org-mode-hook
          (lambda ()
            (setq-local bidi-paragraph-direction 'left-to-right)))

;; Define a shortcut for toggling bidi visual mode
(global-set-key (kbd "C-c t") 'bidi-visual-mode)

;; Set default input method to TeX (LTR, English)
(setq default-input-method "TeX")

;; Set Arabic as a secondary input method
(setq default-input-method "arabic")
(global-set-key (kbd "C-\\") 'toggle-input-method)

;; Ensure proper Arabic font rendering
(set-fontset-font t 'arabic "Noto Sans Arabic UI")

(global-set-key (kbd "C-=") 'text-scale-increase) ; Increase text size
(global-set-key (kbd "C--") 'text-scale-decrease) ; Decrease text size
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase) ; Increase text size with mouse wheel
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease) ; Decrease text size with mouse wheel

(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.7)))) ; Customize Org level 1 heading
 '(org-level-2 ((t (:inherit outline-2 :height 1.6)))) ; Customize Org level 2 heading
 '(org-level-3 ((t (:inherit outline-3 :height 1.5)))) ; Customize Org level 3 heading
 '(org-level-4 ((t (:inherit outline-4 :height 1.4)))) ; Customize Org level 4 heading
 '(org-level-5 ((t (:inherit outline-5 :height 1.3)))) ; Customize Org level 5 heading
 '(org-level-6 ((t (:inherit outline-5 :height 1.2)))) ; Customize Org level 6 heading
 '(org-level-7 ((t (:inherit outline-5 :height 1.1))))) ; Customize Org level 7 heading

(add-hook 'org-mode-hook 'org-indent-mode) ; Enable indentation in Org mode
(use-package org-bullets
  :hook (org-mode . (lambda () (org-bullets-mode 1)))) ; Add bullets to Org headings

;;; Aligning Text
(use-package align
  :ensure nil
  :defer t
  :bind ("C-x a a" . align-regexp)
  :config
  ;; Align using spaces
  (defadvice align-regexp (around align-regexp-with-spaces activate)
    (let ((indent-tabs-mode nil))
      ad-do-it)))

(use-package gcmh
  :config (gcmh-mode 1)) ; Enable garbage collection magic hack
(setq gc-cons-threshold 402653184
      gc-cons-percentage 0.6) ; Set garbage collection threshold

(add-hook 'emacs-startup-hook
          (lambda ()
            (message "*** Emacs loaded in %s with %d garbage collections."
                     (format "%.2f seconds"
                             (float-time
                              (time-subtract after-init-time before-init-time)))
                     gcs-done))) ; Profile Emacs startup time

(use-package dashboard
  :ensure t
  :init
  (setq dashboard-banner-logo-title "This Adel's Lamloum Emacs") ; Set dashboard title
  (setq dashboard-set-file-icons t) ; Show file icons
  (setq dashboard-set-heading-icons t) ; Show heading icons
  (setq dashboard-startup-banner "/home/adel/.emacs.d/me.png") ; Set startup banner
  (setq dashboard-items '((recents   . 5)
                          (bookmarks . 5)
                          (projects  . 5)
                          (agenda    . 5))) ; Set dashboard items
  :config
  (dashboard-setup-startup-hook)) ; Enable dashboard on startup

(use-package diminish) ; Diminish mode lines to reduce clutter

(use-package drag-stuff
  :init (drag-stuff-global-mode 1)) ; Enable drag-and-drop for text

(require 'org-tempo) ; Enable tempo templates for Org mode

(use-package toc-org
  :commands toc-org-enable
  :init (add-hook 'org-mode-hook 'toc-org-enable)) ; Generate table of contents in Org mode

(use-package org-ai
  :ensure t
  :commands (org-ai-mode
             org-ai-global-mode)
  :init
  (add-hook 'org-mode-hook #'org-ai-mode) ; enable org-ai in org-mode
  (org-ai-global-mode) ; installs global keybindings on C-c M-a
  :config
  (setq org-ai-default-chat-model "gpt-4") ; if you are on the gpt-4 beta:
  (org-ai-install-yasnippets)) ; if you are using yasnippet and want `ai` snippets

(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit)) ; Use Escape to quit
  :init
  (setq evil-want-keybinding nil) ; Allow Emacs keybindings alongside Vim keybindings
  (setq evil-disable-insert-state-bindings t) ; Allow Emacs keybindings in Insert Mode
  (setq evil-undo-system 'undo-fu) ; Use undo-fu for undo/redo
  :config
  (evil-mode 1)) ; Enable evil-mode

(use-package evil-tutor) ; Interactive tutorial for evil-mode
(use-package evil-collection
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init)) ; Extend evil-mode to other packages

(global-set-key [escape] 'keyboard-escape-quit) ; Use Escape to quit minibuffer

(use-package counsel
  :after ivy
  :diminish
  :config
  (counsel-mode) ; Enable counsel for better completion
  (setq ivy-initial-inputs-alist nil)) ; Remove starting ^ regex in M-x

(use-package ivy
  :bind
  (("C-c C-r" . ivy-resume) ; Resume last Ivy session
   ("C-x B" . ivy-switch-buffer-other-window)) ; Switch buffer in another window
  :diminish
  :custom
  (setq ivy-use-virtual-buffers t) ; Use virtual buffers
  (setq ivy-count-format "(%d/%d) ") ; Show count in Ivy
  (setq enable-recursive-minibuffers t) ; Allow recursive minibuffers
  :config
  (ivy-mode)) ; Enable Ivy mode

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1)) ; Add icons to Ivy

(use-package ivy-rich
  :after ivy
  :ensure t
  :init (ivy-rich-mode 1) ; Enable rich descriptions in Ivy
  :custom
  (ivy-virtual-abbreviate 'full
   ivy-rich-switch-buffer-align-virtual-buffer t
   ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
                               'ivy-rich-switch-buffer-transformer)) ; Enhance Ivy buffer switching

(use-package vertico
  :config (vertico-mode)) ; Enable vertico for vertical completion

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package which-key
  :init (which-key-mode) ; Enable which-key for keybinding hints
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3)) ; Set delay for which-key popup

(use-package corfu
:ensure t
;; Optional customizations
:custom
(corfu-cycle t)                 ; Allows cycling through candidates
(corfu-auto t)                  ; Enable auto completion
(corfu-auto-prefix 2)
(corfu-auto-delay 0.1)
(corfu-popupinfo-delay '(0.5 . 0.2))
(corfu-preview-current 'insert) ; insert previewed candidate
(corfu-preselect 'prompt)
(corfu-on-exact-match nil)      ; Don't auto expand tempel snippets
;; Optionally use TAB for cycling, default is `corfu-complete'.
:bind (:map corfu-map
            ("M-SPC"      . corfu-insert-separator)
            ("TAB"        . corfu-next)
            ([tab]        . corfu-next)
            ("S-TAB"      . corfu-previous)
            ([backtab]    . corfu-previous)
            ("S-<return>" . corfu-insert)
            ("RET"        . nil))

:init
(global-corfu-mode)
(corfu-history-mode)
(corfu-popupinfo-mode)) ; Popup completion info

(use-package general
  :ensure t
  :config
  (general-create-definer my/leader-keys
    :prefix "C-c"
    :prefix-command 'my/leader-keys-map) ; Define leader key for custom keybindings

  (my/leader-keys
    "f" '(:ignore t :which-key "files") ; File-related commands
    "ff" 'find-file ; Open a file
    "fr" 'recentf-open-files ; Open recently used files
    "fd" 'dired ; Open Dired (file manager)
    "fD" 'delete-file ; Delete a file

    "b" '(:ignore t :which-key "buffers") ; Buffer-related commands
    "bb" 'switch-to-buffer ; Switch to a buffer
    "bk" 'kill-buffer ; Kill a buffer
    "bR" 'revert-buffer ; Revert buffer to saved state

    "p" '(:ignore t :which-key "projects") ; Project-related commands
    "pp" 'projectile-switch-project ; Switch to a project
    "pf" 'projectile-find-file ; Find a file in the project
    "ps" 'projectile-ag ; Search in the project

    "g" '(:ignore t :which-key "git/magit") ; Git/Magit commands
    "gs" 'magit-status ; Open Magit status
    "gc" 'magit-commit ; Commit changes
    "gp" 'magit-push ; Push changes

    "w" '(:ignore t :which-key "windows") ; Window-related commands
    "ww" 'other-window ; Switch to another window
    "wd" 'delete-window ; Delete the current window
    "w-" 'split-window-below ; Split window horizontally
    "w/" 'split-window-right ; Split window vertically

    "t" '(:ignore t :which-key "toggle") ; Toggle-related commands
    "tt" 'toggle-truncate-lines ; Toggle line truncation
    "tb" 'toggle-buffer-line-numbers ; Toggle line numbers in the buffer
    "tm" 'toggle-modeline ; Toggle the mode-line
    "d" 'toggle-text-direction ; Toggle text direction

    "n" '(:ignore t :which-key "notes/org") ; Notes/Org-mode commands
    "nn" 'org-capture ; Capture a new note
    "nj" 'org-agenda ; Open the Org agenda
    "nr" 'org-roam-node-find)) ; Find an Org-roam node

  (general-define-key
   :states '(normal visual insert emacs)
   :prefix "C-c"
   :prefix-command 'my/evil-leader-keys
   "e" '(:ignore t :which-key "evil") ; Evil-mode commands
   "ee" 'evil-ex ; Open the evil ex command line
   "en" 'evil-next-line ; Move to the next line
   "ep" 'evil-previous-line) ; Move to the previous line

(use-package beacon
  :ensure t
  :config
  (beacon-mode 1) ; Enable beacon globally
  ;; Customize beacon appearance and behavior
  (setq beacon-color "#ff0000") ; Set the beacon color to red
  (setq beacon-size 20) ; Set the size of the beacon
  (setq beacon-blink-when-point-moves t) ; Blink when the cursor moves
  (setq beacon-blink-when-window-scrolls t) ; Blink when the window scrolls
  (setq beacon-blink-when-window-changes t)) ; Blink when the window changes

(use-package ace-popup-menu
  :ensure t
  :config
  (ace-popup-menu-mode 1) ; Enable ace-popup-menu globally
  ;; Customize ace-popup-menu appearance and behavior
  (setq ace-popup-menu-show-pane-header t) ; Show a header for the popup menu
  (setq ace-popup-menu-style 'full) ; Use the full style for the popup menu
  (setq ace-popup-menu-max-items 10)) ; Set the maximum number of items to display

(use-package haskell-mode) ; Haskell language support

(use-package lua-mode) ; Lua language support

(use-package php-mode) ; PHP language support

(use-package yaml-mode
  :commands yaml-mode) ; YAML language support

(use-package web-mode
  :ensure t
  :mode (("\\.html?\\'" . web-mode)
         ("\\.css\\'" . web-mode)
         ("\\.js\\'" . web-mode)) ; Web development support
  :config
  (setq web-mode-markup-indent-offset 2) ; Set HTML indent offset
  (setq web-mode-css-indent-offset 2) ; Set CSS indent offset
  (setq web-mode-code-indent-offset 2)) ; Set JS indent offset

(use-package css-mode
  :ensure t
  :mode ("\\.css\\'" . css-mode)) ; CSS language support

(use-package scss-mode
  :ensure t
  :mode ("\\.scss\\'" . scss-mode)) ; SCSS language support

(use-package js2-mode
  :ensure t
  :mode ("\\.js\\'" . js2-mode) ; JavaScript language support
  :config
  (setq js2-basic-offset 2)) ; Set JS indent offset

(use-package typescript-mode
  :ensure t
  :mode ("\\.ts\\'" . typescript-mode) ; TypeScript language support
  :config
  (setq typescript-indent-level 2)) ; Set TypeScript indent level

(use-package python-mode
  :ensure t
  :mode ("\\.py\\'" . python-mode) ; Python language support
  :config
  (setq python-indent-offset 4)) ; Set Python indent offset

(use-package lsp-mode
  :ensure t
  :hook ((python-mode . lsp)) ; Enable LSP for Python
  :commands lsp) ; Language Server Protocol support

(use-package lsp-pyright
  :ensure t
  :hook (python-mode . (lambda ()
                         (require 'lsp-pyright)
                         (lsp)))) ; Pyright LSP for Python

(add-to-list 'auto-mode-alist '("\\.sh\\'" . sh-mode)) ; Bash scripting support
(setq sh-basic-offset 2) ; Set Bash indent offset

(use-package company-shell
  :ensure t
  :config
  (add-to-list 'company-backends 'company-shell)) ; Shell auto-completion

;; Enable abbrev-mode globally
(setq-default abbrev-mode t)

;; Save abbreviations between sessions
(setq save-abbrevs 'silently)

;; Define global abbreviations
(define-abbrev global-abbrev-table "i" "I")
(define-abbrev global-abbrev-table "emacs" "Emacs")
(define-abbrev global-abbrev-table "linux" "Linux")

;; Disable abbrev-mode in programming modes
(add-hook 'prog-mode-hook (lambda () (abbrev-mode -1)))

;; Enable abbrev-mode in org-mode and text-mode
(add-hook 'org-mode-hook 'abbrev-mode)
(add-hook 'text-mode-hook 'abbrev-mode)

(defun capitalize-first-letter-of-line ()
  "Capitalize the first letter of the current line, including org-mode headings, text, and markdown."
  (interactive)
  (save-excursion
    (beginning-of-line)
    (when (or (and (derived-mode-p 'org-mode) (looking-at "[ \t]*\\*+[ \t]*[a-z]")) ; Org headings
              (and (derived-mode-p 'markdown-mode) (looking-at "[ \t]*#+[ \t]*[a-z]")) ; Markdown headings
              (looking-at "[a-z]")) ; Regular lines
      (capitalize-word 1))))

;; Enable in org-mode, text-mode, and markdown-mode
(add-hook 'org-mode-hook
          (lambda () (add-hook 'post-self-insert-hook 'capitalize-first-letter-of-line nil t)))
(add-hook 'text-mode-hook
          (lambda () (add-hook 'post-self-insert-hook 'capitalize-first-letter-of-line nil t)))
(add-hook 'markdown-mode-hook
          (lambda () (add-hook 'post-self-insert-hook 'capitalize-first-letter-of-line nil t)))

(use-package hl-todo
  :hook ((org-mode . hl-todo-mode)
         (prog-mode . hl-todo-mode)) ; Highlight TODO keywords
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"       warning bold)
          ("FIXME"      error bold)
          ("HACK"       font-lock-constant-face bold)
          ("REVIEW"     font-lock-keyword-face bold)
          ("NOTE"       success bold)
          ("DEPRECATED" font-lock-doc-face bold))))

(use-package colorful-mode
  :ensure t
  :hook (prog-mode text-mode)) ; Add colors to programming and text modes

(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (python . t))) ; Enable Org Babel for shell and Python

(use-package htmlize) ; HTML export for code snippets

(use-package markdown-mode
  :ensure t
  :mode (("\\.md\\'" . markdown-mode)
         ("\\.markdown\\'" . markdown-mode)) ; Markdown language support
  :init (setq markdown-command "markdown")) ; Set Markdown command

(use-package markdown-preview-mode
  :ensure t) ; Markdown preview support

(use-package org-download) ; Drag-and-drop images into Org mode

(add-hook 'org-mode-hook 'org-indent-mode) ; Enable indentation in Org mode
(use-package org-bullets
  :hook (org-mode . (lambda () (org-bullets-mode 1)))) ; Add bullets to Org headings

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1) ; Enable doom-modeline
  :config
  (set-face-attribute 'region nil :background "#add8e6")) ; Customize region highlight color

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p)) ; Add icons for graphical Emacs

(use-package all-the-icons-dired
  :hook (dired-mode . (lambda () (all-the-icons-dired-mode t)))) ; Add icons to Dired

(use-package neotree
  :after general
  :config
  (setq neo-smart-open t
        neo-show-hidden-files t
        neo-window-width 55
        neo-window-fixed-size nil
        inhibit-compacting-font-caches t
        projectile-switch-project-action 'neotree-projectile-action) ; NeoTree configuration

  ;; Truncate long file names in NeoTree
  (add-hook 'neo-after-create-hook
            #'(lambda (_)
                (with-current-buffer (get-buffer neo-buffer-name)
                  (setq truncate-lines t)
                  (setq word-wrap nil)
                  (make-local-variable 'auto-hscroll-mode)
                  (setq auto-hscroll-mode nil)))))

;; Define keybindings using general.el
(general-define-key
 :prefix "C-c" ;; Use the leader key defined above
 "t" 'neotree-toggle ;; Toggle NeoTree with "C-c t"
 "p" 'neotree-projectile-toggle ;; Toggle NeoTree with Projectile integration using "C-c p"
 "r" 'neotree-refresh) ;; Refresh NeoTree with "C-c r"

(use-package sudo-edit
  :ensure t
  :bind (("C-x x f" . sudo-edit-find-file)
         ("C-x x e" . sudo-edit))) ; Edit files with sudo

(use-package fountain-mode
  :ensure t
  :mode ("\\.fountain\\'" . fountain-mode))

(use-package centaur-tabs
  :ensure t
  :config
  (centaur-tabs-mode t) ; Enable centaur-tabs

  (defun my-centaur-tabs-buffer-mode-icon (buffer)
    "Return the icon for BUFFER based on its major mode using nerd-icons."
    (with-current-buffer buffer
      (let ((icon (nerd-icons-icon-for-mode major-mode)))
        (if (symbolp icon)
            (nerd-icons-icon-for-file (buffer-name))
          icon))))

  (setq centaur-tabs-buffer-groups-function #'my-centaur-tabs-buffer-groups)

  (defun my-centaur-tabs-buffer-groups ()
    "Return the list of group names BUFFER belongs to."
    (list (my-centaur-tabs-buffer-mode-icon (current-buffer))))

  (setq centaur-tabs-style "bar"
        centaur-tabs-height 32
        centaur-tabs-set-modified-marker t)) ; Customize centaur-tabs appearance

(use-package highlight-indent-guides
  :ensure t
  :hook ((prog-mode . highlight-indent-guides-mode))) ; Highlight indentation guides

(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1)) ; Enable EditorConfig support

(use-package magit
  :ensure t
  :bind ("C-x g" . magit-status)) ; Magit for Git integration

(use-package projectile
  :ensure t
  :config
  (projectile-mode +1) ; Enable Projectile
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map) ; Define Projectile keybindings

  ;; Add C-c p f to the projectile-command-map
  (define-key projectile-command-map (kbd "f") 'projectile-find-file)) ; Find file in project

(use-package leuven-theme
:ensure t
:config
(load-theme 'leuven t) ; Load the leuven theme
;; Customize background and foreground colors
(set-face-background 'default "#fbf0d9") ; Sepia background
(set-face-foreground 'default "#3a3a3a") ; Dark gray text
;; Customize mode-line
(set-face-background 'mode-line "#e0d5c0") ; Sepia-like mode-line background
(set-face-foreground 'mode-line "#3a3a3a") ; Dark gray mode-line text
;; Customize fringe
(set-face-background 'fringe "#fbf0d9") ; Match fringe background to default
;; Customize line numbers
(set-face-foreground 'line-number "#6a6a6a") ; Light gray line numbers
;; Customize cursor
(set-face-background 'cursor "#6a6a6a") ; Gray cursor
;; Customize highlight
(set-face-background 'highlight "#e0d5c0") ; Sepia-like highlight
;; Customize region (selection)
(set-face-background 'region "#d0c5b0")) ; Light sepia region

(use-package smartparens
  :ensure smartparens ; Install smartparens
  :hook (prog-mode text-mode markdown-mode) ; Enable smartparens in these modes
  :config
  (require 'smartparens-config)) ; Load default smartparens configuration

(use-package flycheck
  :ensure t
  :init (global-flycheck-mode) ; Enable Flycheck for syntax checking
  :config
  (setq-default flycheck-python-flake8-executable "flake8") ; Set Python checker to flake8
  (setq flycheck-indication-mode 'left-fringe)) ; Show errors in the left fringe
