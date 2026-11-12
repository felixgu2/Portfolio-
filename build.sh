#!/bin/sh
# Builds the site from src/portfolio.html:
#   portfolio.html - the page body, published as the Claude artifact
#   index.html     - full standalone page for GitHub Pages / any host
# The resume is not published on the site (it contains phone numbers).
set -e
cd "$(dirname "$0")"
cp src/portfolio.html portfolio.html
{
  printf '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n</head>\n<body>\n'
  cat portfolio.html
  printf '\n</body>\n</html>\n'
} > index.html
echo "built portfolio.html and index.html"
