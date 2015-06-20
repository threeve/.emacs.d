;;; core-auto-insert.el --- file templates

(use-package autoinsert
  :after yasnippet
  :init
  (setq auto-insert-query nil)    ; Don't prompt before insertion
  (setq auto-insert-alist '())
  :config
  (auto-insert-mode 1)

  ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

  ;; (add-template! "/\\.gitignore$"                  "%%"               'gitignore-mode)

  ;; C/C++
  ;; (add-template! "/Makefile$"                      "%%"               'makefile-gmake-mode)
  ;; (add-template! "/main\\.\\(cc\\|cpp\\)$"         "%main.cpp%"       'c++-mode)
  ;; (add-template! "/win32_\\.\\(cc\\|cpp\\)$"       "%winmain.cpp%"    'c++-mode)
  ;; (add-template! "\\.\\([Hh]\\|hpp\\)$"            "%.h%"             'c++-mode)
  ;; (add-template! "\\.\\([Cc]\\|cc\\|cpp\\)$"       "%.cpp%"           'c++-mode)

  ;; Shell scripts
  ;; (add-template! "\\.z?sh$"                        "%%"               'sh-mode)

  ;; Ruby
  ;; (add-template! "/spec_helper\\.rb$"              "%helper%"         'rspec-mode t)
  ;; (add-template! "_spec\\.rb$"                     "%%"               'rspec-mode t)
  ;; (add-template! "/\\.rspec$"                      "%.rspec%"         'rspec-mode)
  ;; (add-template! "/Rakefile$"                      "%Rakefile%"       'ruby-mode t)
  ;; (add-template! "/Gemfile$"                       "%Gemfile%"        'ruby-mode t)
  ;; (add-template! "\\.gemspec$"                  "%.gemspec%"       'ruby-mode t)
  ;; (add-template! "/lib/.+\\.rb$"                   "%module%"         'ruby-mode t)
  ;; (add-template! "\\.rb$"                          "%%"               'ruby-mode)

  ;; ;; Python
  ;; (add-template! "tests?/test_.+\\.py$"         "%%"               'nose-mode)
  ;; (add-template! "/setup\\.py$"                 "%setup%"          'python-mode)
  ;; (add-template! "\\.py$"                          "%%"               'python-mode)

  ;; ;; PHP
  ;; (add-template! "\\.class\\.php$"              %class%"          'php-mode)
  ;; (add-template! "\\.php$"                      %%"               'php-mode)

  ;; ;; Markdown
  ;; (add-template! "\\.md$"                          "%%"               'markdown-mode)
  ;; (add-template! "/_posts/.+\\.md$"             "%jekyll-post"     'markdown-mode)
  ;; (add-template! "/_layouts/.+\\.html$"         "%jekyll-layout%"  'web-mode)

  ;; ;; Javascript
  ;; (add-template! "\\.lbaction/.+/Info.plist$"      "%Info.plst%"      'lb6-mode)
  ;; (add-template! "\\.lbaction/.+/\\(default\\|suggestions\\)\\.js$"     "%default.js%"     'lb6-mode)
  ;; (add-template! "/package\\.json$"             "%package.json%"   'json-mode)
  ;; (add-template! "\\.\\(json\\|jshintrc\\)$"    "%%"               'json-mode)

  ;; ;; SCSS
  ;; (add-template! "/master\\.scss$"              "%master%"         'scss-mode)
  ;; (add-template! "/normalize\\.scss$"           "%normalize%"      'scss-mode)
  ;; (add-template! "\\.scss$"                     "%%"               'scss-mode)

  ;; ;; HTML
  ;; (add-template! "\\.html$"                     "%%"               'web-mode)

  ;; Lua
  ;; (add-template! "\\.love/main\\.lua$"          "%love.main%"      'lua-mode)
  ;; (add-template! "/conf\\.lua$"                    "@@love.conf"      'love-mode)
  ;; (add-template! "\\.lua$"                      "%%"               'lua-mode)

  ;; ;; Java
  ;; (add-template! "/src/.+/.+\\.java$"              "@@"               'java-mode)
  ;; (add-template! "/build\\.gradle$"                "@@gradle"         'android-mode)

  ;; ;; Elisp
  (add-template! "\\.emacs\\.d/.+\\.el$"           "@@initfile"       'emacs-lisp-mode)
  ;; (add-template! "\\.emacs\\.d/snippets/.+$"       "@@"               'snippet-mode)
  )

(provide 'core-auto-insert)
;;; core-auto-insert.el ends here