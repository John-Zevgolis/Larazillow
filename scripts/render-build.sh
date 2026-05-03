set -e

echo "📦 Installing Composer dependencies..."
composer install --no-dev --no-interaction --prefer-dist

echo "📦 Installing NPM dependencies & building assets..."
npm install
npm run build

echo "🧹 Clearing and caching configuration..."
php artisan config:cache
php artisan route:cache
php artisan view:cache

echo "🗄️ Running migrations..."
php artisan migrate --force

echo "🔗 Linking storage..."
php artisan storage:link
