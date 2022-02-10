# Enviar mensaje de notificación a Telegram cuando realiza copias de seguridad.

Este git sirve para realizar copias de seguridad de nuestros contenedores de docker o de cualquier carpeta/archivos.

Para poder recibir los mensajes en el Telegram, debes obtener el Token y chat_id de tu bot de telegram, puedes solicitarlos aquí desde la App de Telegram:
- Bot token: https://t.me/botfather
- Chat_ID: https://t.me/myidbot

![alt text](https://github.com/JuanRodenas/Backup/blob/main/hellotelegram.png)

Empezamos a instalar el bot de inicio. Para que funcione necesita permisos, por lo que instalar en el usuario ROOT:
## INSTALAR LOS PAQUETES Y ACTUALIZAR EL SISTEMA.
~~~
sudo apt update
sudo apt upgrade -y
sudo apt curl -y
~~~
<sup>**Si no estamos en usuario root, usamos `sudo` delante**.</sup>

## COPIA DE SGURIDAD DE ARCHIVOS.
Para realizar una copia de seguridad de archivos utilizaremos la opción **`TAR`** de linux. **`tar`** es un programa de archivo diseñado para almacenar múltiples archivos en un único fichero (un archivo), y para manipular dichos archivos.
<p>Todas las variables siguentes puedes consultarlas en la página man de linux <a href="https://man7.org/linux/man-pages/man1/tar.1.html">página man tar</a>. </p>

#### ALGUNAS VARIABLES:
**Modo de operación**
* c --> indica que estamos creando un empaquetado tar.
* v --> indica que se trabaje en modo verbose, o lo que es lo mismo, que tar mostrará qué está haciendo en pantalla.
* z --> comprime el fichero backup con gzip para hacerlo más pequeño
* f /fichero --> precede al nombre del fichero /fichero donde vamos a guardar el backup.
* P --> para preservar el path absoluto del recurso guardado.
* x --> Extrae, y descomprime si se da el caso, los directirios y archivos que se encuentren dentro del fichero.tar específico
* t --> Listar el contenido de un archivo. Cuando se dan, especifican los nombres de los miembros a listar.

**Modificadores de la operación**
* -G, --incremental
* -g, --listed-incremental=FILE --> Handle new GNU-format incremental backups.
* -T --> nos permite incluir un fichero en el que especificar una lista de directorios de los que hacer backup.
* -X --> Exluye archivos o carpetas a realizar backup.
  
### Preparación archivos
Para ello lo primero que hacemos es crear una carpeta donde se almacenara la copia, la llamaremos backup. También podemos montar un disco externo y montar ahí la carpeta.
~~~
mkdir /backup
~~~
Si has elegido la variable `-T`:
La opción -T de tar nos permite incluir un fichero en el que especificar una lista de directorios de los que hacer backup. Pongamos por ejemplo que tengo un fichero llamado lista-backup.txt en el que incluyo dicha lista con los directorios del sistema que quiero guardar. La inclusión es recursiva, por lo que se tienen en cuenta los subdirectorios por debajo de los que especificamos:
<div><div id="highlighter_815837" class="syntaxhighlighter nogutter  plain"><table cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="code"><div class="container"><div class="line number1 index0 alt2"><code class="plain plain">[root@$(user)-pc ~]# cat lista-backup.txt</code></div><div class="line number2 index1 alt1"><code class="plain plain">/root</code></div><div class="line number3 index2 alt2"><code class="plain plain">/home/$(user)/Documents</code></div><div class="line number4 index3 alt1"><code class="plain plain">/home/$(user)/Pictures</code></div><div class="line number5 index4 alt2"><code class="plain plain">/home/$(user)/scripts</code></div><div class="line number6 index5 alt1"><code class="plain plain">/etc</code></div><div class="line number7 index6 alt2"><code class="plain plain">/var/log</code></div><div class="line number8 index7 alt1"><code class="plain plain">/var/spool</code></div><div class="line number9 index8 alt2"><code class="plain plain">/var/mail </code></div></div></td></tr></tbody></table></div></div>
Ahora podríamos lanzar tar de la siguiente manera guardando en backup-sistema.tar.gz todo aquello que especificamos en la lista:
<div id="highlighter_915206" class="syntaxhighlighter nogutter  bash"><table cellspacing="0" cellpadding="0" border="0"><tbody><tr><td class="code"><div class="container"><div class="line number1 index0 alt2"><code class="bash functions">tar zPpcf backup-sistema.tar.gz -T lista-backup.txt</code></div></div></td></tr></tbody></table></div>
  
## COPIA DE SGURIDAD DE ARCHIVOS.
Una vez preparados los archivos con sus variables, podemos escoger que tipo de copia.
* Copia de contenedores docker: <a href="https://man7.org/linux/man-pages/man1/tar.1.html">docker</a>.
* Copia de contenedores docker o archivos y enviarlos a otro equipo/disco duro: <a href="https://github.com/JuanRodenas/Backup/blob/main/backupother.sh">backup send</a>.
* Copia del sistema: <a href="https://github.com/JuanRodenas/Backup/blob/main/backupsystem.sh">system</a>.

<sup>**Cuando se introducen las variables a ejecutar, si no estamos en usuario root, usamos `sudo` delante de los comandos.**</sup>

Todos los scripts tienen una línea con find que nos permite borrar copias de `X` tiempo.
#### Edita el script backup.sh, para añadir tu token de bot, y tu chat_id
Este script realiza el backup y lo envía a otra carpeta.
Descargar el script [script backup.sh](https://github.com/JuanRodenas/Backup/blob/main/backup.sh)
Y modicamos lo siguiente:
* Cambiar el `TOKEN_BOT` de tu bot de telegram.
* Cambiar el `TOKEN_ID` de tu chat bot de telegram.
* Cambiar las variables del script de las rutas de origen y destino, ejemplo de tar: tar -cvzf `/destino/`nombre.tar.gz `/origen`

#### Edita el script backupother.sh, para añadir tu token de bot, y tu chat_id
Este script realiza el backup y lo envía a otra máquina. Utilizaremos SPC, la conexión está cifrada.
Descargar el script [script backupother.sh](https://github.com/JuanRodenas/Backup/blob/main/backupother.sh)
Y modicamos lo siguiente:
* Cambiar el `TOKEN_BOT` de tu bot de telegram.
* Cambiar el `TOKEN_ID` de tu chat bot de telegram.
* Cambiar las variables del script de las rutas de origen y destino, ejemplo de tar: tar -cvzf `/destino/`nombre.tar.gz `/origen`

#### Edita el script backupsystem.sh, para añadir tu token de bot, y tu chat_id
Este script realiza el backup y lo envía a otra carpeta.
Descargar el script [script backupsystem.sh](https://github.com/JuanRodenas/Backup/blob/main/backupsystem.sh)
Y modicamos lo siguiente:
* Cambiar el `TOKEN_BOT` de tu bot de telegram.
* Cambiar el `TOKEN_ID` de tu chat bot de telegram.
* Cambiar las variables del script de las rutas de origen y destino, ejemplo de tar: tar -cvzf `/destino/`nombre.tar.gz `/origen`

### Asigna los permisos a+x
Cambiar el `.sh` y la ruta donde esté el archivo.
~~~
chmod a+x /root/scripts/backup.sh
~~~
<sup>**Si no estamos en usuario root, usamos `sudo` delante**.</sup>
### Agregamos al cron las siguientes lineas para que se ejecuten
Abrimos el cron
~~~
crontab -e
~~~
Y añadimos las líneas, el cron los ejecutará cada día que hayamos elegido.
~~~
00 23 1,15 * * /root/scripts/backup.sh
~~~

#### Ejemplos
| Tiempo | Comando | Description |
| :-- | :-- | :-- |
| Cada 15 de mes | 00 23 15 * * /root/scripts/backup.sh | Cada 15 de mes a las 23h |
| Cada 1 y 15 de mes | 00 23 1,15 * * /root/scripts/backup.sh | Cada 1 y 15 de mes a las 23h |
| Cada Lunes a las 7 de la mañana | 0 19 * * mon /root/scripts/backup.sh  | - |
| En los meses seleccionados | * * * feb,jun,oct * /root/scripts/backup.sh  | - |
| Diariamente | @daily /root/scripts/backup.sh  | Todos los días a las 12 de la noche: 0 0 * * * |
| Cada semana | @weekly /root/scripts/backup.sh | Ejecutar una vez a la semana: 0 0 * * 0 |
| Cada mes | @monthly /root/scripts/backup.sh | Ejecutar una vez al mes: 0 0 1 * * |

Y reinciamos el cron:
~~~
service cron restart 
~~~
El funcionamiento es sencillo, cada día 1 y 15 de cada mes, se realizará una copia de seguridad.

## Restaurar backup
Si queremos recuperar el backup de la config, desempaquetamos el .tar.gz del volumen en el directorio del contenedor, antes de desplegar la imagen.
Primero nos situamos en la carpeta del backup a recuperar y desempaquetamos el`tar.gz` en el destino a recuperar. Si los archivos a recuperar es un contenedor docker, una vez recuperado el backup, desplegamos el docker-compose.yml y cuando la despliegas esta todo como estaba antes.
* Para descomprimir un archivo `.tar.gz`.:
~~~
tar -xvzf archive.tar.gz
~~~
* Para descomprimir un archivo `.tar.gz` en un directorio específico:
~~~
tar -xvzf archive.tar.gz -C /home/docker/files
~~~
<sup>**Si no estamos en usuario root, usamos `sudo` delante de tar o zip**.</sup>

### Ready!
