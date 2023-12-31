#-quicklisp
(let ((quicklisp-init (merge-pathnames "quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))

;; log everything to ~/.stumpwm.d/stumpwm.log
(redirect-all-output (merge-pathnames *data-dir* "stumpwm.log"))

(stumpwm:toggle-mode-line (stumpwm:current-screen)
                          (stumpwm:current-head))

(in-package :stumpwm)
(setf *default-package* :stumpwm)


(setf *mode-line-pad-x* 5) ; Adjust the value as needed
(setf *mode-line-pad-y* 10) ; Adjust the value as needed

(setf *mode-line-background-color* "black")
(setf *mode-line-foreground-color* "black")
(setf *mode-line-border-color* "black")


;; we have to make it workable
(run-shell-command "xmodmap -e 'clear mod4'" t) ;; clears windowskey/mod4

(run-shell-command "xmodmap -e \'keycode 133 = F20\'" t) ;;assigns F20 to keycode 133

(set-prefix-key (kbd "F20")) ;; sets prefix to F20 which was just assigned to windows key

(run-shell-command "exec feh --bg-fill ~/wallpaper.jpg  & picom -b")
(run-shell-command "xrandr --output HDMI-A-0 --mode 1366x768")
(define-key *top-map* (kbd "M-p") "exec firefox")
(define-key *top-map* (kbd "M-l") "exec xfce4-terminal")
(define-key *top-map* (kbd "M-d") "exec rofi -show run")
(define-key *root-map* (kbd "R") "restart-hard")




(set-module-dir "/home/hashirama/.stumpwm.d/modules/")
(load-module 'binwarp)

(binwarp:define-binwarp-mode binwarp-mode
  "M" (:map *root-map*
      :redefine-bindings t)
  ((kbd "a") "binwarp right")
  ((kbd "w") "binwarp up")
  ((kbd "s") "binwarp down")
  ((kbd "d") "binwarp left")
  ((kbd "RET") "ratclick 1")
  ((kbd "SPC") "ratclick 3")
  ((kbd "C-n") "ratrelwarp  0 +5")
  ((kbd "C-p") "ratrelwarp  0 -5")
  ((kbd "C-f") "ratrelwarp +5  0")
  ((kbd "C-b") "ratrelwarp -5  0")
  ((kbd "C-N") "ratrelwarp  0 +35")    
  ((kbd "C-P") "ratrelwarp  0 -35")    
  ((kbd "C-F") "ratrelwarp +35  0")    
  ((kbd "C-B") "ratrelwarp -35  0")) 






(ql:quickload "clx-truetype")
(load-module "ttf-fonts")
(xft:cache-fonts) ;; 
(set-font (make-instance 'xft:font :family "HanaMinA" :subfamily "Regular" :size 12))
(setf *startup-message* "fonts loaded")
(setf *mode-line-bg* "black")

(define-key *top-map* (kbd "M-v") "exec /usr/bin/dictpopup")

;; I LOVE TYPING
(define-key *top-map* (kbd "M-g") "exec touchtyper")


;; youtube
(define-key *top-map* (kbd "M-f") "exec /bin/bash -c  youtube_search")                                                                                                                      

;; Frames
(define-key *root-map* (kbd "x") "hsplit")
(define-key *root-map* (kbd "z") "vsplit")
(define-key *root-map* (kbd "n") "remove-split")


(define-key *root-map* (kbd "Q") "quit")
(define-key *root-map* (kbd "R") "restart-hard")

(define-key *root-map* (kbd "q") "delete")                                                                                                                                
(define-key *root-map* (kbd "r") "remove")


;; Set padding in pixels
(setf *mode-line-pad-x* 2) ; Adjust the value as needed
(setf *mode-line-pad-y* 2) ; Adjust the value as needed

;; Set modeline colors
(setf *mode-line-background-color* "black")
(setf *mode-line-foreground-color* "white") ; Adjust the value as needed
(setf *mode-line-border-color* "black")


(load-module "swm-gaps")
(setf swm-gaps:*head-gaps-size*  0
      swm-gaps:*inner-gaps-size* 5
      swm-gaps:*outer-gaps-size* 40)
;;(when *initializing*
;;  (swm-gaps:toggle-gaps))

;; ----------
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
    (format NIL "~2,'0d:~2,'0d:~2,'0d ~d年~a時 ~d分、~a秒"
            yr (stringify-mon mon)
            date (stringify-dow dow)
            hr min sec)))

;; ----

(setf *mode-line-timeout* 2)

(setf *group-format* "%s [%n] %t ")
(setf *window-format* "%m%n%s%c")


;;---


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

;--

(setf *screen-mode-line-format* (list "[^B%n^b] %W^>%d"))
(setf *mode-line-timeout* 2)
(setf *screen-mode-line-format*
      (list "[^B%n^b] %W " ; groups/windows
            "^>" ; right align
(list '(:eval (concat "| "
                     (run-shell-command "top -bn 1 | grep '%Cpu' | awk '{printf \"%.0f%%\", $2 + $4}'" :output)
                     " |")))


      " ^7* " '(:eval (pretty-time)); date
            ))

;;---


(run-shell-command "xrdb /home/hashirama/.Xresources")

(run-shell-command "exec qbittorrent")
(run-shell-command "exec fcitx5")
;; onion server always running
(run-shell-command "exec /home/hashirama/Downloads/darkmx-1.27-linux64/darkmx")





;; Frames
(define-key *root-map* (kbd "x") "hsplit")
(define-key *root-map* (kbd "z") "vsplit")
(define-key *root-map* (kbd "n") "remove-split")


(define-key *root-map* (kbd "Q") "quit")
(define-key *root-map* (kbd "R") "restart-hard")

(define-key *root-map* (kbd "q") "delete")
(define-key *root-map* (kbd "r") "remove")




(sleep 4)

(run-shell-command "xmodmap -e 'clear mod4'" t) ;; clears windowskey/mod4

(run-shell-command "xmodmap -e \'keycode 133 = F20\'" t) ;;assigns F20 to keycode 133

(set-prefix-key (kbd "F20")) ;; sets prefix to F20 which was just assigned to windows key 





(setf *screen-mode-line-format*
      (list '(:eval (run-shell-command "date '+%R %b %d' |tr -d [:cntrl:]" t)) " | %c | %l | [^B%n^b] %W"))

;; Click to focus
(setf *mouse-focus-policy* :click)



(sleep 2) ;; wait for fcitx5 
;;(run-shell-command "xmodmap -e 'clear mod4'" t)
;;(run-shell-command "xmodmap -e 'keycode 133 = Super_L'" t)
;;(run-shell-command " xmodmap -e 'add mod4 = Super_L'" t)


;;(set-prefix-key (kbd "mod4"))  









(sleep 1)

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


(defvar *senju/workspaces*
  (list "0" "1" "2" "3" "4" "5" "6" "7" "8" "9" "10" "11" "12"))

(stumpwm:grename (nth 0 *senju/workspaces*))

(dolist (workspace (cdr *senju/workspaces*))
  (stumpwm:gnewbg workspace))

(defvar *move-to-keybinds*
  (list "!" "@" "#" "$" "%" "^" "&" "*" "(" "[" "]"))

(dotimes (y (length *senju/workspaces*))
  (let ((workspace (write-to-string y)))
    (define-key *root-map* (kbd workspace) (concat "gselect " workspace))
    (define-key *root-map* (kbd (nth y *move-to-keybinds*)) (concat "gmove-and-follow " workspace))))

(defun workspace-number-to-character (index)
  (if (numberp index)
      (write-to-string index)
      ""))


(defvar *modeline-format*
  '(" " (:eval (workspace-number-to-character (current-group))) " " mode-line-misc-info mode-line-client
    mode-line-modified mode-line-frame-identification " " mode-line-buffer-identification))


(setf *mode-line-background-color* "#000000" 
      *mode-line-foreground-color* "#eceff4" )

(setf *mode-line-border-color* "#161414"
      *mode-line-border-width* 0
      stumpwm:*mode-line-border-width* 4)




(setf *screen-mode-line-format* (list "[^B%n^b] %W^>%d"))
(setf *mode-line-timeout* 2)
(setf *mode-line-timeout* 2)

(setf *screen-mode-line-format*
      (list "[^B%n^b] %W "
            "^>"
            " ^7* " '(:eval (format-time-string "%H:%M"))))



(setf *group-format* "%s [%n] %t ")
(setf *window-format* "%m%n%s%c")

(setf *screen-mode-line-format*
      (list '(:eval (run-shell-command "date '+%R %b %d' |tr -d [:cntrl:]" t)) " | %c | %l | [^B%n^b] %W"))

;; Click to focus
(setf *mouse-focus-policy* :click)


(reload)

(sleep 2)

(set-font "-xos4-terminus-medium-r-normal-*-20-*-*-*-*-*-*-*")
(set-font (make-instance 'xft:font :family "HanaMinA" :subfamily "Regular" :size 10))

;;(run-shell-command "xsetroot -cursor_name macOS-BigSur-White")




(set-border-color       "#BDC0C6" )
(set-focus-color        "#161414" )
(set-unfocus-color      "#3E4451" )
(set-float-focus-color  "#161414" )
(set-float-unfocus-color "#3E4451" )


(setq *frame-bg-color* "#161414")      ; Dark background color for frames
(setq *frame-fg-color* "#BDC0C6")      ; Light foreground color for frames
(setq *title-bg-color* "#3E4451")      ; Background color for window titles
(setq *title-fg-color* "#1E1D23")      ; Text color for window titles
(setq *modeline-bg-color* "#6E737E")   ; Background color for the modeline
(setq *modeline-fg-color* "#eceff4")   ; Text color for the modeline



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





(define-key *root-map* (kbd "v") "exec alacritty")


;; manga
(define-key *root-map* (kbd "`") "exec transformers_ocr recognize")
(define-key *root-map* (kbd ".") "exec transformers_ocr hold")
(define-key *root-map* (kbd ";") "exec gomics")  ;; manga reader
;; ---------------------




(define-key *top-map* (kbd "M-p") "exec rofi -show drun")


;;(run-shell-command "if [ -z \"$(pgrep greenclip)\" ]; then tmux new -d greenclip daemon; fi")
;;(define-key *top-map* (kbd "M-]") "exec clipboard_history.sh")

(define-key *top-map* (kbd "M-o") "exec cabl")

(define-key *top-map* (kbd "M-f") "exec flameshot gui") 
(define-key *top-map* (kbd "M-n") "exec xmodmap -e 'clear mod4' && exec xmodmap -e 'keycode 133 = F20'") 




;; i need anki & qbittorrent to be always open
(run-shell-command "exec anki")
(run-shell-command "qbittorrent")
(run-shell-command "goldendict" )
(run-shell-command "calibre" )

(defcommand Anki () ()
  (run-or-raise "Anki" '(:class "Anki")))
(define-key *top-map* (kbd "M-1") "anki")

;; run or raise
(defcommand goldendict () ()
  (run-or-raise "goldendict" '(:class "GoldenDict-ng")))
(define-key *top-map* (kbd "M-d") "goldendict")


(defcommand calibre () ()
  (run-or-raise "calibre" '(:class "Calibre")))
(define-key *top-map* (kbd "M-2") "calibre")




;; Frames
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

;; pomodoro
;;(load-module "notifications")  ; optionally, goes before `swm-pomodoro`
;;(load-module "swm-pomodoro")
;;(define-key *top-map* (kbd "M-b") "pomodoro-start-timer")
;;(define-key *top-map* (kbd "M-,") "pomodoro-cancel-timer")
;;(define-key *top-map* (kbd "M-=") "pomodoro-status")






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


