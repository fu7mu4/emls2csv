emls2csv
========

Emls2csv is a converter eml text files in the current directory to a csv file "result.csv". 
This is written by Clozure CL (Common Lisp) with quicklisp.
Clozure CL can create executable binary on each platforms Linux, Mac OS X and Windows.

Emls2csv は現在フォルダの中の eml 形式のテキストファイルを csv 形式の [result.csv]に変換します。
これは、Common LispのClozure CLと quicklispで作成されています。
Clozure CLは Linux, Mac OS X, Windowsのそれぞれの環境で実行形式を作成できます。

Requirements
============

Clozure CL
cl-ppcre
csv-parser


How To Create Binary
====================

assumed that you've installed quicklisp. すでに、quicklispが導入されていると仮定しています。

; load library by quicklisp              quicklispでライブラリをロードします。
(ql:quickload :cl-ppcre)
(ql:quickload :csv-parser)

; load this lisp code                    このlispコードをロードします。
(load "eml2csv.lisp")

; create a windows binary executable by ccl  ClozureCLでWindows用バイナリを作成します。
(ccl:save-application "eml2csv.exe" :toplevel-function #'eml2csv-small :prepend-kernel t )

How To Use Binary
=================

1 Put eml2csv.exe on the folder that has eml text files.
2 Click this exe file to run.
3 You'll find a "result.csv" in that directory.

1 eml2csv.exeを eml形式のテキストファイルのあるフォルダに置きます。
2 このバイナリをクリックして実行します。
3 そのフォルダに 「result.csv」というファイルが生成されているはずです。
