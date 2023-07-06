FROM debian:buster

ARG DB_USER
ARG DB_DATABASE
ARG DB_USER_PASSWORD
ARG DB_ROOT_PASSWORD

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install -y mariadb-server

RUN mkdir -p /var/run/mysql
RUN chown -R mysql:mysql /var/run/mysql
#   Crée /var/run/mysql, l'option "-p"  crée les répertoires parents si nécessaire.
#   Change les propriétaires de ce répertoire en "mysql:mysql" pour assurer que les fichiers temporaires et les sockets
#   de MariaDB/MySQL ont les bonnes permissions lors de l'exécution du conteneur basé sur cette image.

RUN service mysql start \
&&  mysql -u root -e   "CREATE DATABASE IF NOT EXISTS $DB_DATABASE; \
                        ALTER USER 'root'@'localhost' IDENTIFIED BY '$DB_ROOT_PASSWORD'; \
                        GRANT ALL PRIVILEGES ON $DB_DATABASE.* TO '$DB_USER'@'%' IDENTIFIED BY '$DB_USER_PASSWORD'; \
                        FLUSH PRIVILEGES;"
#   démarre le service MySQL dans le conteneur.
#   L'option "-u root" pour se connecter en tant qu'utilisateur "root". (-u user)
#   L'option "-e" est utilisée pour spécifier une instruction SQL à exécuter. (-e enabled settings)

#   ALTER..: modifie le password de l'utilisateur root ('root'@'localhost') avec la valeur stockée dans la variable $DB_ROOT_PASSWORD.
#   La clause IDENTIFIED BY est utilisée pour définir le nouveau mot de passe.

#   GRANT..: Accorde tous les privilèges de $DB_DATABASE à $DB_USER.
#   Le symbole % dans '%' permet à l'utilisateur de se connecter depuis n'importe quel hôte.
#   L'utilisateur se voit attribuer le mot de passe stocké dans $DB_USER_PASSWORD.

#   FLUSH..: Recharge les privilèges MySQL pour que les modifs prennent effet immédiatement.

#   En résumé, la cmd:  -démarre le service MySQL
#                       -crée une base de données si elle n'existe pas
#                       -modifie le mot de passe de l'utilisateur root
#                       -accorde tous les privilèges sur la base de données à un utilisateur spécifique
#                       -recharge les privilèges pour appliquer les modifications.

COPY ./conf/mariadb.conf ./etc/mysql/mariadb.conf.d/50-server.cnf
#    Copie des fichiers/répertoires depuis l'hôte vers l'intérieur de l'image Docker en cours de construction.

EXPOSE 3306
#   le conteneur doit être accessible par le port 3306 ==> capable d'accepter les connexions entrantes sur ce port.

RUN apt-get install -y dumb-init
#   Dumb-init est un processus d'initialisation conçu pour résoudre les problèmes liés à l'exécution de conteneurs Linux,
#   améliorant ainsi la stabilité et la gestion des processus à l'intérieur des conteneurs
#   (intercepte les signaux et les transmet aux processus enfants. Garantit que les processus enfants sont correctement terminés lorsque
#   le conteneur est arrêté. Fermeture des descripteurs de fichiers ouverts, gestion de la fin du processus principal, etc..).

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
#   permet d'utiliser dumb-init comme le point d'entrée principal du conteneur.

CMD ["mysqld", "--bind-address=0.0.0.0"]
#   MariaDB/MySQL écoute les connexions sur toutes les interfaces réseau (0.0.0.0), permettant d'accepter les connexions externes.