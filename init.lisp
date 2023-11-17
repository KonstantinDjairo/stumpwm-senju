;; -*- mode:read-only -*- ;;

(in-package :stumpwm)
(load "~/quicklisp/setup.lisp")


(run-shell-command "export PATH='${PATH}:${HOME}/.local/bin'")
(setq *shell-program* (stumpwm::getenv "SHELL"))
(init-load-path #p"/home/hashirama/.stumpwm.d/modules/")
(let ((quicklisp-init (merge-pathnames "/home/hashirama/quicklisp/setup.lisp"
                                       (user-homedir-pathname))))
  (when (probe-file quicklisp-init)
    (load quicklisp-init)))


(run-shell-command "xrdb /home/hashirama/.Xresources")

;; しかたない。
;;(run-shell-command "exec tmux new -d fcitx5")

;; onion server always running
;;(run-shell-command "exec /home/hashirama/Downloads/darkmx-1.27-linux64/darkmx")


(sleep 1)
;; for some weird reason, the keybinding stops working when fcitx is activated at first, but then it normalizes when we set the mod key again
(run-shell-command "exec xmodmap -e 'clear mod4' && exec xmodmap -e 'keycode 133 = F20'")



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


(setf *mode-line-timeout* 2)

(setf *group-format* "%s [%n] %t ")
(setf *window-format* "%m%n%s%c")



(reload)

(sleep 2)
(ql:quickload "clx-truetype")
(load-module "ttf-fonts")
(xft:cache-fonts) ;; 
(set-font "-xos4-terminus-medium-r-normal-*-20-*-*-*-*-*-*-*")
(set-font (make-instance 'xft:font :family "IPAMincho" :subfamily "Regular" :size 10))

(run-shell-command "xsetroot -cursor_name macOS-BigSur-White")



(setf *mode-line-background-color* "#000000" 
      *mode-line-foreground-color* "#eceff4" )

(setf *mode-line-border-color* "#161414"
      *mode-line-border-width* 0
      stumpwm:*mode-line-border-width* 4)




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
(define-key *top-map* (kbd "M-v") "exec dictpopup")
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
(load-module "notifications")  ; optionally, goes before `swm-pomodoro`
(load-module "swm-pomodoro")
(define-key *top-map* (kbd "M-b") "pomodoro-start-timer")
(define-key *top-map* (kbd "M-,") "pomodoro-cancel-timer")
(define-key *top-map* (kbd "M-=") "pomodoro-status")





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






