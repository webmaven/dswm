;; Copyright (C) 2003-2008 Shawn Betts
;; Copyright (C) 2010-2012 Alexender aka CosmonauT Vynnyk
;;
;;  This file is part of dswm.
;;
;; dswm is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; dswm is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this software; see the file COPYING.  If not, see
;; <http://www.gnu.org/licenses/>.

;; Commentary:
;;
;; define standard key bindings
;;
;; Code:

(in-package #:dswm)

(export '(*groups-map*
          *help-map*
          *root-map*
	  set-prefix-key
	  bind))

(defvar *escape-key* (kbd "C-j")
  "The escape key. Any keymap that wants to hang off the escape key
should use this specific key struct instead of creating their own
C-j.")

(defvar *escape-fake-key* (kbd "j")
  "The binding that sends the fake escape key to the current window.")

(defvar *root-map* nil
  "This is the keymap by default bound to @kbd{C-j}. It is known as the @dfn{prefix map}.")

(defvar *groups-map* nil
  "The keymap that group related key bindings sit on. It is bound to @kbd{C-j g} by default.")

(defvar *help-map* nil
  "Help related bindings hang from this keymap")

(defvar *group-top-maps* '((tile-group *tile-group-top-map*)
                           (float-group *float-group-top-map*)
                           (group *group-top-map*))
  "An alist of the top level maps for each group type. For a given
group, all maps whose type matches the given group are active. So for
a tile-group, both the group map and tile-group map are active.

Order is important. Each map is seached in the order they appear in
the list (inactive maps being skipped). In general the order should go
from most specific groups to most general groups.")

(defvar *group-top-map* nil)
(defvar *group-root-map* nil)
(defvar *tile-group-top-map* nil)
(defvar *tile-group-root-map* nil)
(defvar *float-group-top-map* nil)
(defvar *float-group-root-map* nil)

(fill-keymap *top-map*
  (kbd "M-`") "scratchpad"
  (kbd "M-~") "gmove-scratchpad"
  *escape-key* '*root-map*)

(fill-keymap *root-map*
  (kbd "c")   "terminal"
  (kbd "C-c") "terminal"
  (kbd "e")   "editor"
  (kbd "C-e") "editor"
  (kbd "b")   "browser"
  (kbd "C-b") "browser"
  (kbd "C-B") "banish"
  (kbd "B") "banish"
  (kbd "a")   "time"
  (kbd "C-a") "time"
  (kbd "!")   "exec"
  (kbd "t")   "run-in-terminal"
  (kbd "C-g") "abort"
  *escape-fake-key* "send-escape"
  (kbd ";")   "colon"
  (kbd ":")   "eval"
  ;; (kbd "v")   "version" ;; TODO: use it!
  (kbd "m")   "move-window-to-frame"
  (kbd "C-m") "lastmsg"
  (kbd "G")   "vgroups"
  (kbd "g")   '*groups-map*
  (kbd "F1")  "gselect-by-number 1"
  (kbd "F2")  "gselect-by-number 2"
  (kbd "F3")  "gselect-by-number 3"
  (kbd "F4")  "gselect-by-number 4"
  (kbd "F5")  "gselect-by-number 5"
  (kbd "F6")  "gselect-by-number 6"
  (kbd "F7")  "gselect-by-number 7"
  (kbd "F8")  "gselect-by-number 8"
  (kbd "F9")  "gselect-by-number 9"
  (kbd "F10") "gselect-by-number 10"
  (kbd "l")   "lastcmd"
  (kbd "C-l") "lastcmd"
  (kbd "C-h") "help-short"
  (kbd "h")   '*help-map*)

(fill-keymap *group-top-map*
  *escape-key* '*group-root-map*)

(fill-keymap *group-root-map*
  (kbd "C-u") "next-urgent"
  (kbd "k")   "delete"
  (kbd "C-k") "delete"
  (kbd "K")   "kill"
  (kbd "'")   "select"
  (kbd "\"")  "windowlist"
  (kbd "1")   "select-window-by-number 1"
  (kbd "2")   "select-window-by-number 2"
  (kbd "3")   "select-window-by-number 3"
  (kbd "4")   "select-window-by-number 4"
  (kbd "5")   "select-window-by-number 5"
  (kbd "6")   "select-window-by-number 6"
  (kbd "7")   "select-window-by-number 7"
  (kbd "8")   "select-window-by-number 8"
  (kbd "9")   "select-window-by-number 9"
  (kbd "C-N") "number"
  (kbd "#")   "mark"
  (kbd "F11") "fullscreen"
  (kbd "A")   "title"
  (kbd "i")   "info")

(fill-keymap *tile-group-top-map*
  *escape-key* '*tile-group-root-map*)

(fill-keymap *tile-group-root-map*
  (kbd "n")       "pull-hidden-next"
  (kbd "C-n")     "pull-hidden-next"
  (kbd "M-n")     "next"
  (kbd "C-M-n")   "next-in-frame"
  (kbd "SPC")     "pull-hidden-next"
  (kbd "C-SPC")   "pull-hidden-next"
  (kbd "p")       "pull-hidden-previous"
  (kbd "C-p")     "pull-hidden-previous"
  (kbd "M-p")     "prev"
  (kbd "C-M-p")   "prev-in-frame"
  (kbd "W")       "place-existing-windows"
  *escape-key*     "pull-hidden-other"
  (kbd "M-t")     "other-in-frame"
  (kbd "C-0")     "pull 0"
  (kbd "C-1")     "pull 1"
  (kbd "C-2")     "pull 2"
  (kbd "C-3")     "pull 3"
  (kbd "C-4")     "pull 4"
  (kbd "C-5")     "pull 5"
  (kbd "C-6")     "pull 6"
  (kbd "C-7")     "pull 7"
  (kbd "C-8")     "pull 8"
  (kbd "C-9")     "pull 9"
  (kbd "R")       "remove"
  (kbd "s")       "vsplit"
  (kbd "S")       "hsplit"
  (kbd "r")       "iresize"
  (kbd "o")       "fnext"
  (kbd "TAB")     "fnext"
  (kbd "M-TAB")   "fother"
  (kbd "f")       "fselect"
  (kbd "F")       "curframe"
  (kbd "-")       "fclear"
  (kbd "Q")       "only"
  (kbd "Up")      "move-focus up"
  (kbd "Down")    "move-focus down"
  (kbd "Left")    "move-focus left"
  (kbd "Right")   "move-focus right"
  (kbd "M-Up")    "move-window up"
  (kbd "M-Down")  "move-window down"
  (kbd "M-Left")  "move-window left"
  (kbd "M-Right") "move-window right"
  (kbd "+")       "balance-frames")

(fill-keymap *float-group-top-map*
  *escape-key* '*float-group-root-map*)

(fill-keymap *float-group-root-map*
  (kbd "n")       "float-focus-next"
  (kbd "C-n")     "float-focus-next"
  (kbd "SPC")     "float-focus-next"
  (kbd "C-SPC")   "float-focus-next"
  (kbd "p")       "float-focus-previous"
  (kbd "C-p")     "float-focus-previous"
  (kbd "W")       "place-existing-windows"
  *escape-key*     "float-focus-other"
  ;; (kbd "C-0")     "float-focus 0"
  ;; (kbd "C-1")     "float-focus 1"
  ;; (kbd "C-2")     "float-focus 2"
  ;; (kbd "C-3")     "float-focus 3"
  ;; (kbd "C-4")     "float-focus 4"
  ;; (kbd "C-5")     "float-focus 5"
  ;; (kbd "C-6")     "float-focus 6"
  ;; (kbd "C-7")     "float-focus 7"
  ;; (kbd "C-8")     "float-focus 8"
  ;; (kbd "C-9")     "float-focus 9"
  ;; (kbd "r")       "fwresize" ;; Resize window
)

(fill-keymap *groups-map*
  (kbd "g")     "vgroups"
  (kbd "c")     "gnew"
  (kbd "n")     "gnext"
  (kbd "C-n")   "gnext"
  (kbd "SPC")   "gnext"
  (kbd "C-SPC") "gnext"
  (kbd "N")     "gnext-with-window"
  (kbd "p")     "gprev"
  (kbd "C-p")   "gprev"
  (kbd "P")     "gprev-with-window"
  (kbd "o")     "gother"
  (kbd "'")     "gselect"
  (kbd "\"")    "grouplist"
  (kbd "m")     "gmove"
  (kbd "M")     "gmove-marked"
  (kbd "s")     "gmove-scratchpad"
  (kbd "S")     "gmove-marked-scratchpad"
  (kbd "k")     "gkill"
  (kbd "A")     "grename"
  (kbd "r")     "grename"
  (kbd "!")     "grun-new"
  (kbd "@")     "grun-new-float"
  (kbd "1")     "gselect-by-number 1"
  (kbd "2")     "gselect-by-number 2"
  (kbd "3")     "gselect-by-number 3"
  (kbd "4")     "gselect-by-number 4"
  (kbd "5")     "gselect-by-number 5"
  (kbd "6")     "gselect-by-number 6"
  (kbd "7")     "gselect-by-number 7"
  (kbd "8")     "gselect-by-number 8"
  (kbd "9")     "gselect-by-number 9"
  (kbd "0")     "gselect-by-number 10")

(fill-keymap *help-map*
  (kbd "v") "describe-variable"
  (kbd "f") "describe-function"
  (kbd "k") "describe-key"
  (kbd "c") "describe-command"
  (kbd "w") "where-is")

(defcommand command-mode () ()
"Command mode allows you to type ratpoison commands without needing the
@key{C-j} prefix. Keys not bound in StumpWM will still get sent to the
current window. To exit command mode, type @key{C-g}."
  (run-hook *command-mode-start-hook*)
  (message "Press C-g to exit command-mode.")
  (push-top-map *root-map*))

(defcommand set-prefix-key (key)
  ((:key "What key do you want to set as prefix? "))
  "Change the dswm prefix key to KEY.
@example
\(dswm:set-prefix-key (dswm:kbd \"C-M-H-s-z\"))
@end example

This will change the prefix key to @key{Control} + @key{Meta} + @key{Hyper} + @key{Super} +
the @key{z} key. By most standards, a terrible prefix key but it makes a
great example."
  (check-type key key)
  (copy-key-into key *escape-key*)
  ;; if the escape key has no modifiers then disable the fake key by
  ;; giving it keysym -1, an impossible value. Otherwise you have 2
  ;; identical bindings and the one that appears first in the list
  ;; will be matched.
  (copy-key-into (make-key :keysym (if (key-mods-p *escape-key*)
                                       (key-keysym key)
                                       -1)) *escape-fake-key*)
  (sync-keys))

(defcommand-alias escape set-prefix-key)

(defcommand bind (key command)
                 ((:string "Key chord to bind on: ")
                  (:command "Command to bind: "))
  "Hang a key binding off the escape key."
  (define-key *root-map* (kbd key) command))

(defcommand send-escape () ()
  "Send the escape key to the current window."
  (send-meta-key (current-screen) *escape-key*))
