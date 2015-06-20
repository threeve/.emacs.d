;;; my-bindings.el

;; Minimalistic key mapping! Why go so far for this?
;; ...
;; Uh. Good question.

(eval-when-compile (require 'core-defuns))

(bind!
 -
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;; Global keymaps                     ;;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 "M-x"   'smex
 "M-X"   'smex-major-mode-commands
 "M-:"   'helm-M-x
 "M-;"   'eval-expression
 "C-`"   'narf/popwin-toggle
 "M-="   'text-scale-increase
 "M--"   'text-scale-increase
 "M-w"   'evil-window-delete
 "M-/"   'evil-commentary-line
 "M-b"   'narf:build
 "M-t"   'helm-projectile-find-file

 :m "M-j"  "6j"
 :m "M-k"  "6k"
 :n "M-r"  'narf:eval-buffer
 :v "M-r"  'narf:eval-region
 :n "M-d"  'dash-at-point
 :n "M-o"  'narf/ido-find-file
 :n "M-O"  'narf/ido-find-project-file

 (:when IS-MAC
   "<A-left>"       'backward-word
   "<A-right>"      'forward-word
   "<M-backspace>"  'narf/backward-kill-to-bol-and-indent
   "A-SPC"          'just-one-space
   "M-a"            'mark-whole-buffer
   "M-c"            'evil-yank
   "M-s"            'save-buffer
   "M-v"            'clipboard-yank
   "M-q"            'evil-quit-all
   "M-z"            'undo
   "M-Z"            'redo
   "C-M-f"          'narf:toggle-fullscreen)


 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
 ;; Local keymaps                      ;;
 ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

 :nmv ";" 'evil-ex

 (:prefix "," ; <leader>
   :n ","   (λ (if (narf/project-p) (helm-projectile-switch-to-buffer) (helm-buffers-list)))
   :n "<"   'helm-buffers-list
   :n "."   'narf/ido-find-file
   :n ">"   'narf/ido-find-file-other-window
   :n "/"   'helm-projectile-find-file
   :n ";"   'helm-semantic-or-imenu

   :n "]"   'helm-etags-select
   :n "a"   'helm-projectile-find-other-file
   :n "E"   'narf:ido-find-file-in-emacsd
   :n "h"   'helm-apropos
   :n "n"   'narf/ido-find-org-file
   :n "N"   'narf:org-search-files-or-headers
   :n "m"   'narf/ido-recentf
   :n "M"   'helm-projectile-recentf  ; recent PROJECT files
   :n "p"   'helm-projectile-switch-project
   :n "r"   'emr-show-refactor-menu
   :v "="   'align-regexp

   :n "qq"  'evil-save-and-quit
   :n "QQ"  'narf/kill-all-buffers-do-not-remember

   :n "oo"  'narf-open-with
   :n "ob"  (λ (narf-open-with "Google Chrome"))
   :n "of"  (λ (narf-open-with "Finder.app" default-directory))
   :n "oF"  (λ (narf-open-with "Finder.app" (narf/project-root)))
   :n "ou"  (λ (narf-open-with "Transmit"))
   :n "oU"  (λ (narf-open-with "Transmit" default-directory))
   :n "ol"  (λ (narf-open-with "LaunchBar"))
   :n "oL"  (λ (narf-open-with "LaunchBar" default-directory))
   :n "ot"  (λ (narf:tmux-chdir nil t))
   :n "oT"  'narf:tmux-chdir)

 (:prefix "\\" ; <localleader>
   :n "\\"  'narf/neotree-toggle
   :n "."   'narf/neotree-find
   :n ";"   'narf/nlinum-toggle
   :n "="   'toggle-transparency
   :n "E"   'evil-emacs-state

   :n "]"   'next-buffer
   :n "["   'previous-buffer

   :n "s"   (λ (narf:yas-snippets t))        ; ido snippets dir
   :n "g"   'diff-hl-diff-goto-hunk
   :n "e"   (λ (call-interactively 'flycheck-buffer) (flycheck-list-errors))
   :n "p"   'helm-show-kill-ring
   :n "b"   'helm-bookmarks
   :n "w"   'helm-wg)

 :n "Y" "y$"

 :n "zr"  'narf/evil-open-folds
 :n "zm"  'narf/evil-close-folds
 :n "zx"  'narf:kill-real-buffer
 :n "zX"  'bury-buffer

 :n "]b"  'narf/next-real-buffer
 :n "[b"  'narf/previous-real-buffer
 :n "]w"  'wg-switch-to-workgroup-right
 :n "[w"  'wg-switch-to-workgroup-left
 :m "]g"  'diff-hl-next-hunk
 :m "[g"  'diff-hl-previous-hunk
 :m "]e"  'narf/flycheck-next-error
 :m "[e"  'narf/flycheck-previous-error

 ;; Don't move cursor on indent
 :n "="   (λ (save-excursion (call-interactively 'evil-indent)))
 :v "="   'evil-indent

 ;; Increment/decrement number under cursor
 :n "g="  'evil-numbers/inc-at-pt
 :n "g-"  'evil-numbers/dec-at-pt
 :n "gR"  'narf:eval-buffer
 :n "gc"  'evil-commentary
 :n "gy"  'evil-commentary-yank
 :n "gx"  'evil-exchange
 :n "gr"  'narf:eval-region
 :v "gR"  'narf:eval-region-and-replace
 :m "gl"  'narf:goto-line
 :m "gs"  'evil-ace-jump-two-chars-mode
 :m "g]"  'smart-down
 :m "g["  'smart-up

 :v "."   'evil-repeat

 ;; vnoremap < <gv
 :v "<"   (λ (evil-shift-left (region-beginning) (region-end))
             (evil-normal-state)
             (evil-visual-restore))
 ;; vnoremap > >gv
 :v ">"   (λ (evil-shift-right (region-beginning) (region-end))
             (evil-normal-state)
             (evil-visual-restore))

 ;; undo/redo for regions
 :nv "u"    'undo-tree-undo
 :nv "C-r"  'undo-tree-redo

 :v "*"   'evil-visualstar/begin-search-forward
 :v "#"   'evil-visualstar/begin-search-backward

 ;; paste from recent yank register; which isn't overwritten by deletes or
 ;; other operations.
 :v "P"   "\"0p"

 :v "S"   'evil-surround-region
 :v "R"   'evil-iedit-state/iedit-mode  ; edit all instances of marked region
 :v "v"   'er/expand-region
 :v "V"   'er/contract-region

 ;; aliases for %
 :m "%"   'evilmi-jump-items
 :m [tab] (λ (if (ignore-errors (hs-already-hidden-p))
                 (hs-toggle-hiding)
               (call-interactively 'evilmi-jump-items)))

 ;; Restore osx text objects
 :i "<A-backspace>" 'evil-delete-backward-word
 :i "<A-delete>"    (λ (evil-forward-word) (evil-delete-backward-word))

 ;; Newline magic
 :i "<backspace>"   'backward-delete-char-untabify
 :i "<M-backspace>" 'narf/backward-kill-to-bol-and-indent
 :i "<C-return>"    'evil-ret-and-indent

 ;; Textmate-esque indent shift left/right
 :i "M-["           "C-o m l C-o I DEL C-o ` l"
 :i "M-]"           (λ (evil-shift-right (point-at-bol) (point-at-eol)))
 :i "<backtab>"     "M-["

 ;; escape from insert mode (more responsive than using key-chord-define)
 :ir  "j"    'narf:exit-mode-maybe
 :ir  "J"    'narf:exit-mode-maybe
 :irv "C-g"  'evil-normal-state

 :o "s"      'evil-surround-edit
 :o "S"      'evil-Surround-edit

 :n "!"      'rotate-word-at-point
 :v "!"      'rotate-region
 :e [escape] 'evil-normal-state

 (:map evil-window-map ; prefix "C-w"
   "u"       'winner-undo
   "C-u"     'winner-undo
   "C-r"     'winner-redo

   "C-w"     'ace-window
   "C-S-w"   (λ (ace-window 4))    ; swap windows
   "C-C"     (λ (ace-window 16)))  ; delete windows

 ;; Vim omni-complete emulation
 :i "C-SPC"     'company-complete-common
 :i "C-x C-k"   'company-dict
 :i "C-x C-f"   'company-files
 :i "C-x C-]"   'company-tags
 :i "C-x s"     'company-ispell
 :i "C-x C-s"   'company-yasnippet
 :i "C-x C-o"   'company-semantic
 :i "C-x C-n"   'company-dabbrev-code
 :i "C-x C-p"   (λ (let ((company-selection-wrap-around t))
                     (call-interactively 'company-dabbrev-code)
                     (company-select-previous-or-abort)))

 (:after company
   (:map company-active-map
     "C-o"        'company-search-kill-others
     "C-n"        'company-select-next-or-abort
     "C-p"        'company-select-previous-or-abort
     "C-h"        'company-show-doc-buffer
     "C-S-h"      'company-show-location
     "C-S-s"      'company-search-candidates
     "C-s"        'company-filter-candidates
     "C-SPC"      'company-complete-common
     [tab]        'company-complete
     "<backtab>"  'company-select-previous
     [escape]     'company-abort
     "<C-return>" 'helm-company
     :unset "C-w")
   (:map company-search-map
     "C-n"        'company-search-repeat-forward
     "C-p"        'company-search-repeat-backward
     [escape]     'company-abort
     :unset "C-w"))

 (:after help-mode
   (:map help-mode-map
     :n "]]" 'help-go-forward
     :n "[[" 'help-go-back
     :n "<escape>" (λ (kill-buffer)
                      (if (eq popwin:popup-buffer (current-buffer))
                          (popwin:close-popup-window)
                        (evil-window-delete)))))

 (:map evil-ex-completion-map
   "C-r"            'evil-ex-paste-from-register   ; registers in ex-mode
   "C-a"            'move-beginning-of-line
   "<s-left>"       'move-beginning-of-line
   "<s-right>"      'move-beginning-of-line
   "<s-backspace>"  'evil-delete-whole-line))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; Keymap fixes                       ;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; This section is dedicated to keymaps that "fix" certain keys so
;; that they behave more like vim (or how I like it).

;; Restores "dumb" indentation to the tab key. This rustles a lot of
;; peoples' jimmies, apparently, but it's how I like it.
(bind! :i "<tab>"   'narf/dumb-indent
       :i "<C-tab>" 'indent-for-tab-command

       ;; No dumb-tab for lisp
       :i :map lisp-mode-map        [remap narf/dumb-indent] 'indent-for-tab-command
       :i :map emacs-lisp-mode-map  [remap narf/dumb-indent] 'indent-for-tab-command

       ;; Highjacks space/backspace to:
       ;;   a) delete spaces on either side of the cursor, if present ( | ) -> (|)
       ;;   b) allow backspace to delete space-indented blocks intelligently
       ;;   c) and not do any of this magic when inside a string
       :i "SPC"                                  'narf/inflate-space-maybe
       :i [remap backward-delete-char-untabify]  'narf/deflate-space-maybe
       :i [remap newline]                        'narf/newline-and-indent

       ;; Smarter move-to-beginning-of-line
       :i [remap move-beginning-of-line]         'narf/move-to-bol

       ;; Restore bash-esque keymaps in insert mode; C-w and C-a already exist
       :i "C-e" 'narf/move-to-eol
       :i "C-u" 'narf/backward-kill-to-bol-and-indent

       ;; Fixes delete
       :i "<kp-delete>" 'delete-char

       ;; Fix osx keymappings and then some
       :i "<M-left>"   'narf/move-to-bol
       :i "<M-right>"  'narf/move-to-eol
       :i "<M-up>"     'beginning-of-buffer
       :i "<M-down>"   'end-of-buffer
       :i "<C-up>"     'smart-up
       :i "<C-down>"   'smart-down

       ;; Fix emacs motion keys
       :i "A-b"      'evil-backward-word-begin
       :i "A-w"      'evil-forward-word-begin
       :i "A-e"      'evil-forward-word-end

       ;; Textmate-esque insert-line before/after
       :i "<M-return>"    'evil-open-below
       :i "<S-M-return>"  'evil-open-above
       ;; insert lines in-place)
       :n "<M-return>"    (λ (save-excursion (evil-insert-newline-below)))
       :n "<S-M-return>"  (λ (save-excursion (evil-insert-newline-above)))

       ;; Make ESC quit all the things
       :e [escape] 'narf-minibuffer-quit
       (:map (minibuffer-local-map
              minibuffer-local-ns-map
              minibuffer-local-completion-map
              minibuffer-local-must-match-map
              minibuffer-local-isearch-map)
         [escape] 'narf-minibuffer-quit)

       :map read-expression-map "C-w" 'evil-delete-backward-word

       ;; Line selection via linum
       "<left-margin> <down-mouse-1>"    'narf/mouse-select-line
       "<left-margin> <mouse-1>"         'narf/mouse-select-line
       "<left-margin> <drag-mouse-1>"    'narf/mouse-select-line
       "<left-margin> <double-mouse-1>"  'narf/mouse-select-block)

;; Disable the global drag-mouse map; clicking in new buffers often sends evil
;; into visual mode, which is UN...ACCEPTAABBLLLEEEE!
(global-unset-key (kbd "<drag-mouse-1>"))

(provide 'my-bindings)
;;; my-bindings.el ends here