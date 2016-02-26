
;;; ox-jira-test.el --- tests for ox-jira.el

;;; Author: Stig Brautaset <stig@brautaset.org>

;; This file is NOT part of GNU Emacs.

;;; Copyright (C) 2016 Stig Brautaset

;; Permission is hereby granted, free of charge, to any person obtaining a
;; copy of this software and associated documentation files (the "Software"),
;; to deal in the Software without restriction, including without limitation
;; the rights to use, copy, modify, merge, publish, distribute, sublicense,
;; and/or sell copies of the Software, and to permit persons to whom the
;; Software is furnished to do so, subject to the following conditions:

;; The above copyright notice and this permission notice shall be included in
;; all copies or substantial portions of the Software.

;; THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
;; IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
;; FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
;; AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
;; LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
;; FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
;; DEALINGS IN THE SOFTWARE.

;;; Code:

(require 'ert)
(require 'ox)
(require 'ox-jira)

(ert-deftest ox-jira-test/hello-world ()
  (should (equal "hello world\n" (org-export-string-as "hello world" 'jira))))

(ert-deftest ox-jira-test/text-effects ()
  (should (equal "this is *strong* text\n" (org-export-string-as "this is *strong* text" 'jira)))
  (should (equal "this is _emphasised_ text\n" (org-export-string-as "this is /emphasised/ text" 'jira)))
  (should (equal "this is +underlined+ text\n" (org-export-string-as "this is _underlined_ text" 'jira)))
  (should (equal "this is {{inline code}}\n" (org-export-string-as "this is ~inline code~" 'jira)))
  (should (equal "this is {{verbatim}} text\n" (org-export-string-as "this is =verbatim= text" 'jira))))

(ert-deftest ox-jira-test/quotations ()
  (should (equal "{quote}
This is a quote.

It can have multiple paragraphs.
{quote}
" (org-export-string-as "
#+BEGIN_QUOTE
This is a quote.

It can have multiple paragraphs.
#+END_QUOTE" 'jira)))

  (should (equal "{quote}
This is a quote with _emphasis_.
{quote}
" (org-export-string-as "
#+begin_quote
This is a quote with /emphasis/.
#+end_quote" 'jira))))

(ert-deftest ox-jira-test/headlines ()
  (should (equal "h1. top level
h2. second level
h3. third level
" (org-export-string-as "* top level
** second level
*** third level" 'jira))))

(ert-deftest ox-jira-test/paragraphs ()
  (should (equal "fi fo fa fum\n" (org-export-string-as "fi
,fo
,fa
,fum" 'jira))))

(ert-deftest ox-jira-test/unordered-lists()
  (should (equal "- fi
- fo
- fa
- fum
" (org-export-string-as "- fi
- fo
- fa
- fum" 'jira))))

(ert-deftest ox-jira-test/ordered-lists()
  (should (equal "# fi
# fo
# fa
# fum
" (org-export-string-as "1. fi
2. fo
3. fa
3. fum" 'jira))))

(ert-deftest ox-jira-test/unordered-list-with-checkboxes()
  (should (equal "- {{[ ]}} fi
- {{[X]}} fo
" (org-export-string-as "- [ ] fi
- [X] fo" 'jira))))

(ert-deftest ox-jira-test/src-blocks ()
  (should (equal "{code:sh}
echo hello
# echo world
{code}
" (org-export-string-as "#+begin_src sh
     echo hello
     # echo world
     #+end_src
" 'jira))))

(ert-deftest ox-jira-test/example-blocks ()
  (should (equal "{noformat}
stuff that should
 not be
formatted
{noformat}
" (org-export-string-as "#+begin_example
stuff that should
 not be
formatted
#+end_example
" 'jira))))

(provide 'ox-jira-test)

;;; ox-jira.el-test.el ends here
