(scroll-bar-mode -1) ; disable visible scrollbar
  (tool-bar-mode -1) ; disable tool bar
  (tooltip-mode -1) ; disable tooltips
  (set-fringe-mode 10) ; give some breathing room
  (menu-bar-mode -1) ;disable menu bar
(setq inhibit-startup-message t)

  ;; setup visible bell
  (setq visible-bell t)

 (set-face-attribute 'default nil :font "JetBrains Mono NL" :height 105) ;set font

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
