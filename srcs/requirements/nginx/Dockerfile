FROM debian:buster

RUN apt-get update -y
RUN apt-get upgrade -y

RUN apt-get install -y nginx

RUN apt-get install -y openssl

RUN openssl req -x509 -newkey rsa:2048 -nodes -subj /C=FR \
	-keyout /etc/ssl/cben-bar.42.fr.key -out /etc/ssl/cben-bar.42.fr.crt;
# 	req: génère des requêtes et certificats SSL.
# 	-x509: génère un certificat auto-signé.
# 	-newkey rsa:2048: la clé privée RSA de 2048 bits doit être générée pour le certificat.
# 	nodes: indique de ne pas crypter la clé.
#	-subj /C=FR: paramètre de la commande req qui indique que le pays.

# 	-keyout /etc/...: paramètre de la commande req qui indique le chemin et le nom du fichier où la clé privée générée sera enregistrée.
# 	out /etc/...: paramètre de la commande req qui indique le chemin et le nom du fichier où le certificat auto-signé sera enregistré.


COPY	/conf/nginx.conf /etc/nginx/sites-available/cben-bar.42.fr.conf
RUN		ln -s /etc/nginx/sites-available/cben-bar.42.fr.conf /etc/nginx/sites-enabled/cben-bar.42.fr.conf
# 	copie le fichier file nginx.conf dans /etc/nginx/sites-available.
# 	crée un lien symbolique entre sites available et sites enabled.

EXPOSE 443

RUN apt-get install -y dumb-init

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
#	dunb-init: cf Dockerfile de mariadb.
#	Définit le point d'entrée du conteneur.

CMD ["nginx", "-g", "daemon off;"]	

#	"ENTRYPOINT" remplace toute instruction "CMD" précédente.
#	Si les 2 sont présentes l'instruction "CMD" sera utilisée pour fournir des arguments par défaut à l'instruction "ENTRYPOINT".