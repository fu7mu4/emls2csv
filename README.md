emls2csv
========

Emls2csv is a converter eml text files in the current directory to a csv file "result.csv". 
This is written by Clozure CL (Common Lisp) with quicklisp.
Clozure CL can create executable binary on each platforms Linux, Mac OS X and Windows.

Requirements
============

Clozure CL
cl-ppcre
csv-parser

How To Create Binary
====================

assumed that you've installed quicklisp.

; load library by quicklisp
(ql:quickload :cl-ppcre)
(ql:quickload :csv-parser)

; load this lisp code
(load "eml2csv.lisp")

; create a windows binary executable by ccl 
(ccl:save-application "eml2csv.exe" :toplevel-function #'eml2csv-small :prepend-kernel t )

How To Use Binary
=================

1 Put eml2csv.exe on the folder that has eml text files.
2 Click this exe file to run.
3 You'll find a "result.csv" in that directory.
