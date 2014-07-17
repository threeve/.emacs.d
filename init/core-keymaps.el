;; Global keymaps ;;;;;;;;;;;;;;;

(gmap (kbd "<C-escape>") 'open-scratch-buffer)
(gmap (kbd "M-x") 'smex)
(gmap (kbd "M-X") 'smex-major-mode-commands)
(gmap (kbd "C-x C-p") 'package-list-packages)

(if (is-osx) (progn
    (gmap (kbd "s-+")   'text-scale-increase)
    (gmap (kbd "s--")   'text-scale-decrease)

    (map  (kbd "C-c o")  'send-dir-to-finder)
    (map  (kbd "C-c u")  'send-to-transmit)
    (map  (kbd "C-c l")  'send-to-launchbar)
    (map  (kbd "C-c L")  'send-dir-to-launchbar)

    ;; Evaluating elisp
    (nmap (kbd "C-c x") 'eval-buffer)
    (vmap (kbd "C-c x") 'eval-region)
))

(map (kbd "C-c t") (lambda() (interactive) (eshell t)))    ; open in terminal
(map (kbd "C-c g") 'magit-status)

(map (kbd "s-o") 'ido-find-file)
(map (kbd "s-p") 'projectile-switch-project)
(map (kbd "s-f") 'projectile-find-file)
(map (kbd "s-F") 'projectile-ag)
(map (kbd "s-R") 'projectile-recentf)


;; Local keymaps ;;;;;;;;;;;;;;;;

(evil-leader/set-leader ",")
(evil-leader/set-key
  "e"       'ido-find-file
  "E"       'my-init
  "p"       'projectile-switch-project
  "f"       'projectile-find-file
  "F"       'projectile-ag
  "r"       'projectile-recentf
  "M"       'open-major-mode-conf
  "g"       'magit-status
  "/"       'imenu
  "\\"      'toggle-sidebar
  ";"       'helm-imenu
  ","       'ido-switch-buffer
  "="       'align-regexp
)

(nmap
  ";"       'evil-ex

  ; Moving rows rather than lines (in case of wrapping)
  "j"       'evil-next-visual-line'
  "k"       'evil-previous-visual-line

  "X"       'evil-destroy           ; Delete without yanking

  ; copy to end of line
  "Y"       (lambda()
              (interactive)
              (evil-yank (point) (point-at-eol)))

  "zz"      'kill-this-buffer       ; Close buffer
  "]b"      'previous-buffer
  "[b"      'next-buffer

  ; winner-mode: window layout undo/redo (see init-core.el)
  (kbd "C-w u")     'winner-undo
  (kbd "C-w C-r")   'winner-redo

  ; Increment/decrement number under cursor
  (kbd "<C-tab>")    'evil-numbers/inc-at-pt
  (kbd "<S-C-tab>")  'evil-numbers/dec-at-pt

  ; Map split navigation with arrow keys
  (kbd "<up>")       'windmove-up
  (kbd "<down>")     'windmove-down
  (kbd "<left>")     'windmove-left
  (kbd "<right>")    'windmove-right
)

(vmap
  ; vnoremap < <gv
  "<"       (lambda ()
              (interactive)
              (evil-shift-left (region-beginning) (region-end))
              (evil-normal-state)
              (evil-visual-restore))
  ; vnoremap > >gv
  ">"       (lambda ()
              (interactive)
              (evil-shift-right (region-beginning) (region-end))
              (evil-normal-state)
              (evil-visual-restore))
  )

(imap
  ; Auto-completion
  (kbd "C-SPC") 'ac-fuzzy-complete
  (kbd "C-S-SPC") 'ac-quick-help
)

;; Commenting lines
(nmap "gcc" 'evilnc-comment-or-uncomment-lines)
(vmap "gc"  'evilnc-comment-or-uncomment-lines)

;; Rotate-text (see elisp/rotate-text.el)
(nmap (kbd "RET") 'rotate-word-at-point)
(vmap (kbd "RET") 'rotate-region)
;; (imap (kbd "RET") 'comment-indent-new-line)
;; Disable return for auto-completion, since tab does the trick
(define-key ac-completing-map (kbd "RET") nil)
(imap (kbd "<C-return>") 'indent-new-comment-line)

;; Enable TAB to do matchit
(evil-define-key 'normal evil-matchit-mode-map (kbd "TAB") 'evilmi-jump-items)

;; Easy escape from insert mode
(ichmap "jj" 'evil-normal-state)

;;;; Org-Mode ;;;;;;;;;;;;;;;;;;;

(evil-define-key 'normal evil-org-mode-map
  "gh"      'outline-up-heading
  "gj"      (if (fboundp 'org-forward-same-level) ;to be backward compatible with older org version
                'org-forward-same-level
              'org-forward-heading-same-level)
  "gk"      (if (fboundp 'org-backward-same-level)
                'org-backward-same-level
              'org-backward-heading-same-level)
  "gl"      'outline-next-visible-heading
  "t"       'org-todo
  "T"       '(lambda () (interactive) (evil-org-eol-call (lambda() (org-insert-todo-heading nil))))
  "H"       'org-beginning-of-line
  "L"       'org-end-of-line
  ";t"      'org-show-todo-tree
  "o"       '(lambda () (interactive) (evil-org-eol-call 'always-insert-item))
  "O"       '(lambda () (interactive) (evil-org-eol-call 'org-insert-heading))
  "$"       'org-end-of-line
  "^"       'org-beginning-of-line
  "<"       'org-metaleft
  ">"       'org-metaright
  ";a"      'org-agenda
  "-"       'org-cycle-list-bullet
  (kbd "TAB") 'org-cycle)

;; normal & insert state shortcuts.
(mapc (lambda (state)
    (evil-define-key state evil-org-mode-map
      (kbd "M-l") 'org-metaright
      (kbd "M-h") 'org-metaleft
      (kbd "M-k") 'org-metaup
      (kbd "M-j") 'org-metadown
      (kbd "M-L") 'org-shiftmetaright
      (kbd "M-H") 'org-shiftmetaleft
      (kbd "M-K") 'org-shiftmetaup
      (kbd "M-J") 'org-shiftmetadown
      (kbd "M-o") '(lambda () (interactive)
                     (evil-org-eol-call
                      '(lambda()
                         (org-insert-heading)
                         (org-metaright))))
      (kbd "M-t") '(lambda () (interactive)
                     (evil-org-eol-call
                      '(lambda()
                         (org-insert-todo-heading nil)
                         (org-metaright))))
      ))
  '(normal insert))


;;;; Ex Commands ;;;;;;;;;;;;;;;;

;; (cmap "e[dit]" 'find-file)
;; (cmap "n[ew]" ')


;;;; Keymap fixes ;;;;;;;;;;;;;;;

;; Make ESC quit all the things
(nmap [escape] 'keyboard-quit)
(vmap [escape] 'keyboard-quit)
(mapc (lambda (map)
    (define-key map [escape] 'minibuffer-quit))
      (list
        minibuffer-local-map
        minibuffer-local-ns-map
        minibuffer-local-completion-map
        minibuffer-local-must-match-map
        minibuffer-local-isearch-map))
(global-set-key [escape] 'evil-exit-emacs-state)
;; Close help window with escape
(define-key global-map [escape] 'quit-window)

;; Restore bash-esque C-w/C-a/C-e in insert mode and the minibuffer
(mapc (lambda (map)
    ;; (define-key map (kbd "C-w") 'evil-delete-backward-word)
    (define-key map (kbd "C-a") 'move-beginning-of-line)
    (define-key map (kbd "C-e") 'move-end-of-line)
    (define-key map (kbd "C-u") 'backward-kill-line))
      (list minibuffer-local-map evil-insert-state-map))

(define-key evil-insert-state-map (kbd "C-w") 'backward-kill-word)
(define-key minibuffer-local-map (kbd "C-w") 'ido-delete-backward-word-updir)

(add-hook 'ido-setup-hook '(lambda ()
    ;; take that "Text is read-only" and stick it where emacs don't shine!
    (define-key ido-completion-map (kbd "<backspace>") 'ido-delete-backward-updir)
    (define-key ido-completion-map "\C-n" 'ido-next-match)
    (define-key ido-completion-map "\C-f" 'ido-next-match)
    (define-key ido-completion-map "\C-p" 'ido-prev-match)
    (define-key ido-completion-map "\C-b" 'ido-prev-match)

    ;; Auto-complete on tab/space (why is it called ido-exit-minibuffer?)
    (define-key ido-completion-map " " 'ido-exit-minibuffer)
    ))

;; Preserve buffer-movement in emacs mode
(emap (kbd "C-w h") 'evil-window-left)
(emap (kbd "C-w l") 'evil-window-right)
(emap (kbd "C-w j") 'evil-window-down)
(emap (kbd "C-w k") 'evil-window-up)

;;
(provide 'core-keymaps)