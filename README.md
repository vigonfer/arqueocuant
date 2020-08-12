#	Uso básico de R en arqueología
## 	Por Víctor González Fernández

### Consola
Una vez instalado, se puede ejecutar código en R directamente desde la línea de comandos de la consola (`>_`). Alternativamente, se puede editar un documento de código (_script_) en el editor de R (`|Archivo|Nuevo script`), y ejecutar todo o parte del código, usando la combinación de teclas _Ctr-R_. El código para abrir una ventana del editor de R es:
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
Para ejecutar un _script_ sin abrirlo en el editor se usa el comando `source(Nombre.R)`. Al editar documentos de código, se puede usar el operador `#` para insertar comentarios. El texto a la derecha del operador de comentarios no es ejecutado.

##	Paquetes
Además de las funciones que vienen con la instalación básica de R o _"R base"_, se pueden usar funciones que vienen en numerosos paquetes disponibles en el sitio de R, y que se pueden instalar y cargar directamente desde la consola. 
Para cargar un paquete, se usa la función `library(Nombre)`. Si intenta cargar un paquete que no está instalado, R da error. Para instalar paquetes, use la función `install.packages("Nombre")`. Una página para ayudar a encontrar paquetes útiles es <https://rseek.org/>.   


##	Directorio de trabajo
En una instalación típica en Windows, R fija el directorio de trabajo en "Documentos". Podemos verificar cuál es el directorio de trabajo con el comando:
```R
getwd()
```
que responde algo de esta forma:

```[1] "C:/Users/Nombre/Documents"```

Siempre se puede cambiar el directorio de trabajo con el comando `setwd()`. Por ejemplo, para cambiar el directorio de trabajo a una carpeta "RDIR", que está en "Documentos" se puede usar:
```R
setwd("C:/Users/Nombre/Documents/RDIR")
getwd()
```
```[1] "C:/Users/Nombre/Documents/RDIR"```

Sin embargo, puede ser conveniente fijar la carpeta de trabajo. Para ello podemos editar el archivo _"Rprofile.site"_, ubicado en la carpeta "_etc_" en el subdirectorio de _R_. Normalmente esa carpeta es _"C:\Program Files\R\R-3.4.3\etc"_ (nótese el ángulo de las diagonales. R acepta `/` o `\\`). Esta carpeta es probablemente protegida, así que podemos copiar el archivo a otra carpeta, editarlo y luego copiarlo de vuelta, dando autorización a Windows para sobreescribirlo.

Ya editado, el archivo _Rprofile.site_ indicando el nuevo directorio de trabajo, queda así:
```R
# Things you might want to change
setwd("C:\\Users\\Nombre\\Documents\\RDIR")
# options(papersize="a4")
# options(editor="notepad")
# options(pager="internal")
```
De allí en adelante, R siempre comenzará con dicha carpeta como directorio de trabajo.

### Creación de objetos
R es un lenguaje interpretado orientado a objetos, de manera que el usuario remite al interpretador comandos que relacionan objetos para ser procesados y obtener de ello resultados. Los objetos en R incluyen funciones, constantes y variables. El usuario puede crear diferentes tipos de objetos, asignándole valores a un nombre. El principal operador de asignación en R es "`<-`". Otro operador de asignación es `=`, que se usa para asignar valores dentro de la ejecución de funciones y que no debe confundirse con `==` que es el operador lógico de igualdad. En el siguiente ejemplo, se le asigna a "PI" el valor 3.1416
```R
PI <- 3.1416
```
La creación de un objeto por el usuario sucede en el espacio de la memoria de la sesión activa (cuyos objetos se listan con `ls()` u `objects()`) y si no es guardado en un archivo por el usuario, no estará disponible después de cerrar la sesión. La instalación básica de R incluye numerosos objetos que se pueden acceder desde la consola, incluso algunas constantes. Por ejemplo, `pi` es un objeto que contiene el valor de la constante π = 3.1415926535897931. Este objeto es diferente al objeto `PI` o a un objeto de nombre `Pi`, ya que R diferencia entre mayúscula y minúscula. 

Para guardar un objeto en un archivo, se usa `saveRDS()` así:
```R
saveRDS(objeto, "archivo.rds")
```
Y para leer un objeto R que se ha guardado en un archivo (normalmente de extensión `.rds`) se usa `readRDS()` así:
```R
objeto <- readRDS("archivo.rds")
```

### Tipos de objetos en R

Existen numerosas clases de objetos en R. Las clases más simples (atómicas), que forman siempre _vectores atómicos_ de uno o más elementos son: "character" (carácter), "double" (número decimal), "integer" (número entero) y "logical" (valor lógico del tipo verdadero/falso:`TRUE/FALSE` o valor faltante:`NA`). Hay clases de objetos que son estructuras que contienen otros objetos, como "list" (lista combinando objetos de diferentes clases), "atomic vector" (lista de objetos de la misma clase), "factor" (vector categórico), "data.frame" (lista de vectores del mismo tamaño), "matrix" (estructura bidimensional de elementos de la misma clase). Otras clases importantes son  "NULL" (objeto nulo), y "function" (función).

Para verificar a qué clase pertenece un objeto usamos la función `class()`, por ejemplo:
```R
class(pi)
[1] "numeric"
```
```R
class(mean)
[1] "function"
```
Usaremos listas o vectores atómicos (numéricos, caracteres, lógicos, o factores) para guardar en cada objeto información de cierto tipo sobre conjuntos de casos, pero seguramente querremos combinar varios vectores, en matrices o en conjunto de datos cuando queramos organizar esa información para conjuntos de datos de n variables para n casos. Cuando las variables son de diferentes clases, la información para un conjunto de datos se guarda comunmente en estructuras de la clase _data.frame_.

Cuando el objeto a crear contiene varios elementos, estos se pueden combinar en un vector usando la función `c()` (concatenar). Para unirlos en una lista, `list()`; para unirlos en un conjunto, `data.frame()`.  A continuación veremos ejemplos de la combinación de elementos para crear objetos con diferentes tipos de datos.

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
#### Factores (vectores que representan variables categóricas, ordenadas o no, guardando los valores únicos en un vector de enteros que representan los niveles, asociados cada uno a una etiqueta).
```R
genero <- factor(c(rep("masculino",20),rep("femenino", 30)))
```
#### Factores ordenados (variable categórica ordinal)
```R
genero <- ordered(genero)
```

### Manipulación de objetos en R
Para listar los objetos creados disponibles en la sesión actual, usamos el comando `ls()`. Para mostrar los contenidos de un objeto, se usa la función `print(nombre)`. Dado que la función `print()` es la función que R usa por defecto, para mostrar un objeto basta con usar su nombre. Si hemos creado el objeto `genero` como se muestra arriba, mostramos los contenidos así:

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
Creamos un objeto y verificamos clase y modo (la forma de guardar datos en memoria)
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
[1] "A"       "AD"        "D"        "Datos1"    "genero"    "obj"        
[7] "obj2"     "p"        "plot"     "PuntosN"   "temp"      "xvar"
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
R tiene diferentes modalidades para seleccionar partes relevantes de un objeto. Esto es especialmente útil para extraer vectores de un conjunto de datos o valores de un vector que cumplan ciertos requisitos.

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

Accedemos a los contenidos de un componente de un objeto con el número de ese componente entre corchetes dobles:
```R
obj[[1]]
[1] 7.0 3.0 1.2
```

Extraemos todo un componente de un objeto con el número de ese componente entre corchetes simples:
```R
obj[1]
    a
1 7.0
2 3.0
3 1.2
```

Accedemos a una parte de un objeto bidimensional, indicando dos coordenadas entre corchetes. Estas coordenadas son de la forma `[fila,columna]` y se seleccionan todas las filas o todas las columnas omitiendo información para esa coordenada.
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
obj[obj$b=="B", ] # todas las filas para las cuales la variable "b" es "B"
    a b
2 3.0 B
3 1.2 B

obj[obj$a>2, ] # todas las filas para las cuales "a" es mayor a 2
  a b
1 7 A
2 3 B

obj[  ,obj[1,]>1] # todas las columnas para las cuales la fila 1 es mayor a 1
    a b
1 7.0 A
2 3.0 B
3 1.2 B
```

## Análisis estadísticos
Los siguientes son ejemplos mínimos de variados análisis estadísticos en R.

#### Estadística descriptiva de un conjunto de datos
```R
library(RcmdrMisc)
summary(mtcars)
plot(mtcars[1:6], pch="*")
numSummary(mtcars)
```
#### Prueba t de dos muestras asumiendo varianzas iguales
```R
t.test(mpg~am, data=mtcars, var.equal=TRUE)
boxplot(mpg~am, data=mtcars)
```

#### Prueba t de una muestra
```R
t.test(mtcars$mpg, mu=26, conf=0.95)
boxplot(mtcars$mpg)
abline(h=26, col=2)
```

#### Anova
```R
(AV <- aov(mpg~gear, data=mtcars))
summary(AV)
boxplot(mpg~gear, data=mtcars)
```

#### Regresión lineal
```R
(ML <- lm(wt~mpg, data=mtcars))
summary(ML)
plot(wt~mpg,data=mtcars)
abline(ML, col=2)
```

#### Correlación de orden de rangos
```R
with(mtcars, cor.test(mpg, hp, method="spearman"))
with(mtcars, plot(mpg, hp, col=2))
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
(CL <- kmeans(mtcars,3))
mtcars$CL <- CL$cluster
with(mtcars, plot(mpg, wt, col=CL, pch=CL))
```

#### Análisis de correspondencia simple
```R
library(ca)
plot(ca(smoke))
summary(ca(smoke))
```

#### Análisis de correspondencias múltiples
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
ak <- interp(k$x,k$y,k$z)
image(ak)
points(k)
```

#### Análisis de vecino más cercano
```R
library(spatstat)
xy <- data.frame(k$x,k$y)
xyp <- as.ppp(xy, c(0,25,0,20))
clarkevans.test(xyp)
```

#### Gráfico de Tallo y hojas desdendente
```R
D <- cars$dist
cat(rev(capture.output(stem(D,scale=2))),sep="\n")
```

#### Gráfico de Tallo y hojas espalda con espalda descendente
```R
library(aplpack)
D2 <- D*-1.1+140 # Esto crea otro vector
cat(rev(capture.output(stem.leaf.backback(D,D2,depths=F,unit=1))),sep="\n")
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
observado <- c(19,12,7)
p_esperado <- c(.287,.610,.103)
chisq.test(observado, p=p_esperado) 
```

#### Gráfico de Buques de guerra de proporciones por nivel
```R
library(plotrix)
battleship.plot(RP, col="3", maxyspan=0.5, border="3")
```

#### Gráfico de Ford de proporciones por nivel
```R
kiteChart(t(RP[3:1,]), normalize=T, timex=F, ylab="Nivel", main="%",
 timelabels=c(3:1), shownorm=F)
```

#### Gráfico de bala para medias
```R
source("http://vigonfer.tripod.com/balasM.txt")
with(mtcars, balasM(gear,mpg))
```

#### Gráfico de bala para proporciones
```R
source("http://vigonfer.tripod.com/balasP.txt")
library(car)
with(Salaries, balasP(sex[rank=="Prof"], main="Profesores titulares"))
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
paste("La confianza es del", D7*100,"% de que una categoría ausente",
"en la muestra aleatoria de tamaño n=", n, "es <",p,"%.")
```

#### Dibujar un punto sobre un mapa
```R
library(ggmap)
bbox <- c(left=-74.10, bottom=4.62, right=-74.07, top=4.65)
ggmap(get_stamenmap(bbox, zoom = 15))+ 
geom_point(aes(-74.083, 4.64), cex=5, col=2) 
```
