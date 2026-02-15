#!/usr/bin/env bash

set -o errexit  # exit on error

pip install -r requirements.txt

python manage.py collectstatic --no-input
python manage.py migrate

python populate_catalog.py

python manage.py shell -c "from django.contrib.auth import get_user_model; User = get_user_model(); User.objects.filter(username='alumnodb').exists() or User.objects.create_superuser('alumnodb', 'alumnodb@example.com', 'alumnodb')"
