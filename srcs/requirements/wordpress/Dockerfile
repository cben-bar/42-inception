FROM debian:buster

RUN 	apt-get update -y \
&&		apt-get upgrade -y
	
RUN		apt-get install curl less -y
#	curl ==> transfert des données en utilisant divers protocoles réseau, notamment HTTP et HTTPS.
#	Svt pour télécharger des fichiers à partir d'URL.
#	less ==> visualisation de fichiers texte.

RUN		apt-get install -y php

RUN 	apt-get install -y php-fpm
#	PHP-FPM (PHP FastCGI Process Manager) est un processus de gestion de processus PHP pour les serveurs web.
#	Il sert de passerelle entre le serveur web (comme Apache ou Nginx) et l'interpréteur PHP.
#	Il peut:	-précharger les scripts PHP en mémoire et maintenir un pool de processus prêts à traiter les requêtes,
#				ce qui permet d'améliorer les performances globales.
#				-isoler et gérer des processus : PHP-FPM attribue un processus distinct à chaque demande PHP,
#				assurant l'isolation entre les requêtes et évitant les problèmes de concurrence.

RUN		apt-get install -y php-mysql \
&&		apt-get install -y php-mysqli
#	Le paquet php-mysql permet à PHP de se connecter et d'interagir avec des bases de données MySQL.
#	Il est utilisé par WordPress pour communiquer avec la base de données MySQL.

#	L'extension php-mysqli est une version améliorée de l'extension php-mysql.
#	Elle fournit une interface améliorée pour interagir avec des bases de données MySQL en utilisant la bibliothèque MySQLi de PHP.

RUN		apt-get install -y mariadb-client
#	Le paquet mariadb-client fournit l'outil en ligne de commande permettant d'établir une connexion client à un serveur MariaDB
#	(système de gestion de base de données) depuis le conteneur Docker.

RUN 	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
&&		chmod +x wp-cli.phar \
&&		mv wp-cli.phar /usr/local/bin/wp
#	wp-cli.phar est l'exécutable de WP-CLI, qui permet d'interagir avec les installations WordPress en ligne de commande.
#	Rend le fichier exécutable.
#	Il devient accessible depuis n'importe quel endroit dans le conteneur Docker depuis ce répertoire. 

RUN		mkdir -p /var/www/html/wordpress

EXPOSE 	9000

COPY	/tools/entrypoint.sh /tmp
#	Le fichier entrypoint.sh est copié depuis le répertoire /tools de l'hôte vers le répertoire /tmp de l'image en construction.

# COPY OUR CONF FILE IN OUR CONTAINER
COPY	/tools/www.conf /etc/php/7.3/fpm/pool.d/www.conf
#	Idem pour www.conf, copié dans /etc/php/7.3/fpm/pool.d/ de límage en constrction.

RUN apt-get install -y dumb-init
#	Processus d'initialisation conçu pour résoudre les problèmes liés à l'exécution de conteneurs Linux (cf dockerfile mariadb).

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
#	Définit l'entrée principale (entrypoint) du conteneur Docker. L'option -- spécifie la fin des arguments de l'entrée principale.

CMD ["sh", "/tmp/entrypoint.sh" ]
#	Cmd par défaut. Elle exécute le script.

#	Configure le comportement initial du conteneur et exécute le script entrypoint.sh au démarrage du conteneur.