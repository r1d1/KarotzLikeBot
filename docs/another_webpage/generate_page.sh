#!/bin/bash

echo "Converting $1 ..."

#pandoc -s -f markdown_github -t html -o index.html index.md --css ./github_css/github.css --wrap=preserve #--toc
pandoc -s -f markdown -t html -o index.html index.md --css ./github_css/github.css --wrap=preserve #--toc 

