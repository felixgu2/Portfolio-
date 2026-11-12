#!/bin/sh
# Builds the site from src/portfolio.html:
#   portfolio.html - the page body (also used for the Claude preview)
#   index.html     - full standalone page for Render / any host
# Optional: set SITE_URL (e.g. https://your-site.onrender.com) so link
# previews on LinkedIn, Slack and email use a full image address.
# The resume is not published on the site (it contains phone numbers).
set -e
cd "$(dirname "$0")"
SITE_URL="${SITE_URL%/}"
sed "s|__SITE_URL__|$SITE_URL|g" src/portfolio.html > portfolio.html
{
  printf '<!doctype html>\n<html lang="en">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n'
  awk '/^<style>/{exit} {print}' portfolio.html          # title, meta tags, icon, fonts
  printf '</head>\n<body>\n'
  awk 'f || /^<style>/ {f=1; print}' portfolio.html     # styles, page, scripts
  printf '\n</body>\n</html>\n'
} > index.html
echo "built portfolio.html and index.html"
