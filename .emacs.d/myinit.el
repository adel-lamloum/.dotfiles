(scroll-bar-mode -1) ; Disable visible scrollbar
(tool-bar-mode -1) ; Disable tool bar
(tooltip-mode -1) ; Disable tooltips
(set-fringe-mode 10) ; Give some breathing room
(menu-bar-mode -1) ; Disable menu bar
(setq inhibit-startup-message t) ; Disable startup message
(global-hl-line-mode) ; Enable line highlighting
(setq visible-bell t) ; Enable visible bell (disable sound bell)

(set-face-attribute 'default nil :font "FiraCode Nerd Font-13") ; Set default font
  (add-to-list 'default-frame-alist '(font . "FiraCode Nerd Font-13"))

  ;; Enable bidi (bidirectional) text support in Emacs
  (setq-default bidi-display-reordering t)
  (setq-default bidi-paragraph-direction 'left-to-right) ; Set default text direction to LTR

  ;; Function to toggle text direction between LTR and RTL
  (defun toggle-text-direction ()
    "Toggle text direction between left-to-right (LTR) and right-to-left (RTL)."
    (interactive)
    (if (eq bidi-paragraph-direction 'left-to-right)
        (setq bidi-paragraph-direction 'right-to-left)
      (setq bidi-paragraph-direction 'left-to-right))
    (message "Text direction set to %s" bidi-paragraph-direction))

  ;; Bind the function to a key (e.g., C-c d)
  ;;(global-set-key (kbd "C-c d") 'toggle-text-direction)

  ;; Ensure LTR direction in Org-mode
  (add-hook 'org-mode-hook
            (lambda ()
              (setq-local bidi-paragraph-direction 'left-to-right)))

  ;; Set default input method to TeX (LTR, English)
  (setq default-input-method "TeX")

  ;; Set Arabic as a secondary input method
  (setq default-input-method "arabic")
  (global-set-key (kbd "C-\\") 'toggle-input-method)

  ;; Ensure proper Arabic font rendering
  (set-fontset-font t 'arabic "Noto Naskh Arabic")

  ;; Enable line numbers in Org-mode
  (add-hook 'org-mode-hook #'display-line-numbers-mode)
(global-display-line-numbers-mode 1)
  ;; Enable visual line mode (helps with soft wrapping in text-based modes)
  (add-hook 'text-mode-hook 'visual-line-mode)
  (add-hook 'org-mode-hook 'visual-line-mode)
  (add-hook 'markdown-mode-hook 'visual-line-mode)

  ;; Optional: Set preferred text width (80 characters) for text wrapping
  (setq-default fill-column 80)

(global-set-key (kbd "C-=") 'text-scale-increase) ; Increase text size
(global-set-key (kbd "C--") 'text-scale-decrease) ; Decrease text size
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase) ; Increase text size with mouse wheel
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease) ; Decrease text size with mouse wheel

;; Set default notes file
(setq org-default-notes-file "~/adel-notes/org/index.org")

;; Org capture templates
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/adel-notes/org/gtd.org" "Tasks")
         "* TODO %?\n  %i\n  %a")
        ("j" "Journal" entry (file+datetree "~/adel-notes/org/journal.org")
         "* %?\nEntered on %U\n  %i\n  %a")))

;; Enable indentation in Org mode
(add-hook 'org-mode-hook 'org-indent-mode)

;; Add bullets to Org headings
(use-package org-bullets
  :ensure t
  :hook (org-mode . (lambda () (org-bullets-mode 1))))

;; Org Agenda Configuration
(setq org-agenda-deadline-leaders '("" "" "%2d d. ago: ")
      org-deadline-warning-days 0
      org-agenda-span 7
      org-agenda-start-day "-0d"
      org-agenda-skip-function-global '(org-agenda-skip-entry-if 'todo 'done)
      org-log-done 'time)

;; Custom agenda commands
(setq org-agenda-custom-commands
      '(("d" "Daily Agenda"
         ((agenda "" ((org-agenda-span 1)
                      (org-agenda-overriding-header "Today's Agenda"))))
         ((org-agenda-files '("~/adel-notes/org/gtd.org"))))
        ("w" "Weekly Agenda"
         ((agenda "" ((org-agenda-span 7)
                      (org-agenda-overriding-header "This Week's Agenda"))))
         ((org-agenda-files '("~/adel-notes/org/gtd.org"))))
        ("t" "Todo List"
         ((todo "TODO"
                ((org-agenda-overriding-header "Pending Tasks"))))
         ((org-agenda-files '("~/adel-notes/org/gtd.org"))))))

;; Highlight deadlines and scheduled tasks
(setq org-agenda-prefix-format
      '((agenda . " %i %-12:c%?-12t% s")
        (todo . " %i %-12:c")
        (tags . " %i %-12:c")
        (search . " %i %-12:c")))

;; Enable agenda logging
(setq org-agenda-log-mode-items '(closed state))

;; Add tags and priorities
(setq org-tag-alist '(("work" . ?w) ("personal" . ?p) ("urgent" . ?u)))
(setq org-priority-highest ?A
      org-priority-lowest ?C
      org-priority-default ?B)

;; Enable time grid
(setq org-agenda-time-grid
      '((daily today require-timed)
        (800 1000 1200 1400 1600 1800 2000)
        "......" "----------------"))

;; Integrate with calendar
(setq org-agenda-include-diary t)

;; Use org-super-agenda for better grouping
(use-package org-super-agenda
  :ensure t
  :after org-agenda
  :config
  (org-super-agenda-mode 1)
  (setq org-super-agenda-groups
        '((:name "Today"
                 :time-grid t
                 :scheduled today)
          (:name "Overdue"
                 :deadline past)
          (:name "Work"
                 :tag "work")
          (:name "Personal"
                 :tag "personal")
          (:name "Urgent"
                 :priority "A"))))

;; Add refile targets
(setq org-refile-targets
      '(("~/adel-notes/org/gtd.org" :maxlevel . 3)
        ("~/adel-notes/org/someday.org" :level . 1)
        ("~/adel-notes/org/notes.org" :maxlevel . 2)))

;; Enable habit tracking
(require 'org-habit)
(add-to-list 'org-modules 'org-habit)
(setq org-habit-graph-column 60)

(use-package org-roam
:ensure t
:init
(setq org-roam-v2-ack t)
:custom
(org-roam-directory "~/adel-notes/RoamNotes")
(org-roam-completion-everywhere t)
(org-roam-dailies-capture-templates
  '(("d" "default" entry "* %<%I:%M %p>: %?"
     :if-new (file+head "%<%Y-%m-%d>.org" "#+title: %<%Y-%m-%d>\n"))))
:bind (
       :map org-mode-map
       ("C-M-i" . completion-at-point)
       :map org-roam-dailies-map
       ("Y" . org-roam-dailies-capture-yesterday)
       ("T" . org-roam-dailies-capture-tomorrow))
:bind-keymap
("C-c n d" . org-roam-dailies-map)
:config
(require 'org-roam-dailies) ;; Ensure the keymap is available
(org-roam-db-autosync-mode))

(use-package gcmh
  :ensure t
  :config (gcmh-mode 1)) ; Enable garbage collection magic hack
(setq gc-cons-threshold 16777216
      gc-cons-percentage 0.1) ; Set garbage collection threshold

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
                          (bookmarks . 10)
                          (projects  . 5)
                          (agenda    . 5))) ; Set dashboard items
  :config
  (dashboard-setup-startup-hook)) ; Enable dashboard on startup

(use-package diminish :ensure t) ; Diminish mode lines to reduce clutter

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
  (add-hook 'org-mode-hook #'org-ai-mode) ; Enable org-ai in org-mode
  (org-ai-global-mode) ; Install global keybindings on C-c M-a
  :config
  (setq org-ai-default-chat-model "gpt-4") ; Use GPT-4
  (org-ai-install-yasnippets)) ; Install AI snippets

(use-package general
:ensure t
:config
;; Define a leader key prefix
(general-create-definer my/leader-keys
  :prefix "C-c"
  :prefix-command 'my/leader-keys-map)

;; Define named functions for agenda keybindings
(defun my/org-agenda-daily ()
  "Open the daily agenda."
  (interactive)
  (org-agenda nil "d"))

(defun my/org-agenda-weekly ()
  "Open the weekly agenda."
  (interactive)
  (org-agenda nil "w"))

(defun my/org-agenda-todo ()
  "Open the TODO list."
  (interactive)
  (org-agenda nil "t"))

;; Define keybindings
(my/leader-keys
 ;; Files
 "f" '(:ignore t :which-key "files")
 "ff" 'find-file
 "fr" 'recentf-open-files
 "fd" 'dired
 "fD" 'delete-file

 ;; Buffers
 "b" '(:ignore t :which-key "buffers")
 "bb" 'switch-to-buffer
 "bk" 'kill-buffer
 "bR" 'revert-buffer

 ;; Projects
 "p" '(:ignore t :which-key "projects")
 "pp" 'projectile-switch-project
 "pf" 'projectile-find-file
 "ps" 'projectile-ag

 ;; Git/Magit
 "g" '(:ignore t :which-key "git/magit")
 "gs" 'magit-status
 "gc" 'magit-commit
 "gp" 'magit-push

 ;; Windows
 "w" '(:ignore t :which-key "windows")
 "ww" 'other-window
 "wd" 'delete-window
 "w-" 'split-window-below
 "w/" 'split-window-right

 ;; Toggle
 "t" '(:ignore t :which-key "toggle")
 "tt" 'toggle-truncate-lines
 "tb" 'toggle-buffer-line-numbers
 "tm" 'toggle-modeline
 "td" 'toggle-text-direction

 ;; Notes/Org
 "n" '(:ignore t :which-key "notes/org")
 "nn" 'org-capture
 "nl" 'org-roam-buffer-toggle
 "nf" 'org-roam-node-find
 "ni" 'org-roam-node-insert
 "nd" 'org-roam-dailies-map
 "ny" 'org-roam-dailies-capture-yesterday
 "nt" 'org-roam-dailies-capture-today
 "ng" 'org-roam-dailies-goto-date

 ;; Agenda
 "a" '(:ignore t :which-key "agenda")
 "aa" 'org-agenda
 "ad" 'my/org-agenda-daily
 "aw" 'my/org-agenda-weekly
 "at" 'my/org-agenda-todo

 ;; Jinx (spell checking)
 "s" '(:ignore t :which-key "spell checking (jinx)")
 "sc" 'jinx-correct    ; C-c s c for correcting word at point
 "sl" 'jinx-languages) ; C-c s l for changing languages
)

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
  :custom
  (corfu-cycle t) ; Allows cycling through candidates
  (corfu-auto t) ; Enable auto completion
  (corfu-auto-prefix 2)
  (corfu-auto-delay 0.1)
  (corfu-popupinfo-delay '(0.5 . 0.2))
  (corfu-preview-current 'insert) ; Insert previewed candidate
  (corfu-preselect 'prompt)
  (corfu-on-exact-match nil) ; Don't auto expand tempel snippets
  :bind (:map corfu-map
              ("M-SPC" . corfu-insert-separator)
              ("TAB" . corfu-next)
              ([tab] . corfu-next)
              ("S-TAB" . corfu-previous)
              ([backtab] . corfu-previous)
              ("S-<return>" . corfu-insert)
              ("RET" . nil))
  :init
  (global-corfu-mode)
  (corfu-history-mode)
  (corfu-popupinfo-mode)) ; Popup completion info

(use-package beacon
  :ensure t
  :config
  (beacon-mode 1) ; Enable beacon globally
  (setq beacon-color "#ff0000") ; Set the beacon color to red
  (setq beacon-size 20) ; Set the size of the beacon
  (setq beacon-blink-when-point-moves t) ; Blink when the cursor moves
  (setq beacon-blink-when-window-scrolls t) ; Blink when the window scrolls
  (setq beacon-blink-when-window-changes t)) ; Blink when the window changes

(use-package ace-popup-menu
  :ensure t
  :config
  (ace-popup-menu-mode 1) ; Enable ace-popup-menu globally
  (setq ace-popup-menu-show-pane-header t) ; Show a header for the popup menu
  (setq ace-popup-menu-style 'full) ; Use the full style for the popup menu
  (setq ace-popup-menu-max-items 10)) ; Set the maximum number of items to display

(use-package haskell-mode :ensure t) ; Haskell language support

(use-package lua-mode :ensure t) ; Lua language support

(use-package php-mode :ensure t) ; PHP language support

(use-package yaml-mode :ensure t) ; YAML language support

(use-package web-mode
  :ensure t
  :mode (("\\.html?\\'" . web-mode)
         ("\\.css\\'" . web-mode)
         ("\\.js\\'" . web-mode)) ; Web development support
  :config
  (setq web-mode-markup-indent-offset 2) ; Set HTML indent offset
  (setq web-mode-css-indent-offset 2) ; Set CSS indent offset
  (setq web-mode-code-indent-offset 2)) ; Set JS indent offset

(use-package css-mode :ensure t) ; CSS language support
(use-package scss-mode :ensure t) ; SCSS language support
(use-package js2-mode :ensure t) ; JavaScript language support
(use-package typescript-mode :ensure t) ; TypeScript language support

(use-package python-mode :ensure t) ; Python language support
  (use-package lsp-mode :ensure t) ; Language Server Protocol support
(use-package lsp-pyright
  :hook (python-mode . (lambda () (require 'lsp-pyright)))
  :init (when (executable-find "python3")
          (setq lsp-pyright-python-executable-cmd "python3")))

(add-to-list 'auto-mode-alist '("\\.sh\\'" . sh-mode)) ; Bash scripting support
(setq sh-basic-offset 2) ; Set Bash indent offset
(use-package company-shell :ensure t) ; Shell auto-completion

;; Rust mode for syntax highlighting and basic functionality
(use-package rust-mode
  :ensure t
  :mode "\\.rs\\'" ; Automatically open .rs files in rust-mode
  :config
  (setq rust-format-on-save t)) ; Automatically format Rust code on save

;; Cargo integration for Rust projects
(use-package cargo
  :ensure t
  :hook (rust-mode . cargo-minor-mode)) ; Enable cargo minor mode in rust-mode

;; LSP mode for Rust (using rust-analyzer)
(use-package lsp-mode
  :ensure t
  :hook (rust-mode . lsp) ; Enable LSP for Rust
  :config
  (setq lsp-rust-analyzer-server-command '("rust-analyzer")) ; Set rust-analyzer as the LSP server
  (lsp-enable-which-key-integration t)) ; Enable which-key integration for LSP commands

;; LSP UI for better LSP integration (e.g., documentation, errors, etc.)
(use-package lsp-ui
  :ensure t
  :commands lsp-ui-mode)

;; Enable abbrev-mode globally
(setq-default abbrev-mode t)
(setq save-abbrevs 'silently) ; Save abbreviations between sessions

;; Define global abbreviations
(define-abbrev global-abbrev-table "adel" "Adel")
(define-abbrev global-abbrev-table "lamloum" "Lamloum")
(define-abbrev global-abbrev-table "linux" "Linux")
(define-abbrev global-abbrev-table "Ana" "Adel Lamloum")
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
  :ensure t
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

(use-package colorful-mode :ensure t) ; Add colors to programming and text modes

(org-babel-do-load-languages
 'org-babel-load-languages
 '((shell . t)
   (python . t))) ; Enable Org Babel for shell and Python

(use-package htmlize :ensure t) ; HTML export for code snippets

(use-package markdown-mode :ensure t) ; Markdown language support
(use-package markdown-preview-mode :ensure t) ; Markdown preview support

(use-package org-download :ensure t) ; Drag-and-drop images into Org mode

(use-package org-bullets :ensure t) ; Add bullets to Org headings

(use-package doom-modeline
  :ensure t
  :init (doom-modeline-mode 1) ; Enable doom-modeline
  :config
  (set-face-attribute 'region nil :background "#add8e6")) ; Customize region highlight color

(use-package all-the-icons :ensure t) ; Add icons for graphical Emacs
(use-package all-the-icons-dired :ensure t) ; Add icons to Dired

(use-package sudo-edit
  :ensure t
  :bind (("C-x x f" . sudo-edit-find-file)
         ("C-x x e" . sudo-edit))) ; Edit files with sudo

(use-package centaur-tabs
  :ensure t
  :config
  (centaur-tabs-mode t) ; Enable centaur-tabs
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
  (define-key projectile-command-map (kbd "f") 'projectile-find-file)) ; Find file in project

(use-package smartparens
  :ensure t
  :hook (prog-mode text-mode markdown-mode) ; Enable smartparens in these modes
  :config
  (require 'smartparens-config)) ; Load default smartparens configuration

(use-package moe-theme
:ensure t
:config
;; Load a specific Moe theme by default (e.g., Moe Dark)
(load-theme 'moe-dark t))
