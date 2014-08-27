;;;; Name

; eml2csv

; make csv from some eml files using clozure cl and quicklisp

;;;; Author

; fu7mu4

;;;; Licence

;The MIT License (MIT)
;
;Copyright (c) 2014 fu7mu4, fu7mu4@gmail.com
;
;Permission is hereby granted, free of charge, to any person obtaining a copy
;of this software and associated documentation files (the "Software"), to deal
;in the Software without restriction, including without limitation the rights
;to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
;copies of the Software, and to permit persons to whom the Software is
;furnished to do so, subject to the following conditions:
;
;The above copyright notice and this permission notice shall be included in
;all copies or substantial portions of the Software.
;
;THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
;OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
;THE SOFTWARE.

;;;; Usage

;; binary

; 1. put it in a directory that has some eml files with suffix "txt"
; 2. click to execute to write "result.csv" 
; 3. open result.csv () 
;    the result.csv has 4 fields (a file name, subject , from , date and body of the eml) in each records
;    for saving data amount, body text has a first 50 line only.



#|
;; to make windows binary executable 

; open this file on slime or some ccl environment

; load library
(ql:quickload :cl-ppcre)
(ql:quickload :csv-parser)

; make windows binary executable by ccl 
(ccl:save-application "eml2csv.exe" :toplevel-function #'eml2csv-small :prepend-kernel t )
|#

;;;; Code

;;;; required library 

(ql:quickload :cl-ppcre)
(ql:quickload :csv-parser)

;;;; parameter
(defvar *max-message-body-limit* 50) ;; max line for message body

;;;; character coding for read/write-ing file
; if it works on Japanese/Windows
(setf ccl:*default-external-format* (ccl:make-external-format
				     :character-encoding :cp932
				     :line-termination :dos))

(defun read-txt-mail (file)
  (let ((from nil)
	(subject nil)
	(date nil)
	(message-body "")
	(message-body-count nil))
    (with-open-file (in file :direction :input)
      (loop for line = (read-line in nil nil)
	   while line
	   do (progn 
		(setf from (get-var from line "^From:" "^(From:\\s*)"))
		(setf subject (get-var subject line "^Subject:" "^(Subject:\\s*)"))
		(setf date (get-var date line "^Date:" "^(Date:\\s*)"))
		(if message-body-count
		    (when (< message-body-count *max-message-body-limit*)
		      (incf message-body-count)
		      (setf message-body (format nil "~a~%~a" message-body line)))
		    (when (cl-ppcre:scan "^\\s*$" line)
		      (setf message-body-count 0))))))
    (list (namestring file) subject from date message-body)))

(defun get-var (var line hit-regex del-regex)
  (if var
      var
      (if (cl-ppcre:scan hit-regex line)
	  (cl-ppcre:regex-replace del-regex line "" )
	  nil)))

(defun eml2csv-small ()
  (with-open-file (out "result.csv" :direction :output :if-exists :supersede)
    (mapc 
     (lambda (x) (csv-parser:write-csv-line out (read-txt-mail x)))
     (directory "./*.txt"))))

