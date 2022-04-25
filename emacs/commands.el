(defun indent-whole-buffer ()
  (interactive)
  (point-to-register ?R)
  (mark-whole-buffer)
  (indent-region (point) (mark))
  (deactivate-mark)
  (jump-to-register ?R))

(defun insert-beerware ()
  (interactive)
  (insert "/*
 * ----------------------------------------------------------------------------
 * \"THE BEER-WARE LICENSE\" (Revision 42):
 * <gustek@riseup.net> wrote this file.  As long as you retain this notice you
 * can do whatever you want with this stuff. If we meet some day, and you think
 * this stuff is worth it, you can buy me a beer in return.
 * ----------------------------------------------------------------------------
 */"))

(defun insert-gpl ()
  (interactive)
  (let ((name (capitalize (projectile-project-name))))
    (insert
     (format "/*
 *   This file is part of %s
 *
 *   %s is free software: you can redistribute and/or modify
 *   it under the terms of the GNU General Public License as published by
 *   the Free Software Foundation, version 3 of the license ONLY.
 *
 *   %s is distributed in the hope that it will be useful,
 *   but WITHOUT ANY WARRANTY; without even the implied warranty of
 *   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *   GNU General Public License for more details.
 *
 *   You should have received a copy of the GNU General Public License
 *   along with %s.  If not, see <https://www.gnu.org/licenses/>.
 */" name name name name))))
