#!/usr/bin/env bash
# exit on error
set -o errexit

#echo dephook
#echo testing > dephook.txt
#echo catdephook
#cat dephook.txt

if [ "$IS_PREVIEW_ENVIRONMENT" = "YES" ]; then
  echo "In preview environment. Performing preview-specific actions."
  export DJANGO_SUPERUSER_EMAIL="juanignaciosl+preview@cavela.com"
  export DJANGO_SUPERUSER_PASSWORD="preview"
  export DJANGO_SUPERUSER_USERNAME="preview"

  #python manage.py preview_environment_seed
else
  echo "Not in preview environment. Performing standard action."
fi
