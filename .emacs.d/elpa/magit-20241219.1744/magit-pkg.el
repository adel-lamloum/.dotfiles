;; -*- no-byte-compile: t; lexical-binding: nil -*-
(define-package "magit" "20241219.1744"
  "A Git porcelain inside Emacs."
  '((emacs         "27.1")
    (compat        "30.0.0.0")
    (dash          "2.19.1")
    (magit-section "4.1.3")
    (seq           "2.24")
    (transient     "20241217")
    (with-editor   "3.4.3"))
  :url "https://github.com/magit/magit"
  :commit "f748702fa326022f985e790985a16263a45b09c2"
  :revdesc "f748702fa326"
  :keywords '("git" "tools" "vc")
  :authors '(("Marius Vollmer" . "marius.vollmer@gmail.com")
             ("Jonas Bernoulli" . "emacs.magit@jonas.bernoulli.dev"))
  :maintainers '(("Jonas Bernoulli" . "emacs.magit@jonas.bernoulli.dev")
                 ("Kyle Meyer" . "kyle@kyleam.com")))
