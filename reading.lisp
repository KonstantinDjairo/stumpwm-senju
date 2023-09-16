(defun auto-organize-epub-and-goldendict ()
  (interactive)
  
  ;; Define layouts
  (deflayout epub-reader-layout
    (make-tile :type 'vertical :top '(1 0) :left '(1 0) :width 0.5 :height 1))
  
  (deflayout goldendict-layout
    (make-tile :type 'vertical :top '(1 0) :left 0 :width 0.5 :height 1))
  
  ;; Define window assignment commands
  (defcommand assign-to-epub-reader-layout ()
    (interactive)
    (with-window-properties (window)
      (setf (window-layout window) 'epub-reader-layout)))
  
  (defcommand assign-to-goldendict-layout ()
    (interactive)
    (with-window-properties (window)
      (setf (window-layout window) 'goldendict-layout)))
  
  ;; Automatically organize windows when they are mapped
  (defun auto-organize-windows ()
    (when (or (and (not (get-window "YourEPUBReaderName"))
                   (start-process-shell-command "epub-reader" nil "your_epub_reader_command")))
              (and (not (get-window "Goldendict"))
                   (start-process-shell-command "goldendict" nil "goldendict_command"))))
    
    (dolist (window (screen-windows (current-screen)))
      (when (window-matches-name window "YourEPUBReaderName")
        (unless (window-layout window)
          (with-current-screen (screen)
            (split-window screen window 'horizontal 0.5)
            (setf (window-layout window) 'epub-reader-layout)))))
    
    (dolist (window (screen-windows (current-screen)))
      (when (window-matches-name window "Goldendict")
        (unless (window-layout window)
          (with-current-screen (screen)
            (split-window screen window 'horizontal 0.5)
            (setf (window-layout window) 'goldendict-layout))))))
  
  ;; Assign windows and create keybindings
  (assign-to-epub-reader-layout)
  (assign-to-goldendict-layout)
  
  ;; Run auto-organize-windows on window mapping
  (define-hook! window-mapped-hook :before #'auto-organize-windows))

;; Run the auto-organize-epub-and-goldendict function
(define-key *top-map* (kbd "C-c o") 'auto-organize-epub-and-goldendict)

