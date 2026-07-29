##
#  Usando el paquete "abrirR"
#  Por Víctor González Fernández
#  2026
#
#  El Script "abrirR.R" crea varias funciones que facilitan 
#  la importación de datos a R. Ha sido preparado para el curso de 
#  Análisis Cuantitativo en Arqueología en la Universidad Externado
#  de Colombia.
#  
#  Para descargar el Script a su carpeta de trabajo use el comando:
download.file("https://raw.githubusercontent.com/vigonfer/arqueocuant/refs/heads/master/R_abrir.R","abrirR.R", mode="wb")
#  Solo se requiere descargar el Script una vez. 
#
#  Cargue el Script con el comando:
source("abrirR.R", encoding="Latin1")
#
#  Las funciones disponibles son:
# 
#  Nombre    Función                                Sintaxis	
#  xls       Importar archivos de Excel             datos <- xls()
#  csv       Importar archivos delimitados por ","  datos <- csv()
#  csv2      Importar archivos delimitados por ";"  datos <- csv2() 
#  tsv       Importar archivos delimitados por TAB  datos <- csv2()
#  rds       Importar archivos de datos de R        datos <- csv2()
#  ver       Visualizar un archivo                  ver()
#  scr       Abrir Script R codificado en Latin-1   scr()
#  scr2      Abrir Script R codificado en UTF-8     scr2() 
#
##
