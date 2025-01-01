;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "evil" "20241228.1901"
  "Extensible vi layer."
  '((emacs    "24.1")
    (cl-lib   "0.5")
    (goto-chg "1.6")
    (nadvice  "0.3"))
  :url "https://github.com/emacs-evil/evil"
  :commit "131970807431073abd35ad5771eb39e8cb19dd2a"
  :revdesc "131970807431"
  :keywords '("emulations")
  :maintainers '(("Tom Dalziel" . "tom.dalziel@gmail.com")))
