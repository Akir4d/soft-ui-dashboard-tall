#!/bin/bash
set -eu
set -o pipefail
echo "Deploy script started"
git fetch --all
php artisan down
git reset --hard origin/main
composer install --no-interaction #install php part
php artisan migrate:fresh --seed
php artisan optimize:clear
php artisan view:clear
php artisan route:clear
php artisan config:clear
php artisan view:cache
php artisan route:cache
php artisan storage:link
php artisan up
nvm use 16
npm install
npm run build
echo "Deploy script finished execution"
