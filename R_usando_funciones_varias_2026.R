##
#  Usando el paquete "funciones_varias"
#  Por Víctor González Fernández
#  2026
#
#  El Script "R_funciones_varias.R" crea varias funciones que facilitan el 
#  análisis de  datos. Ha sido preparado para el curso de Análisis 
#  cuantitativo en Arqueología en la Universidad Externado de Colombia, e 
#  implementa procedimientos descritos en el libro "Estadística para 
#  arqueólogos" (Drennan y González, 2019). 
#  
#  Para descargar el Script a su carpeta de trabajo use el comando:
download.file("https://raw.githubusercontent.com/vigonfer/arqueocuant/refs/heads/master/R_funciones_varias.R", 
"R_funciones_varias.R",mode="wb")
#  Solo se requiere descargar el Script una vez. 
#  Si el Script ya está descargado en su carpeta de trabajo, puede cargarlo. 
# 
#  Cargue el Script con el comando:
source("R_funciones_varias.R", encoding="UTF8")
#
#  Si cierra la sesión después de cargadas las funciones aceptando "guardar 
#  imagen de área de trabajo", estarán disponibles en la siguiente sesión.
#
#  Una forma alternativa de cargar directamente el Script es:
# source("http://vigonfer.tripod.com/R_Funciones_varias.txt", encoding="Latin1")
#
#  A continuación hay ejemplos del uso de las funciones varias, con 
#  las siguientes variables del conjunto "mtcars", incluido en R:
# mtcars$mpg  (millas por galón, variable numérica contínua)
# mtcars$am   (transmisión (0=Autom/1:Manual), var. categórica dicótoma)
# mtcars$gear (número de cambios adelante, variable categórica ordinal)
# mtcars$cyl  (número de cilindros, variable categórica ordinal)
# mtcars$qsec (tiempo-segundos-para recorrer 400 metros, numérica continua)
# mtcars$wt   (peso en libras*1000, numérica continua)	
#
#  Ejemplo de comando                   #  Descripción de la función
# ------------------------------------  # ----------------------------------  
lista()                                 # Función que presenta la lista de funciones
tallo(mtcars$mpg, scale=2)              # Tallo y hojas descendente
talloee(mtcars$mpg,mtcars$am,m=4)       # Tallo y hojas espalda con espalda descendente
with(mtcars,talloee(mpg,y=qsec,m=4))    # Tallo y hojas espalda con espalda descendente
Winsor(mtcars$mpg, pr=0.1)              # Winsorizar un lote
Trim(mtcars$mpg, pr=0.1)                # Recortar un lote
TrimSd(mtcars$mpg, pr=0.1)              # Calcular desviación estándar recortada
meanT(mtcars$mpg,pr=0.1)                # Calcular media recortada
DM(mtcars$mpg)                          # Calcular la dispersión media
centro(mtcars$mpg,mtcars$gear,0.1)      # Medidas de tendencia central
disper(mtcars$mpg,mtcars$gear,0.1)      # Medidas de dispersión
tabla.f(mtcars$cyl,mtcars$gear)         # Tabla de frecuencias
tabla.p(mtcars$cyl,mtcars$gear)         # Tabla de porcentajes
with(mtcars,barras.f(gear))             # Gráfico de barras de frecuencias
with(mtcars,barras.f(gear,cyl))         # Gráfico de barras de frecuencias
with(mtcars,barras.p(gear,leg=FALSE))   # Gráfico de barras de porcentajes
with(mtcars,barras.p(gear,cyl,ag="top"))# Gráfico de barras de porcentajes
with(mtcars,balasM(gear,mpg,"blue",2))  # Gráfico de balas para medias
par(mfrow=c(1,2))                       # Crear gráfica doble 
with(mtcars,balasP(cyl[am==0],"Autom."))# Gráfico de balas de proporciones
with(mtcars,balasP(cyl[am==1],"Manual"))# Gráfico de balas de proporciones
par(mfrow=c(1,1))                       # Volver a la gráfica simple 
with(mtcars,XY(mpg,wt,conf=.95))        # Gráfico XY de regresión lineal
Ford(mtcars$cyl,mtcars$gear)            # Gráfico de Ford o barcos de guerra
with(mtcars,cora(mpg,qsec))             # Gráfico XY de correlación de rangos
media(mtcars$mpg,N=1000)                # Estimativo de la media de la población  
mediana(mtcars$mpg)                     # Estimativo de la mediana de la población  
muestra(20,1,100)                       # Obtención de muestras aleatorias  
nada(100,5)                             # Confianza estadística en baja proporción  
tam(cf=.95, Sd=.5, RE=.2, uni="cm")     # Tamaño requerido de muestra aleatoria
with(mtcars,caja(drat,cyl))             # Gráfico de caja y puntos muy atípicos
propor(mtcars$cyl,"6")                  # Estimativo de proporción en la población  	  
# ------------------------------------- # ----------------------------------  
