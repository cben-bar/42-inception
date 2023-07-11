cd /var/www/html/wordpress

wp core download  --path="/var/www/html/wordpress" --allow-root
#   Download WordPress. ("wp" ==> WP-CLI ==> interface de ligne de commande pour WordPress).

wp config create --path="/var/www/html/wordpress" --allow-root --dbname=$DB_DATABASE --dbuser=$DB_USER --dbpass=$DB_USER_PASSWORD --dbhost=$DB_HOST --dbprefix=wp_
#   Crée un fichier de configuration WordPress avec les informations de connexion à la base de données.

wp core install --path="/var/www/html/wordpress" --allow-root --url=$DOMAIN_NAME --title="$WP_SITE_TITLE" --admin_user=$WP_ADMIN --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL
#   Installe WordPress.

wp plugin update --allow-root --all
wp user create --path="/var/www/html/wordpress" --allow-root $WP_USER $WP_USER_EMAIL --user_pass=$WP_USER_PASSWORD
#   MAJ tous les plugins WordPress installés sur le site.
#   Crée un nouvel utilisateur dans WordPress.

# GIVE PERMISSIONS TO GROUP AND USER WWW-DATA TO UPLOADS | -R EXECUTE ROOT
chown www-data:www-data /var/www/html/wordpress/wp-content/uploads -R
#   Donne les droits à lutilisateur et au groupe (www-data) au répertoire wp-content/uploads.
#   -R pr changer récursivement le propriétaire et le groupe de tous les fichiers et sous-répertoires à l'intérieur du répertoire wp-content/uploads.

# LAUNCH PHP-FPM
mkdir -p /run/php/
php-fpm7.3 -F
#   Crée le répertoire "/run/php/ s'il n'existe pas déjà.
#   Exécute php-fpm