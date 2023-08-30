;; -*- mode:read-only -*- ;;

(in-package :stumpwm)
(load "~/quicklisp/setup.lisp")


(setq *shell-program* (stumpwm::getenv "SHELL"))


(setf *message-window-gravity* :center
      *input-window-gravity* :center
      *window-border-style* :thin
      *message-window-padding* 10
      *maxsize-border-width* 2
      *normal-border-width* 2
      *transient-border-width* 2
      stumpwm::*float-window-border* 4
      stumpwm::*float-window-title-height* 20
      *mouse-focus-policy* :click)


(defun pretty-time ()
  "日付を '17:19:51 2014年4月27日、日曜日' の形式で返します。"
  (defun stringify-dow (dow)
    (nth dow '("月曜日" "火曜日" "水曜日" "木曜日" "金曜日" "土曜日" "日曜日")))
  (defun stringify-mon (mon)
    (nth (- mon 1) '("1月" "2月" "3月" "4月"
                     "5月" "6月" "7月" "8月"
                     "9月" "10月" "11月" "12月")))
(multiple-value-bind (sec min hr date mon yr dow dst-p tz)
      (get-decoded-time)
    (format NIL "~2,'0d:~2,'0d:~2,'0d ~d年~a ~d日、~a"
            yr (stringify-mon mon)
            date (stringify-dow dow)
            hr min sec)))


(setf *screen-mode-line-format* (list "[^B%n^b] %W^>%d"))
(setf *mode-line-timeout* 2)
(setf *screen-mode-line-format*
      (list "[^B%n^b] %W " ; groups/windows
            "^>" ; right align
            " ^7* " '(:eval (pretty-time)); date
            ))

(setf *group-format* "%s [%n] %t ")
(setf *window-format* "%m%n%s%c")



(reload)
(init-load-path #p"~/.stumpwm.d/modules/")
(let ((quicklisp-init (merge-pathnames "~/quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))
(sleep 2) ;; for the sake of god, let him breath.
(ql:quickload "clx-truetype")
(load-module "ttf-fonts")
(xft:cache-fonts) ;; 
(set-font "-xos4-terminus-medium-r-normal-*-20-*-*-*-*-*-*-*")
(set-font (make-instance 'xft:font :family "IPAMincho" :subfamily "Regular" :size 10))




(defun retil-windows ()
  "Retile windows in the current group to remove empty spaces."
  (interactive)
  (if (not (eq *current-group* nil))
      (progn
        (group-activate *current-group*)
        (tile))
      (message "No group is active.")))

(define-key *top-map* (kbd "M-'") 'retil-windows)



(run-shell-command "xrandr --output HDMI-A-0 --mode 1366x768")
;;(run-shell-command "sh ~/.xprofile")
(init-load-path #p"~/.stumpwm.d/modules/")
(let ((quicklisp-init (merge-pathnames "~/quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

;;


;; turn on/off the mode line for the current head only.
(stumpwm:toggle-mode-line (stumpwm:current-screen)
                          (stumpwm:current-head))

(define-key *root-map* (kbd "v") "exec xfce4-terminal")


;; manga
(define-key *root-map* (kbd "`") "exec /home/ronnie/.local/bin/transformers_ocr recognize")
(define-key *root-map* (kbd ".") "exec /home/ronnie/.local/bin/transformers_ocr hold")
(define-key *root-map* (kbd ";") "exec /home/ronnie/Downloads/gomicsv/cmd/gomicsv/main")  ;; manga reader
;; ---------------------


(define-key *top-map* (kbd "M-p") "exec rofi -show drun")
(define-key *top-map* (kbd "M-o") "exec cabl")
(define-key *top-map* (kbd "M-v") "exec dictpopup")
(define-key *top-map* (kbd "M-f") "exec flameshot gui") 
(define-key *top-map* (kbd "M-n") "exec mupdf /mnt/Data/Japanese_Resources/languages-study(japanesAndRussian)/岩波数学辞典\ 第４版\ --\ 日本数学会\ --\ 第４版\,\ 2007\ --\ 岩波書店\ --\ 9784000803090\ --\ 49eeb143a4aef2f90d66e9527ffe161c\ --\ Anna’s\ Archive.pdf") 



;; frames
(define-key *root-map* (kbd "x") "hsplit")
(define-key *root-map* (kbd "z") "vsplit")
(define-key *root-map* (kbd "n") "remove-split")


(define-key *root-map* (kbd "Q") "quit")
(define-key *root-map* (kbd "R") "restart-hard")

(define-key *root-map* (kbd "q") "delete")
(define-key *root-map* (kbd "r") "remove")

(define-key *root-map* (kbd "h") "move-focus left")
(define-key *root-map* (kbd "j") "move-focus down")
(define-key *root-map* (kbd "k") "move-focus up")
(define-key *root-map* (kbd "l") "move-focus right")
(define-key *top-map* (kbd "H") "move-window left")
(define-key *top-map* (kbd "J") "move-window down")
(define-key *top-map* (kbd "K") "move-window up")
(define-key *top-map* (kbd "L") "move-window right")

(setf *resize-increment* 50)
(define-key *top-map* (kbd "M-l") "resize-direction Right")
(define-key *top-map* (kbd "M-h") "resize-direction Left")
(define-key *top-map* (kbd "M-k") "resize-direction Up")
(define-key *top-map* (kbd "M-j") "resize-direction Down")



(run-shell-command "xmodmap -e 'clear mod4'" t)
(run-shell-command "xmodmap -e 'keycode 133 = F20'" t)
(set-prefix-key (kbd "F20"))



(run-shell-command "exec feh --bg-fill ~/wallpaper.jpeg")



(defvar *senju/workspaces*
  ;;   (list "一" "二" "三" "四" "五" "六" "七" "八" "九" "十" "数学" "勉強"))

  (list "一" "二" "三" "四" "五" "六" "七" "八" "九" "十" "数学" "勉強"))
  (stumpwm:grename (nth 0 *senju/workspaces*))
(dolist (workspace (cdr *senju/workspaces*))
  (stumpwm:gnewbg workspace))

(defvar *move-to-keybinds*
  (list "!" "@" "#" "$" "%" "^" "&" "*" "(" "[" "]"))
(dotimes (y (length *senju/workspaces*))
  (let ((workspace (write-to-string (+ y 1))))
    (define-key *root-map* (kbd workspace) (concat "gselect " workspace))
    (define-key *root-map* (kbd (nth y *move-to-keybinds*)) (concat "gmove-and-follow " workspace))))

(defun workspace-number-to-character (index)
  (elt '("一" "二" "三" "四" "五" "六" "七" "八" "九" "十" "数学" "勉強") index))

;; Modify the modeline format to display group numbers as characters
(defvar *modeline-format*
  '(" " (:eval (workspace-number-to-character (current-group))) " " mode-line-misc-info mode-line-client
    mode-line-modified mode-line-frame-identification " " mode-line-buffer-identification))


(define-command clean-empty-frames ()
  "Delete all empty frames."
  (interactive)
  (dolist (frame (screen-frames (current-screen)))
    (when (and (null (frame-windows frame))
               (not (eq (current-frame) frame)))
      (delete-frame frame))))

(define-key *top-map* (kbd "M-s") "clean-empty-frames")



(setf *message-window-gravity* :center
      *input-window-gravity* :center
      *window-border-style* :thin
      *message-window-padding* 10
      *maxsize-border-width* 2
      *normal-border-width* 2
      *transient-border-width* 2
      stumpwm::*float-window-border* 4
      stumpwm::*float-window-title-height* 20
      *mouse-focus-policy* :click)




;; le gavin


;; (setq *debug-level* 5)
;; (redirect-all-output (data-dir-file "debug-output" "txt"))

;;; Helpers
(defun tr-define-key (key command)
  (define-key *top-map* (kbd (concat "s-" key )) command)
  (define-key *root-map* (kbd key) command))

(defun file-readable-p (file)
  "Return t, if FILE is available for reading."
  (handler-case
      (with-open-file (f file)
                      (read-line f))
    (stream-error () nil)))

(defun executable-p (name)
  "Tell if given executable is present in PATH."
  (let ((which-out (string-trim '(#\  #\linefeed)
                                (run-shell-command (concat "which " name) t))))
    (unless (string-equal "" which-out) which-out)))

(defun window-menu-format (w)
  (list (format-expand *window-formatters* *window-format* w) w))

(defun window-from-menu (windows)
  (when windows
    (second (select-from-menu
             (group-screen (window-group (car windows)))
             (mapcar 'window-menu-format windows)
             "Select Window: "))))

(defun windows-in-group (group)
  (group-windows (find group (the list (screen-groups (current-screen)))
                       :key 'group-name :test 'equal)))

(defun floatingp (window)
  "Return T if WINDOW is floating and NIL otherwise"
  (typep window 'stumpwm::float-window))

(defun always-on-top-off (window) ()
       "Stop the given WINDOW from always being on top of other windows"
       (let ((ontop-wins (group-on-top-windows (current-group))))
         (setf (group-on-top-windows (current-group))
               (remove window ontop-wins))))

(defun always-on-top-on (window) ()
       "Set the given WINDOW to always be on top of other windows"
       (let ((w window)
             (windows (the list (group-on-top-windows (current-group)))))
         (when w
           (unless (find w windows)
             (push window (group-on-top-windows (current-group)))))))

(defmacro with-on-top (win &body body)
  "Make sure WIN is on the top level while the body is running and
restore it's always-on-top state afterwords"
  (let ((cw (gensym))
        (ontop (gensym)))
    `(let* ((,cw ,win)
            (,ontop (find ,cw (group-on-top-windows (current-group)))))
       (unwind-protect
           (progn (unless ,ontop (always-on-top-on ,cw))
                  ,@body))
       (unless ,ontop (always-on-top-off ,cw)))))
(defun slop-get-pos ()
  (mapcar #'parse-integer (ppcre:split "[^0-9]" (run-shell-command
                                                 "slop -f \"%x %y %w %h\"" t))))

(defun slop ()
  "Slop the current window or just float if slop cli not present."
  (when (executable-p "slop")
    (let ((win    (current-window))
          (group  (current-group))
          (pos    (slop-get-pos)))
      (stumpwm::float-window win group)
      (stumpwm::float-window-move-resize win
                                         :x (nth 0 pos)
                                         :y (nth 1 pos)
                                         :width (nth 2 pos)
                                         :height (nth 3 pos))
      (always-on-top-on win))))


(defcommand remove-lose-focus () ()
  "Remove the window without feaking out because of :sloppy *mouse-focus-policy*"
  (with-focus-lost (remove-split)))

(defcommand fullscreen-and-raise () ()
  "Fullscreen window and make sure it's on top of all other windows"
  (with-on-top (stumpwm:current-window) (fullscreen)))

;;; Theme
(setf *colors*
      '("#000000"   ;black
        "#BF6262"   ;red
        "#a1bf78"   ;green
        "#dbb774"   ;yellow
        "#7D8FA3"   ;blue
        "#ff99ff"   ;magenta
        "#53cdbd"   ;cyan
        "#ffffff")) ;white

(update-color-map (current-screen))

;;; Font
(ql:quickload :clx-truetype)

;; Make sure my local fonts are avaliable
(pushnew (concat (getenv "HOME")
                 "/.local/share/fonts/")
         xft:*font-dirs* :test #'string=)
(xft:cache-fonts)

(let ((parent-font "PragmataPro Liga"))
  (when (find parent-font (the list (clx-truetype:get-font-families))
              :test #'string=)
    (load-module "ttf-fonts")
    (set-font `(,(make-instance 'xft:font
                                :family "PragmataPro Liga"
                                :subfamily "Regular"
                                :size 11
                                :antialias t)))))

;;; Basic Settings
(setf *window-format* "%m%s%50t")
(setf *mode-line-background-color* (car *colors*)
      *mode-line-foreground-color* (car (last *colors*))
      *mode-line-timeout* 1)

(setf *message-window-gravity* :center
      *window-border-style* :thin
      *message-window-padding* 3
      *maxsize-border-width* 2
      *normal-border-width* 2
      *transient-border-width* 2
      stumpwm::*float-window-border* 1
      stumpwm::*float-window-title-height* 1)

;; Focus Follow Mouse
(setf *mouse-focus-policy* :sloppy)

;;; Completion
;; ;; Show all completions from start
;; (setf *input-completion-show-empty* nil)
;; ;; keep completions open even when one is selected
;; (setf *input-completion-style* (make-input-completion-style-unambiguous))
(setf *input-window-gravity* :center
      ;; TODO determin why this appears above
      *message-window-input-gravity* :left)

(setf *input-completion-show-empty* t)

;; Remember commands and offers orderless completion
;; https://github.com/landakram/stumpwm-prescient
(ql:quickload :stumpwm-prescient)
(setf *input-refine-candidates-fn* 'stumpwm-prescient:refine-input)

;;; Startup Commands
(run-shell-command "xsetroot -cursor_name left_ptr")

;;; Bindings
(set-prefix-key (kbd "XF86Tools"))

;; General Top Level Bindings
(define-key *top-map* (kbd "s-n") "pull-hidden-next")
(define-key *top-map* (kbd "s-p") "pull-hidden-previous")
;; Tab like cycling
(define-key *top-map* (kbd "s-C-n") "next-in-frame")
(define-key *top-map* (kbd "s-C-p") "prev-in-frame")
;; Frame cycling
(define-key *top-map* (kbd "s-TAB") "fnext")
(define-key *top-map* (kbd "s-ISO_Left_Tab") "fprev")

(setf *resize-increment* 25)
(tr-define-key "f" "fullscreen")
(tr-define-key "q" "only")
(tr-define-key "=" "exec menu_connection_manager.sh")
(tr-define-key "X" "exec power_menu.sh")
(tr-define-key "P" "exec clipmenu")


;; Window Movement
(dyn-blacklist-command "move-window")
(dyn-blacklist-command "remove-lose-focus")
(define-key *top-map* (kbd "s-H") "move-window left")
(define-key *top-map* (kbd "s-J") "move-window down")
(define-key *top-map* (kbd "s-K") "move-window up")
(define-key *top-map* (kbd "s-L") "move-window right")

;;; Volume Stuff
(let ((vdown "exec cm down 5")
      (vup "exec cm up 5")
      (m *top-map*))
  (define-key m (kbd "s-C-a")                vdown)
  (define-key m (kbd "XF86AudioLowerVolume") vdown)
  (define-key m (kbd "s-C-f")                vup)
  (define-key m (kbd "XF86AudioRaiseVolume") vup))

;;; Brightness
(when *initializing*
  (defconstant backlightfile "/sys/class/backlight/intel_backlight/brightness"))

(let ((bdown   "exec xbacklight -dec 10")
      (bup     "exec xbacklight -inc 10")
      (m *top-map*))
  (define-key m (kbd "s-C-s")                 bdown)
  (define-key m (kbd "XF86MonBrightnessDown") bdown)
  (define-key m (kbd "s-C-d")                 bup)
  (define-key m (kbd "XF86MonBrightnessUp")   bup))

;;; General Root Level Bindings
(defcommand term (&optional prg) ()
  (run-shell-command (if prg
                         (format nil "st -e ~A" prg)
                       "st")))
(define-key *root-map* (kbd "c")   "term")
(define-key *root-map* (kbd "C-c") "term")
(define-key *root-map* (kbd "y") "eval (term \"cm\")")
(define-key *root-map* (kbd "w") "exec ducksearch")
(define-key *root-map* (kbd "b") "pull-from-windowlist")
(define-key *root-map* (kbd "R") "iresize")
(define-key *root-map* (kbd "r") "remove-lose-focus")
(define-key *root-map* (kbd "f") "fullscreen-and-raise")
(define-key *root-map* (kbd "Q") "quit-confirm")

(define-key *root-map* (kbd "SPC") "exec cabl -c")
;; more usful alternatives to i and I
(define-key *root-map* (kbd "i") "show-window-properties")
(define-key *root-map* (kbd "I") "list-window-properties")

;;; Groups
(grename "main")
(gnewbg ".trash") ; hidden group
(gnewbg "distractions") ; for discord and stuff
(gnew-dynamic "dy")

;; Don't jump between groups when switching apps
(setf *run-or-raise-all-groups* nil)
(define-key *groups-map* (kbd "l") "change-default-layout")
(define-key *groups-map* (kbd "d") "gnew-dynamic")
(define-key *groups-map* (kbd "s") "gselect")

(load-module "globalwindows")
(define-key *groups-map* (kbd "b") "global-pull-windowlist")

;;;; Hide and Show Windows
(defcommand pull-from-trash () ()
  (let* ((windows (windows-in-group ".trash"))
         (window  (window-from-menu windows)))
    (when window
      (move-window-to-group window (current-group))
      (stumpwm::pull-window window))))

(defcommand move-to-trash () ()
  (stumpwm:run-commands "gmove .trash"))

(tr-define-key "]" "move-to-trash")
(tr-define-key "[" "pull-from-trash")


;;; Floating Windows
(defcommand toggle-slop-this () ()
  (let ((win    (current-window))
        (group  (current-group)))
    (cond
     ((floatingp win)
      (always-on-top-off win)
      (stumpwm::unfloat-window win group))
     (t (slop)))))

(tr-define-key "z" "toggle-slop-this")

;;; Splits
(defcommand hsplit-and-focus () ()
  "create a new frame on the right and focus it."
  (with-focus-lost
   (hsplit)
   (move-focus :right)))

(defcommand vsplit-and-focus () ()
  "create a new frame below and focus it."
  (with-focus-lost
   (vsplit)
   (move-focus :down)))
(define-key *root-map* (kbd "v") "hsplit-and-focus")
(define-key *root-map* (kbd "s") "vsplit-and-focus")

;; Extra mappings for dynamic windows
(define-minor-mode my/tile-mode () ()
  (:interactive t)
  (:scope :dynamic-group)
  (:top-map '(("s-v" . "exchange-with-master")
              ("s-=" . "change-default-split-ratio 1/2")))
  (:lighter-make-clickable nil)
  (:lighter "MY/TILE"))
;; (my/tile-mode)
(loop :for i :in '("hsplit-and-focus"
                   "vsplit-and-focus")
      :do (dyn-blacklist-command i))

;;; Mode-Line
(load-module "battery-portable")

;;;; Get Fit
(declaim (type fixnum *reps*))
(defvar *reps* 0
  "Variable for keeping track of reps")

(defcommand add-reps (reps) ((:number "Enter reps: "))
  (declare (type fixnum reps))
  (when reps
    (setq *reps* (+ *reps* reps))))

(defcommand reset-reps () ()
  (setq *reps* 0))

(defvar *gym-map*
  (let ((m (make-sparse-keymap)))
    (define-key m (kbd "a") "add-reps")
    (define-key m (kbd "r") "reset-reps")
    m))
(define-key *root-map* (kbd "ESC") '*gym-map*)

;;;; Actual Modeline
(setf *time-modeline-string* "%a, %b %d %I:%M%p")
(setf *screen-mode-line-format*
      (list
       ;; Groups
       " ^7[^B^4%n^7^b] "
       ;; Pad to right
       "^>"
       '(:eval (when (> *reps* 0)
                 (format nil "^1^B(Reps ~A)^n " *reps*)))
       ;; Date
       "^7"
       "%d"
       ;; Battery
       " ^7[^n%B^7]^n "))

(defun enable-mode-line-everywhere ()
  (loop for screen in *screen-list* do
        (loop for head in (screen-heads screen) do
              (enable-mode-line screen head t))))
(enable-mode-line-everywhere)
;; turn on/off the mode line for the current head only.
(define-key *top-map* (kbd "s-B") "mode-line")

;;; Gaps
(load-module "swm-gaps")
(setf swm-gaps:*inner-gaps-size* 13
      swm-gaps:*outer-gaps-size* 7
      swm-gaps:*head-gaps-size* 0)
(when *initializing*
  (swm-gaps:toggle-gaps))
(define-key *groups-map* (kbd "g") "toggle-gaps")

;;; Remaps
(define-remapped-keys
  '(("(acme)"
     ("C-b"   . "Left")
     ("C-n"   . "Down")
     ("C-p"   . "Up")
     ("C-d"   . ("Right" "C-h")))
    ("(discord|Element|Google-chrome)"
     ("C-a"   . "Home")
     ("C-e"   . "End")
     ("C-E"   . "C-e")
     ("C-n"   . "Down")
     ("C-p"   . "Up")
     ("C-f"   . "Right")
     ("C-b"   . "Left")
     ("C-N"   . "S-Down")
     ("C-P"   . "S-Up")
     ("C-F"   . "S-Right")
     ("C-B"   . "S-Left")
     ("C-v"   . "Next")
     ("M-v"   . "Prior")
     ("M-w"   . "C-c")
     ("C-w"   . ("C-S-Left" "C-x"))
     ("C-y"   . "C-v")
     ("M-<"   . "Home")
     ("M->"   . "End")
     ("C-M-b" . "M-Left")
     ("C-M-f" . "M-Right")
     ("M-f"   . "C-Right")
     ("M-b"   . "C-Left")
     ("C-s"   . "C-f")
     ("C-j"   . "C-k")
     ("C-/"   . "C-z")
     ("C-k"   . ("C-S-End" "C-x"))
     ("C-d"   . "Delete")
     ("M-d"   . "C-Delete"))))

;;; Undo And Redo Functionality
(load-module "winner-mode")
(define-key *root-map* (kbd "u") "winner-undo")
(define-key *root-map* (kbd "C-r") "winner-redo")
(add-hook *post-command-hook* (lambda (command)
                                (when (member command winner-mode:*default-commands*)
                                  (winner-mode:dump-group-to-file))))

;;; Emacs integration
(defcommand emacs () () ; override default emacs command
  "Start emacs if emacsclient is not running and focus emacs if it is
running in the current group"
  (run-or-raise "oemacsclient -c -a 'emacs'" '(:class "Emacs")))
;; Treat emacs splits like Xorg windows
(defun is-emacs-p (win)
  "nil if the WIN"
  (when win
    (string-equal (window-class win) "Emacs")))

(defmacro exec-el (expression)
  "execute emacs lisp do not collect it's output"
  `(eval-string-as-el (write-to-string ',expression)))

(defun eval-string-as-el (elisp &optional collect-output-p)
  "evaluate a string as emacs lisp"
  (let ((result (run-shell-command
                 (format nil "timeout --signal=9 1m emacsclient --eval \"~a\""
                         elisp)
                 collect-output-p)))
    (handler-case (read-from-string result)
      ;; Pass back a string when we can't read from the string
      (error () result))))

(defmacro eval-el (expression)
  "evaluate emacs lisp and collect it's output"
  `(eval-string-as-el ,(write-to-string expression :case :downcase) t))

(declaim (ftype
          (function (string) (values string &optional))
          emacs-winmove))
(defun emacs-winmove (direction)
  "executes the emacs function winmove-DIRECTION where DIRECTION is a string"
  (eval-string-as-el (concat "(windmove-" direction ")") t))



(defcommand my-mv (dir) ((:direction "Enter direction: "))
  (when dir (better-move-focus dir)))

(define-key *top-map* (kbd "s-h") "my-mv left")
(define-key *top-map* (kbd "s-j") "my-mv down")
(define-key *top-map* (kbd "s-k") "my-mv up")
(define-key *top-map* (kbd "s-l") "my-mv right")

;;; SLY setup
(ql:quickload :slynk)
(defvar *slynk-port* slynk::default-server-port)
(defparameter *stumpwm-slynk-session* nil)

(defcommand start-slynk (&optional (port *slynk-port*)) ()
  (handler-case
      (defparameter *stumpwm-slynk-session*
        (slynk:create-server
         :dont-close t
         :port port))
    (error (c)
           (format *error-output* "Error starting slynk: ~a~%" c)
           )))

(defcommand restart-slynk () ()
  "Restart Slynk and reload source.
This is needed if Sly updates while StumpWM is running"
  (stop-slynk)
  (start-slynk))

(defcommand stop-slynk () ()
  "Restart Slynk and reload source.
  This is needed if Sly updates while StumpWM is running"
  (slynk:stop-server *slynk-port*))

(defcommand connect-to-sly () ()
  (unless *stumpwm-slynk-session*
    (start-slynk))
  (exec-el (sly-connect "localhost" *slynk-port*))
  (emacs))

(define-stumpwm-type :dunstctl (input prompt)
  (completing-read (current-screen) prompt '("context" "action" "close" "history")))

(defcommand dunst () ()
  (run-shell-command "dunstctl context"))

;; gavin




(setf *message-window-gravity* :center
      *input-window-gravity* :center
      *window-border-style* :thin
      *message-window-padding* 10
      *maxsize-border-width* 2
      *normal-border-width* 2
      *transient-border-width* 2
      stumpwm::*float-window-border* 4
      stumpwm::*float-window-title-height* 20)


