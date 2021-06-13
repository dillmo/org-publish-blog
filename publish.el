;;; publish.el --- Description -*- lexical-binding: t; -*-
;;
;; Copyright (C) 2021 Dillon Morse
;;
;; Author: Dillon Morse <https://github.com/dillon>
;; Maintainer: Dillon Morse <dillon@inoffensiveandwarm.com>
;; Created: June 13, 2021
;; Modified: June 13, 2021
;; Version: 0.0.1
;; Keywords: Symbol’s value as variable is void: finder-known-keywords
;; Homepage: https://github.com/dillon/publish
;; Package-Requires: ((emacs "24.3"))
;;
;; This file is not part of GNU Emacs.
;;
;;; Commentary:
;;
;;  Description
;;
;;; Code:

(require 'ox-publish)

; Define custom properties for org files
(org-export-define-derived-backend 'my-html 'html
  :options-alist '((:description "DESCRIPTION" nil nil t)))

(defun me/org-sitemap-format-entry (entry _style project)
  "Format posts published in the index page.
ENTRY: file-name
PROJECT:"
  (format "[[file:%s][%s]]
#+html: <p class=\"entry-description\">%s</p>"
          entry
          (org-publish-find-title entry project)
          (org-element-interpret-data
           (org-publish-find-property entry :description project 'my-html))))

(setq org-publish-project-alist
      '(("org-notes"
         :base-directory "~/src/blog/org/"
         :base-extension "org"
         :publishing-directory "~/src/blog/public_html/"
         :recursive t
         :publishing-function org-html-publish-to-html
         :headline-levels 4
         :auto-preamble t
         :auto-sitemap t
         :sitemap-filename "index.org"
         :sitemap-title "Inoffensive and Warm"
         :sitemap-format-entry me/org-sitemap-format-entry
         :html-head "<link rel=\"stylesheet\" type=\"text/css\" href=\"css/style.css\" />")

        ("org-static"
         :base-directory "~/src/blog/org/"
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|ogg\\|swf"
         :publishing-directory "~/src/blog/public_html/"
         :recursive t
         :publishing-function org-publish-attachment)

        ("org" :components ("org-notes" "org-static"))))

(provide 'publish)
;;; publish.el ends here
