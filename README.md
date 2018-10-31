#	Uso básico de R en arqueología
## 	Por Víctor González Fernández

### Consola
Una vez instalado, se puede ejecutar código R directamente desde la línea de comandos de la consola (`>_`). Alternativamente, se puede editar un documento de código (_script_) en el editor de R (_|Archivo|Nuevo script_), y ejecutar todo o parte del código, usando la combinación de teclas _Ctr-R_. El código para abrir una ventana del editor de R es:
```R
file.edit("")
```
Para salvar un _script_, en un archivo, se usa la combinación _Ctr-S_ y se le da un nombre y la extensión (`.R`). Los archivos .R son archivos `ASCII` y pueden ser editados por cualquier editor de texto.

Para verificar qué scripts existen en el directorio de trabajo se puede usar el comando
```R
dir() 
```
o también: 
```R
dir (pattern=".R")
```
Para ejecutar un _script_ se usa el comando _source(Nombre.R)_. Al editar documentos de código, se puede usar el operador "`#`" para insertar comentarios. El texto a la derecha del operador de comentarios no es ejecutado. 

##	Directorio de trabajo
En una instalación típica en Windows, R fija el directorio de trabajo en "Documentos". Podemos verificar cuál es el directorio de trabajo con el comando:
```R
getwd()
```
que responde algo de esta forma:

```[1] "C:/Users/Nombre/Documents"```

Siempre se puede cambiar el directorio de trabajo con el comando `setwd()`. or ejemplo, para cambiar el directorio de trabajo a una carpeta RDIR, que está en "Documentos" se puede usar:
```R
setwd("C:/Users/vgonzalez/Documents/RDIR")
getwd()
```
```[1] "C:/Users/vgonzalez/Documents/RDIR"```

Sin embargo, puede ser conveniente fijar la carpeta de trabajo. Para ello podemos editar el archivo _"Rprofile.site"_, ubicado en la carpeta "_etc_" en el subdirectorio de _R_. Normalmente esa carpeta es _"C:\Program Files\R\R-3.4.3\etc"_ (nótese el ángulo de las diagonales). Esta carpeta es probalemente protegida, así que podemos copiar el archivo a otra carpeta, editarlo y luego copiar de vuelta, dando autorización a Windows para sobreescribirlo.

Ya editado, el archivo _Rprofile.site_ con nuevo directorio de trabajo, queda así:
```R
# Things you might want to change
setwd("C:\\Users\\Nombre\\Documents\\RDIR")
# options(papersize="a4")
# options(editor="notepad")
# options(pager="internal")
```
De allí en adelante, R siempre comenzará con dicha carpeta como directorio de trabajo.

### Creación de objetos
R es un lenguaje interpretado orientado a objetos, de manera que el usuario remite al interpretador comandos que relacionan objetos para ser procesados y obtener de ellos resultados. Los objetos en R incluyen funciones, constantes y variables. El usuario puede crear diferentes tipos de objetos, asignándole valores a un nombre. El operador de asignación en R es "`<-`". En el siguiente ejemplo, se le asigna a "PI" el valor 3.1417
```R
PI <- 3.1416
```
La creación de un objeto del usuario sucede en el espacio de la memoria de la sesión activa, o "espacio local" (`ls()`) y si no es guardado en un archivo por el usuario, no estará disponible después de cerrar la sesión. La instalación básica de R incluye numerosos objetos que se pueden acceder desde la consola, incluso algunas constantes. Por ejemplo, `pi` es un objeto que contiene el valor de la constante π = 3.1415926535897931. Este objeto es diferente al objeto `PI` o a un objeto de nombre `Pi`, ya que R diferencia entre mayúscula y minúscula.

### Tipos de objetos en R

Existen numerosas clases de objetos en R. Las clases más simples (atómicas), que forman siempre _vectores atómicos_ de uno o más elementos son: "character" (caracter), "double" (número decimal), "integer" (números enteros) y "logical" (valores lógicos del tipo verdadero/falso:`TRUE/FALSE` o valor faltante:`NA`). Hay clases de objetos que son estructuras que contienen otros objetos, como "list" (combinación de objetos diferentes), "atomic vector" (listas de objetos de la misma clase), "factor" (vector categórico ordenado), "data.frame" (conjuntos de vectores del mismo tamaño), "matrix" (conjuntos de vectores del mismo tamaño y de la misma clase). Otras clases importantes son  "NULL" (objeto nulo), y "function" (función).

Para verificar a qué clase pertenece un objeto usamos la función `class()`, por ejemplo:
```R
classs(pi)
[1] "numeric"
```
```R
class(mean)
[1] "function"
```
Usaremos listas o vectores atómicos (factores, numéricos, caracteres, lógicos) para guardar en cada objeto información de cierto tipo sobre conjuntos de casos, pero seguramente querremos combinar varios vectores, en matrices o en conjunto de datos cuando queramos organizar esa información para conjuntos de datos de n variables para n casos. Cuando las variables son de diferentes clases, la información para un conjunto de datos se guarda comunmente en estructuras de la clase _data.frame_.

Cuando los objetos tienen varios elementos, se combinan usando la función `c()` (concatenar). A continuación veremos ejemplos de la combinación de elementos para crear objetos con diferentes tipos de datos.

#### Listas (combinación ordenada de objetos que pueden ser de diferente clase y longitud).
```R
w <- list(nombre="Fred", numeros=a, matriz=y, edad=5.3, datos=datos)
```
#### Vectores atómicos (listas de elementos de la misma clase)
Los valores numéricos y lógicos se escriben normalmente (1.1, 2, 3, TRUE, FALSE, NA). En cambio, los valores categóricos de encierran entre comillas simples ("Alto", "Bajo", "Sitio_1").
```R
a <- c(1,2,3,4)      # vector numérico
b <- c("uno","tres","once", NA)  # vector tipo caracter
c <- c(TRUE,TRUE,FALSE,FALSE)    # vector lógico
```
#### Matrices (combinación de objetos organizados en n filas y n columnas, todos de la misma clase)
```R
y <- matrix(1:20, nrow=5,ncol=4)
```
#### Conjunto de datos (combinación de vectores, todos de la misma longitud, que pueden ser de diferentes clases)
```R
datos <- data.frame(a,b,c)		#numéricos, caracteres, lógicos
```
#### Factores (variables que R trata como variables nominales, guardando por un lado valores nominales únicos en un vector de enteros, y por otro un vector interno con secuencias de caracteres de los valores originales, mapeados a los enteros).
```R
genero <- factor(c(rep("masculino",20),rep("femenino", 30)))
```
#### Factores ordenados (variable categórica ordinal)
```R
genero <- ordered(genero)
```

### Manipulación de objetos en R
Para listar los objetos creados disponibles en la sesión actual, usamos el comando `ls()`. Para mostrar los contenidos de un objeto, se usa la función `print(nombre)`. Dado que la función `print()` es la función por defecto, para mostrar un objeto basta con usar su nombre. Si hemos creado el objeto `genero` como se muestra arriba, mostramos los contenidos así:

```R
genero
[1] masculino masculino masculino masculino masculino
[6] masculino masculino masculino masculino masculino
[11] masculino masculino masculino masculino masculino
[16] masculino masculino masculino masculino masculino
[21] femenino  femenino  femenino  femenino  femenino 
[26] femenino  femenino  femenino  femenino  femenino 
[31] femenino  femenino  femenino  femenino  femenino 
[36] femenino  femenino  femenino  femenino  femenino 
[41] femenino  femenino  femenino  femenino  femenino 
[46] femenino  femenino  femenino  femenino  femenino 
Levels: femenino < masculino
```
Verificamos de qué clase es este objeto:
```R
class(genero)
[1] "ordered" "factor"
```
Verificamos si el objeto es de la clase "factor":
```R
is.factor(genero)
[1] TRUE
```
Verificamos si el objeto es de la clase "ordered":
```R
is.ordered(genero)
[1] TRUE
```
Verificamos la estructura del objeto:
```R
str(genero)
Ord.factor w/ 2 levels "femenino"<"masculino": 2 2 2 2 2 2 2 2 2 2 ...
```
Verificamos el modo (la forma de guardar datos en memoria)
```R
obj <- data.frame(a=c(7,3,1.2), b=c("A","B","B"))
class(obj) # La clase es la propiedad que define la forma de tratar un objeto
[1] "data.frame"
mode(obj)  # Un objeto tiene un solo modo posible. O forma de guardar en memoria.
[1] "list"
```
Obtenemos una representación de un objeto en texto ASCII:
```R
dput(obj)
structure(list(a = c(7, 3, 1.2), b = structure(c(1L, 2L, 2L), .Label = c("A", 
"B"), class = "factor")), .Names = c("a", "b"), row.names = c(NA, 
-3L), class = "data.frame")
```
Obtenemos la longitud (número de elementos o componentes) de un objeto:
```R
length(obj)
[1] 2
```
Obtenemos los nombres de elementos o componentes:
```R
names(obj)
[1] "a" "b"
```
Listamos los objectos del directorio de trabajo:
```R
ls()
[1] "A"           "AD"          "D"           "Datos1"      "genero"     "obj"        
[6] "obj2"        "p"           "plot"        "PuntosN"     "temp"        "xvar"
```
Borramos un objeto:
```R
rm(objeto)
```
Abrimos el objeto con el editor de datos de R:
```R
fix(obj) 
```
#### Acceso a partes de un objeto
R tiene diferentes modalidades para seleccionar partes relevantes de un objeto. Esto es epecialmente útil para extraer vectores de un conjunto de datos o valores de un vector que cumplan ciertos requisitos.

El comando print() presenta todo el objeto:
```R
obj
    a b
1 7.0 A
2 3.0 B
3 1.2 B
```
Accedemos a una parte de un objeto que tiene nombre, indicando ese nombre con el prefijo `$`:
```R
obj$a
[1] 7.0 3.0 1.2
```
Accedemos a una parte de un objeto bidimensional, indicando dos coordenadas entre corchetes cuadrados. Estas coordenadas son de la forma `[fila,columna]` y se seleccionan todas las filas o columnas omitiendo esa coordenada.
```R
obj[1,1]
[1] 7

obj[1, ]
  a b
1 7 A

obj[ ,1]
[1] 7.0 3.0 1.2

obj[1:2,1]
[1] 7 3

obj[2,1:2]
  a b
2 3 B
```
Extraemos elementos de un objeto usando operadores lógicos: `==` "igual a", `|` "o", `&` "y", `>` "mayor que",`<` "menor que", `<=` ("menor o igual a"), `>=` ("mayor o igual a") `!=` ("no igual a"). En los siguientes ejemplos, se seleccionan todas las _filas_ que reunen ciertas condiciones.
```R
obj[obj$b=="B",] # todas las filas para las cuales la variable "b" es "B"
    a b
2 3.0 B
3 1.2 B

obj[obj$a>2,] # todas las filas para las cuales "a" es mayor a 2
  a b
1 7 A
2 3 B
```

## Análisis estadísticos

#### Estadística descriptiva de un conjunto de datos
```R
summary(mtcars)
plot(mtcars[1:6], pch="*")
numSummary(mtcars)
```
#### Prueba t de dos muestras
```R
t.test(mtcars$mpg~mtcars$am)
boxplot(mtcars$mpg~mtcars$am, col=8)
```

#### Prueba t de una muestra
```R
t.test(mtcars$mpg,alternative='two.sided',mu=26,conf.level=.95)
hist(mtcars$mpg);abline(v=26, col=2)
```

#### Anova
```R
summary((aov(mtcars$mpg~mtcars$gear)))
boxplot(mtcars$mpg~mtcars$gear, col=8)
```

#### Regresión lineal
```R
mm <-(mtcars$mpg~mtcars$wt)
summary(lm(mm))
plot(mm, col=4)
abline(lm(mm))
```

#### Correlación de orden de rangos
```R
cor.test(mtcars$mpg,mtcars$hp,method="spearman")
plot(mtcars$mpg,mtcars$hp,col=4)
```

#### Análisis jerárquico de agrupamientos
```R
par(mar=c(2,2,2,7))
plot(as.dendrogram(hclust(dist(scale(mtcars)))),horiz=TRUE)
par(mar=c(3,3,3,3))
```

#### Escalamiento multidimensional
```R
m1 <- cmdscale(dist(scale(mtcars)))
plot(m1,type="n")
text(m1,rownames(mtcars),col=4)
```

#### Análisis de componentes principales
```R
f1 <- princomp(scale(mtcars), cor=TRUE)
summary(f1)
biplot(f1)
```

#### Análisis de agrupamiento por k-medias (k=3)
```R
cl <- kmeans(mtcars,3)
plot(mtcars$mpg,mtcars$wt,col=cl$cluster, pch=cl$cluster)
cl
```

#### Análisis de correspondencia simples
```R
library(ca)
plot(ca(smoke))
summary(ca(smoke))
```

#### Análisis de correspondencia múltiple
```R
library(MASS)
fm <- mjca(farms)
plot(fm)
text(fm$rowpcoord,fm$rownames, col=4)
```

#### Interpolación bicúbica de superficies
```R
library(akima)
data(akima)
k <- akima
ak <- interp.new(k$x,k$y,k$z)
image(ak)
points(k)
```

#### Análisis de vecino más cercano
```R
library(spatstat)
xy <- data.frame(k$x,k$y)
xyp<-as.ppp(xy,c(0,25,0,20))
clarkevans.test(xyp)
```

#### Gráfico de Tallo y hojas desdendente
```R
dt <- cars$dist
o <- capture.output(stem(dt,scale=2))
cat(c(o[1:3],rev(o[4:length(o)])),sep="\n")
```

#### Gráfico de Tallo y hojas espalda con espalda descendente
```R
ou <- capture.output(stem.leaf.backback(dt,-dt+124,depths=F,unit=1))
cat(rev(ou[3:21]),sep="\n")
```

#### Tabulación
```markdown
warpbreaks[2:3]
table(warpbreaks[2:3])
```

#### Cálculo de porcentajes por niveles (para 3 tipos:F1,F2,CL)
```R
RP <- rowPercents(data.frame(F1=c(5,8,14),F2=c(40,32,13),CL=c(200,34,10)))[,1:3]
RP
```

#### Prueba de Chi-cuadrado
```R
chisq.test(RP, correct=FALSE)
library(vcd)
assocstats(RP)
```

#### Prueba de Chi-cuadrado contra datos esperados
```R
observado <-c(19,12,7)
p_esperado<-c(.287,.610,.103)
chisq.test(observado,p=p_esperado) 
```

#### Gráfico de Buques de guerra de proporciones por nivel
```R
library(plotrix)
battleship.plot(RP, col="3", maxyspan=0.5, border="3")
```

#### Gráfico de Ford de proporciones por nivel
```R
kiteChart(t(RP[3:1,]),normalize=T,timex=F,ylab="Nivel", 
   main="%",timelabels=c(3:1),shownorm=F)
```

#### Gráfico de bala para medias
```R
source("http://vigonfer.tripod.com/balas.R.txt")
balas(mtcars$gear,mtcars$mpg)
```

#### Gráfico de bala para proporciones
```R
source("http://vigonfer.tripod.com/balaprop.R.txt")
library(car)
with(Salaries,balaprop(sex,rank,3))
```

#### Remuestreo de medianas
```R
MedA <- sapply(1:1000, function(x){median(sample(mtcars$mpg, replace=TRUE))})
hist(MedA)
```

#### Cálculo de cuantiles de una muestra de remuestreo
```R
quantile(MedA, p=c(.01, .025, .05, .95, .975, .99))
```

#### Confianza estadística en una baja proporción por ausencia
```R
n <- 100
p <- 5
D7 <- round(1-((1-(p/100))^n),4)
paste("La conf que hay <",p,"%","por ausencia en muestra n=",n,"es:", D7)
```

#### Dibujar un punto sobre Google Maps
```R
library(ggmap)
qmap(location="UNAL, Bogota",zoom=17,maptype="hybrid")+geom_point(aes(-74.083, 4.64), cex=3, col=4) 
```
