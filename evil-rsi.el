;;; evil-rsi.el --- Use emacs motion keys in evil, inspired by vim-rsi

;; Copyright (C) 2014 Quang Linh LE

;; Author: Quang Linh LE <linktohack@gmail.com>
;; URL: http://github.com/linktohack/evil-rsi
;; Version: 1.0.0
;; Keywords: evil rsi evil-rsi
;; Package-Requires: ((evil "1.0.0"))

;; This file is not part of GNU Emacs.

;;; License:

;; This file is part of evil-rsi
;;
;; evil-rsi is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published
;; by the Free Software Foundation, either version 3 of the License,
;; or (at your option) any later version.
;;
;; evil-rsi is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;; This program emulates `vim-rsi` initially developed by Tim Pope
;; (tpope). It brings some essential `emacs` motion bindings back.
;;
;; `<C-n>` and `<C-p>` are important keys, and will be enabled only
;; when `auto-complete` is enabled.


;;; Example:
;;
;; `<C-e>` to move to end of line in all states
;; `<C-d>` to delete to delete character to the right in `insert` state
;; `<C-k>` to delete current line in `insert` state


;;; Code:

(require 'evil)

(defgroup evil-rsi nil
  "This program brings some essential `emacs` motion bindings back to evil."
  :group 'evil)

(defcustom evil-rsi-clobber-default-help-key t
  "If non-nil, rebind C-h to `delete-backward-char' in evil insert state map."
  :type 'boolean
  :group 'evil-rsi)


;;;###autoload
(define-minor-mode evil-rsi-mode
  "Rsi mode."
  :lighter " rsi"
  :global t
  :keymap (let ((map (make-sparse-keymap)))
            (evil-define-key 'insert map "\C-a" 'beginning-of-line)
            (evil-define-key 'motion map "\C-a" 'beginning-of-line)
            (evil-define-key 'insert map "\C-b" 'backward-char)
            (evil-define-key 'insert map "\C-d" 'delete-char)
            (evil-define-key 'insert map "\C-e" 'end-of-line)
            (evil-define-key 'motion map "\C-e" 'end-of-line)
            (evil-define-key 'insert map "\C-f" 'forward-char)
            (if evil-rsi-clobber-default-help-key
                (evil-define-key 'insert map "\C-h" 'delete-backward-char))
            (evil-define-key 'motion map "\C-k" 'kill-line)
            (evil-define-key 'insert map "\C-k" 'kill-line)
            (evil-define-key 'insert map (kbd "C-S-k") 'evil-insert-digraph)
            map))

(dolist (sym '(auto-complete company))
  (eval-after-load sym
    '(progn
       (evil-define-key 'insert evil-rsi-mode-map "\C-n" 'next-line)
       (evil-define-key 'insert evil-rsi-mode-map "\C-p" 'previous-line))))

(provide 'evil-rsi)

;;; evil-rsi.el ends here
