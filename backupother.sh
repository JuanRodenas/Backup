#! /bin/bash
# Script de Juan Rodenas Sánchez
# Script copias de seguridad regulares

# Accedemos a la carpeta docker
cd /home/jrodenas/docker/

# Realizamos copia de seguridad adguard
docker stop adguard && sleep 5 && sudo tar -cvzf /backup/adguard_$(date +%A-%d-%m-%Y).tar.gz adguard && docker start adguard && rm adguard_$(date +%A-%d-%m-%Y).tar.gz
# Enviamos a servidor
scp user@1.2.3.4:/ruta/servidor/remoto/archivo.tar.gz adguard_$(date +%A-%d-%m-%Y).tar.gz

# requeriments:
TOKEN="YOUR_TOKEN_BOT"
ID="YOUR_TOKEN_CHAT"
URL="https://api.telegram.org/bot$TOKEN/sendMessage"
DNS="1.1.1.1"
servidor=$(hostname)
MSG="\U1F4BE Nasacloud informa \U2139"
IP=`w -h | awk '{print""$3}'`
mensaje="\U2139 Nasacloud informa que ha realizado la copia de seguridad mensual y se han eliminado los backups \U1F5AB más antiguos del servidor"

# Envío del mensaje
/usr/bin/ping -c2 $DNS > /dev/null 2>&1
if [ $? -ne 0 ]
then
        exit 0
else
        curl -s -X POST $URL \
        -d chat_id=$ID \
        -d parse_mode=HTML \
        -d text="$(printf "$MSG<code>\n\t\t- Host: $servidor\n\t\t- IP: $IP\n\t\t- mensaje: $mensaje</code>")" \ 
                > /dev/null 2>&1
        exit 0
fi
