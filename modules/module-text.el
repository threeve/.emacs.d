;;; module-text.el

(associate! text-mode :match "/LICENSE$")

(use-package markdown-mode
  :mode ("\\.m\\(d\\|arkdown\\)$" "/README$"
         ("/README\\.md$" . gfm-mode))
  :init
  (add-hook! markdown-mode
    (auto-fill-mode +1)
    (setq line-spacing 2
          fill-column 70))
  (setq markdown-enable-wiki-links t
        markdown-enable-math t
        markdown-italic-underscore t
        markdown-make-gfm-checkboxes-buttons t
        markdown-gfm-additional-languages '("sh"))

  :config
  (def-electric! markdown-mode :chars ("+" "#"))

  (sp-local-pair
   '(markdown-mode gfm-mode)
   "\`\`\`" "\`\`\`" :post-handlers '(("||\n" "RET")))

  (map! :map gfm-mode-map "`"    'self-insert-command)
  (map! :map markdown-mode-map
        "<backspace>"  nil
        "<M-left>"     nil
        "<M-right>"    nil
        "M-*"  'markdown-insert-list-item
        "M-b"  'markdown-insert-bold
        "M-i"  'markdown-insert-italic
        "M-`"  'doom/markdown-insert-del
        ;; Assumes you have a markdown renderer plugin in chrome
        :nv "M-r"  (λ! (doom-open-with "Google Chrome"))
        ;; TODO: Make context sensitive
        :n "[p"   'markdown-promote
        :n "]p"   'markdown-demote
        :i "M--"  'markdown-insert-hr
        (:localleader
          :nv "i"   'markdown-insert-image
          :nv "l"   'markdown-insert-link
          :nv "L"   'markdown-insert-reference-link-dwim
          :nv "b"   'markdown-preview)))

(use-package markdown-toc :after markdown-mode)

(use-package rst
  :mode ("\\.re?st$" . rst-mode)
  :config (def-builder! rst-mode rst-compile-pdf-preview))

(provide 'module-text)
;;; module-text.el ends here
