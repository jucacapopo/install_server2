#!/bin/bash


#################################################
#                                               #
#                                               #
#INSTALACIÓN BIND9                              #
#                                               #
#                                               #
#################################################


#Actualizamos repositorios de paquetes 
sudo apt update -y


#Instalamos bind9 y utilidades 
sudo apt install -y bind9 bind9utils bind9-doc dnsutils

 
#Nos movemos a la carpeta de archivos de configuración de bind
cd /etc/bind/


#Cambiamos nombre archivos
sudo mv named.conf named.conf.bck
sudo mv named.conf.local named.conf.local.bck


#DESCARGAMOS ARCHIVOS DE CONFIGURACIÓN
sudo wget https://github.com/jucacapopo/bind9/archive/master.zip


#DESCARGAMOS ZIP
sudo apt-get install zip unzip -y


#DESCOMPRIMIMOS ARCHIVO ZIP
sudo unzip -j master.zip


#CREAR CARPETA DE ARCHIVOS LOG
sudo mkdir /var/log/named/


#CAMBIAMOS PROPIETARIO ARCHIVOS LOG
sudo chown bind -R /var/log/named/


#Iniciar servidor DNS
sudo systemctl start bind9


#Reiniciar servidor DNS
sudo systemctl restart bind9


#Incluimos en inicio de sistema
sudo systemctl enable bind9


#COMPROBAR INSTALACIÓN
nslookup movistarplus.es


#Eliminamos master.zip
sudo rm master.zip


#FIN INSTALACIÓN BIND9 (SERVIDOR DNS)


#################################################
#                                               #
#                                               #
#INSTALACIÓN GLUSTERFS                          #
#                                               #
#                                               #
#################################################


#EDITAMOS ARCHIVO HOSTS 
sudo echo "127.0.0.1       piloto02" >> /etc/hosts
sudo echo "10.246.125.2       piloto01" >> /etc/hosts


#CREAMOS EL VOLUMEN LÓGICO
sudo lvcreate -n video -L 2T ubuntu-vg


#CREAMOS SISTEMA DE ARCHIVOS EXT4
sudo mkfs.ext4 /dev/ubuntu-vg/video


#CREAMOS EL PUNTO DE MONTAJE DE NUESTRO NUEVO VOLUMEN LÓGICO
sudo mkdir -p /glusterfs/video


#AÑADIMOS NUESTRO PUNTO DE MONTAJE A /etc/fstab
sudo echo "/dev/ubuntu-vg/video /glusterfs/video ext4 defaults 0 0" >> /etc/fstab


#MONTAMOS /etc/fstab sin reiniciar
sudo mount -a


#INSTALAMOS GLUSTERFS 
sudo apt install glusterfs-server glusterfs-client glusterfs-common -y


#INICIAMOS SERVICIO GLUSTERD
sudo systemctl start glusterd


#INCLUIMOS EN INICIO
sudo systemctl enable glusterd


#FIN PRIMERA PARTE


#################################################
#                                               #
#                                               #
#INSTALACIÓN KEEPALIVED                         #
#                                               #
#                                               #
#################################################


#INSTALAMOS KEEPALIVED
sudo apt-get install -y keepalived


#Nos movemos a la carpeta de archivos de configuración de bind
cd /etc/keepalived/


#DESCARGAMOS ARCHIVO DE CONFIGURACIÓN
sudo wget https://github.com/jucacapopo/keepalived_server_2/archive/master.zip


#DESCOMPRIMIMOS ARCHIVO ZIP
sudo unzip -j master.zip


#INICIAMOS KEEPALIVED
sudo systemctl start keepalived.service


#INCLUIMOS KEEPALIVED EN EL ARRANQUE DEL SISTEMA
sudo systemctl enable keepalived.service


#Eliminamos master.zip
sudo rm master.zip


#FIN INSTALACIÓN


#################################################
#                                               #
#                                               #
#INSTALACIÓN NGINX                              #
#                                               #
#                                               #
#################################################


#INSTALAMOS NGINX
sudo apt install nginx -y


#Nos movemos a la carpeta de archivos de configuración de bind
cd /etc/nginx/sites-available/


#Cambiamos nombre archivo default
sudo mv default default.bck


#DESCARGAMOS ARCHIVO DE CONFIGURACIÓN
sudo wget https://github.com/jucacapopo/nginx/archive/master.zip


#DESCOMPRIMIMOS ARCHIVO ZIP
sudo unzip -j master.zip


#INICIAMOS NUESTRO SERVIDOR WEB NGINX
sudo systemctl restart nginx


#INCLUIMOS EN ARRANQUE DEL SISTEMA
sudo systemctl enable nginx


#CREAMOS CARPETA
sudo mkdir -p /var/www/media


#Eliminamos master.zip
sudo rm master.zip


#FIN INSTALACIÓN NGINX


#################################################
#                                               #
#                                               #
#INSTALACIÓN VARNISH                            #
#                                               #
#                                               #
#################################################


#INSTALAMOS VARNISH
sudo apt install varnish -y


#Nos movemos a la carpeta de archivos de configuración de bind
cd /etc/varnish/


#Cambiamos nombre archivo
sudo mv default.vcl default.vcl.bck


#DESCARGAMOS ARCHIVOS DE CONFIGURACIÓN
sudo wget https://github.com/jucacapopo/varnish/archive/master.zip


#DESCOMPRIMIMOS ARCHIVO ZIP
sudo unzip -j master.zip


#CAMBIAMOS NOMBRE DE ARCHIVO /etc/default/varnish
sudo mv /etc/default/varnish /etc/default/varnish.bck


#Movemos archivo /etc/default/varnish
sudo mv varnish /etc/default/


#CAMBIAMOS NOMBRE DE ARCHIVO /lib/systemd/system/varnish.service
sudo mv /lib/systemd/system/varnish.service /lib/systemd/system/varnish.service.bck


#Movemos archivo /lib/systemd/system/varnish.service
sudo mv varnish.service /lib/systemd/system/


#INICIAMOS VARNISH
sudo systemctl start varnish


#REINICIAMOS VARNISH
sudo systemctl restart varnish


#HABILITAMOS VARNISH EN INICIO DE SISTEMA
sudo systemctl enable varnish


#FIN INSTALACIÓN VARNISH


exit
