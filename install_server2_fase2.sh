#!/bin/bash


#################################################
#                                               #
#                                               #
#INSTALACIÓN GLUSTERFS                          #
#                                               #
#                                               #
#################################################


#Ahora procedemos a configurar el anillo de confianza entre ambos servidores de GLUSTERFS.
sudo gluster peer probe piloto01


#Iremos a la carpeta /etc/init.d/
cd /etc/init.d/


#DESCARGAMOS ARCHIVOS DE CONFIGURACIÓN
sudo wget https://github.com/jucacapopo/glusterfs-mount/archive/master.zip


#DESCOMPRIMIMOS ARCHIVO ZIP
sudo unzip -j master.zip


#Dar permisos de ejecución al script
sudo chmod +x /etc/init.d/glusterfs-mount


#Configuramos que se ejecute este script en el inicio de sistema
sudo update-rc.d glusterfs-mount defaults


#Arrancamos script sin reiniciar el sistema
sudo /etc/init.d/glusterfs-mount start

#Eliminamos master.zip
sudo rm master.zip


exit
