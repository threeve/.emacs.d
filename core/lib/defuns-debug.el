;;; defuns-debug.el

;;;###autoload
(defun what-face (pos)
  "Tells you the name of the face (point) is on."
  (interactive "d")
  (let ((face (or (get-char-property (point) 'read-face-name)
                  (get-char-property (point) 'face))))
    (if face (message "Face: %s" face) (message "No face at %d" pos))))

;;;###autoload
(defun what-col ()
  (interactive)
  (message "Column %d" (current-column)))

;;;###autoload
(defun what-bindings (key)
  (list
   (minor-mode-key-binding key)
   (local-key-binding key)
   (global-key-binding key)))

;;;###autoload (autoload 'narf:echo "defuns-debug" nil t)
(evil-define-command narf:echo (bang message)
  "Display MSG in echo-area without logging it in *Messages* buffer."
  (interactive "<!><a>")
  (let (message-log-max)
    (message "%s%s" (if bang ">> " "") message)))

(provide 'defuns-debug)
;;; defuns-debug.el ends here