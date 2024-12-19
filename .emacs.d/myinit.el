(scroll-bar-mode -1) ; disable visible scrollbar
        (tool-bar-mode -1) ; disable tool bar
        (tooltip-mode -1) ; disable tooltips
        (set-fringe-mode 10) ; give some breathing room
        (menu-bar-mode -1) ;disable menu bar
      (setq inhibit-startup-message t)

  ;; Enable bidi (bidirectional) text support in Emacs
(setq-default bidi-display-reordering t)

;; Set default text direction to left-to-right (LTR) globally
(setq-default bidi-paragraph-direction 'left-to-right)

;; Ensure LTR direction in Org-mode (for titles, paragraphs, etc.)
(add-hook 'org-mode-hook
          (lambda ()
            (setq-local bidi-paragraph-direction 'left-to-right)))  ;; Enforce LTR in Org-mode

;; Define a shortcut for toggling bidi visual mode (useful if you switch between Arabic and English)
(global-set-key (kbd "C-c t") 'bidi-visual-mode)  ;; Toggle bidi visual mode with C-c t

;; Force Org-mode files to start with LTR direction (especially for titles like #+TITLE)
(add-hook 'org-mode-hook
          (lambda ()
            (if (not (looking-at "\\s-*$"))
                (setq bidi-paragraph-direction 'left-to-right))))  ;; Force LTR in Org-mode

;; Force LTR in all buffers
(setq-default bidi-paragraph-direction 'left-to-right)  ;; Set default direction globally to LTR

;; Set the default input method to TeX (LTR, English) on startup
(setq default-input-method "TeX")  ;; Default input method is English (LTR)

;; Set Arabic as a secondary input method for easy switching
(setq default-input-method "arabic")

;; Enable the ability to toggle between input methods with C-\
(global-set-key (kbd "C-\\") 'toggle-input-method)

;; Ensure proper Arabic font rendering (change this to your preferred Arabic font)
(set-fontset-font t 'arabic "Amiri" nil 'prepend)  ;; Set Arabic font (Amiri is an example)

;; Ensure LTR by default when typing in Arabic (no automatic switch to RTL)
(setq-default bidi-paragraph-direction 'left-to-right) ;; Always use LTR even with Arabic input

;; Enable visible bell (disable sound bell)
(setq visible-bell t)

;; Set the default font for Emacs (adjust to your preferred font)
(set-face-attribute 'default nil :font "JetBrains Mono NL" :height 105)  ;; Set font

;; Enable line numbers in Org-mode
(add-hook 'org-mode-hook #'display-line-numbers-mode)

;; Enable visual line mode (helps with soft wrapping in text-based modes)
(add-hook 'text-mode-hook 'visual-line-mode)
(add-hook 'org-mode-hook 'visual-line-mode)
(add-hook 'markdown-mode-hook 'visual-line-mode)

;; Optional: Set preferred text width (80 characters) for text wrapping
(setq-default fill-column 80)

;; Ensure that all buffers start with LTR paragraph direction (not RTL)
(add-hook 'after-init-hook
          (lambda ()
            (setq bidi-paragraph-direction 'left-to-right)))  ;; Enforce LTR globally after init

  ; Optional: Set preferred text width (80 characters) for text wrapping
  (setq-default fill-column 80)


        ;; set line numbers
        (add-hook 'org-mode-hook #'display-line-numbers-mode)

(use-package dashboard
:ensure t
:init
;;set dashboard banner title
(setq dashboard-banner-logo-title "This Adel`s Lamloum Emacs")
(setq dashboard-set-file-icons t) ;show files icons
(setq dasshboard-set-heading-icons t)
;; set your image in emacs startup
(setq dashboard-startup-banner "/home/adel/.emacs.d/me.png")
;; to set items you want to show in start up .
(setq dashboard-items '((recents   . 5)
		      (bookmarks . 5)
		      (projects  . 5)
		      (agenda    . 5)))
:config
(dashboard-setup-startup-hook))

(use-package evil
  :demand t
  :bind (("<escape>" . keyboard-escape-quit))
  :init
  ;; allows for using cgn
  ;; (setq evil-search-module 'evil-search)
  (setq evil-want-keybinding nil)
  ;; no vim insert bindings
  (setq evil-undo-system 'undo-fu)
  :config

  (evil-mode 1))

;; evil-tutor
(use-package evil-tutor)

(global-set-key [escape] 'keyboard-escape-quit)

(use-package counsel
  :after ivy
  :diminish
  :config 
    (counsel-mode)
    (setq ivy-initial-inputs-alist nil)) ;; removes starting ^ regex in M-x

(use-package ivy
  :bind
  ;; ivy-resumes the last Ivy-based completion.
  (("C-c C-r" . ivy-resume)
   ("C-x B" . ivy-switch-buffer-other-window))
  :diminish
  :custom
  (setq ivy-use-virtual-buffers t)
  (setq ivy-count-format "(%d/%d) ")
  (setq enable-recursive-minibuffers t)
  :config
  (ivy-mode))

(use-package all-the-icons-ivy-rich
  :ensure t
  :init (all-the-icons-ivy-rich-mode 1))

(use-package ivy-rich
  :after ivy
  :ensure t
  :init (ivy-rich-mode 1) ;; this gets us descriptions in M-x.
  :custom
  (ivy-virtual-abbreviate 'full
   ivy-rich-switch-buffer-align-virtual-buffer t
   ivy-rich-path-style 'abbrev)
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer
                               'ivy-rich-switch-buffer-transformer))

(use-package haskell-mode)
(use-package lua-mode)
(use-package php-mode)
(use-package yaml-mode
  :commands yaml-mode)

(use-package evil-collection
  :after evil
  :config
  (setq evil-want-integration t)
  (evil-collection-init))

(use-package gruvbox-theme
 :config
 (load-theme 'gruvbox t))

(use-package vertico
  :config
  (vertico-mode))

;; Option 1: Per buffer
;;(add-hook 'org-mode-hook #'org-modern-mode)
;;(add-hook 'org-agenda-finalize-hook #'org-modern-agenda)

;; Option 2: Globally
;;(with-eval-after-load 'org (global-org-modern-mode))

(use-package hl-todo
  :hook ((org-mode . hl-todo-mode)
         (prog-mode . hl-todo-mode))
  :config
  (setq hl-todo-highlight-punctuation ":"
        hl-todo-keyword-faces
        `(("TODO"       warning bold)
          ("FIXME"      error bold)
          ("HACK"       font-lock-constant-face bold)
          ("REVIEW"     font-lock-keyword-face bold)
          ("NOTE"       success bold)
          ("DEPRECATED" font-lock-doc-face bold))))

(use-package which-key
:init (which-key-mode)
:diminish which-key-mode
:config
(setq which-key-idle-delay 0.3))

(use-package corfu)

(global-corfu-mode)

(setq completion-cycle-threshold 3)
(setq read-extended-command-predicate #'command-completion-default-include-p)
(setq corfu-auto t)
(setq corfu-quit-no-match 'separator)

(use-package colorful-mode
 :ensure t ; Optional
 :hook (prog-mode text-mode)
 ...)

;; active Babel languages
(org-babel-do-load-languages
'org-babel-load-languages
'((shell . t)))

(use-package htmlize)

(use-package org-download)

(add-hook 'org-mode-hook 'org-indent-mode)
(use-package org-bullets)
(add-hook 'org-mode-hook (lambda () (org-bullets-mode 1)))

(use-package nerd-icons
  ;; :custom
  ;; The Nerd Font you want to use in GUI
  ;; "Symbols Nerd Font Mono" is the default and is recommended
  ;; but you can use any other Nerd Font if you want
  ;; (nerd-icons-font-family "Symbols Nerd Font Mono")
  )

;; make sure to run {package-refresh-contents} in emacs to update packges.
  (use-package doom-modeline
    :ensure t
    :init (doom-modeline-mode 1))

(use-package all-the-icons
  :if (display-graphic-p))

(use-package neotree
  :config
  (setq neo-smart-open t
        neo-show-hidden-files t
        neo-window-width 55
        neo-window-fixed-size nil
        inhibit-compacting-font-caches t
        projectile-switch-project-action 'neotree-projectile-action) 
        ;; truncate long file names in neotree
        (add-hook 'neo-after-create-hook
           #'(lambda (_)
               (with-current-buffer (get-buffer neo-buffer-name)
                 (setq truncate-lines t)
                 (setq word-wrap nil)
                 (make-local-variable 'auto-hscroll-mode)
                 (setq auto-hscroll-mode nil)))))

(use-package sudo-edit
  :ensure t
  :bind (("C-x x f" . sudo-edit-find-file)
	 ("C-x x e" . sudo-edit)))
