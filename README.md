# Enviar mensaje de notificación a Telegram cuando realiza copias de seguridad.

Este git sirve para realizar copias de seguridad de nuestros contenedores de docker o de cualquier carpeta/archivos.

Para poder recibir los mensajes en el Telegram, debes obtener el Token y chat_id de tu bot de telegram, puedes solicitarlos aquí desde la App de Telegram:
- Bot token: https://t.me/botfather
- Chat_ID: https://t.me/myidbot

![alt text](https://github.com/JuanRodenas/Backup/blob/main/hellotelegram.png)

Empezamos a instalar el bot de inicio. Para que funcione necesita permisos, por lo que instalar en el usuario ROOT:
## Instalar los paquetes y actualizamos el sistema
~~~
sudo apt update
sudo apt upgrade -y
sudo apt curl -y
~~~
<sup>**Si no estamos en usuario root, usamos `sudo` delante**.</sup>

#### Edita el script backup.sh, para añadir tu token de bot, y tu chat_id
Este script realiza el backup y lo envía a otro disco duro.
Descargar el script [script backup.sh](https://github.com/JuanRodenas/Backup/blob/main/backup.sh)
Y modicamos lo siguiente:
~~~
TOKEN_BOT="YOUR_TOKEN_BOT"
TOKEN_ID="YOUR_TOKEN_CHAT"
~~~

#### Edita el script backupother.sh, para añadir tu token de bot, y tu chat_id
Este script realiza el backup y lo envía a otra máquina. Utilizaremos SPC, la conexión está cifrada.
Descargar el script [script backupother.sh](https://github.com/JuanRodenas/Backup/blob/main/backupother.sh)
Y modicamos lo siguiente:
~~~
TOKEN_BOT="YOUR_TOKEN_BOT"
TOKEN_ID="YOUR_TOKEN_CHAT"
~~~

### Asigna los permisos a+x
~~~
chmod a+x /root/scripts/backup.sh
chmod a+x /root/scripts/backupother.sh
~~~
<sup>**Si no estamos en usuario root, usamos `sudo` delante**.</sup>
### Agregamos al cron las siguientes lineas para que se ejecuten
Abrimos el cron
~~~
crontab -e
~~~
Y añadimos las líneas, el cron los ejecutará cada día que hayamos elegido.
~~~
00 23 1,15 * * /root/scripts/backup.sh >/dev/null 2>&1
30 23 1,15 * * /root/scripts/backupother.sh >/dev/null 2>&1
~~~
Y reinciamos el cron:
~~~
service cron restart 
~~~
El funcionamiento es sencillo, cada día 1 y 15 de cada mes, se realizará una copia de seguridad.
### Ready!
