###################
# 	Funciones varias
#	por Víctor González Fernández
#	2026 abril 8
#
##### Listado de las funciones
lista <- function(x) {y=read.table(text="
Nombre 	    Función
------ 		-------
lista()     La_función_que_presenta_esta_lista
tallo()     Tallo_y_hojas_descendente
talloee()   Tallo_y_hojas_espalda_con_espalda_descendente
Winsor()    Winsorizar_un_lote
Trim()      Recortar_un_lote
TrimSd()    Calcular_la_Desviación_estándar_recortada
meanT()     Calcular_media_recortada
DM()        Calcular_la_dispersión_media
centro()    Medidas_de_tendencia_central
disper()    Medidas_de_dispersión
tabla.f()   Tabla_de_frecuencias
tabla.p()   Tabla_de_porcentajes
barras.f()  Gráfico_de_barras_de_frecuencias
barras.p()  Gráfico_de_barras_de_porcentajes
balasM()    Gráfico_de_balas_para_medias
balasP()    Gráfico_de_balas_para_proporciones
XY()        Gráfico_XY_de_regresión_lineal 
Ford()      Gráfico_de_Ford_o_barcos_de_guerra
cora()      Gráfico_XY_de_correlación_de_orden_de_rangos
media()     Estimativo_de_la_media_de_la_población
mediana()   Estimativo_de_la_mediana_de_la_población
muestra()   Obtención_de_muestras_aleatorias
nada()      Confianza_estadística_en_baja_proporción
tam()       Tamaño_requerido_de_muestra_aleatoria
caja()      Gráfico_de_caja_distinguiendo_muy_atípicos
propor()    Estimativo_de_la_proporción_en_la_población
", header=T)
print(y,right=F)}
#
# lista()
#
##### Tallo y hojas descendente
tallo <- function(x, scale=1) {
cat(deparse(substitute(x)),rev(capture.output(stem(x,scale=scale))),sep="\n")
}
# 	
# with(mtcars, tallo(mpg,scale=2))
#
##### Tallo y hojas espalda con espalda descendente
talloee <- function(x,g=999,y,unit=1,m=1,dep=FALSE,trim=FALSE){
if (!require(aplpack)) install.packages("aplpack")
library(aplpack)
if (g[[1]]!=999) {
Y = factor(g)
G1= x[Y==levels(Y)[1]]
G2= x[Y==levels(Y)[2]] 
NN = paste("      ",levels(Y)[1],levels(Y)[2], sep="   ")
} 
else {
G1 = x
G2 = y
NN = paste("      ",deparse(substitute(x)),
deparse(substitute(y)), sep="   ")
}
out <- capture.output(stem.leaf.backback(G1,G2,unit=unit,m=m,
depths=dep,style="bare",trim=trim))
out <- c(rev(out[4:length(out)]),NN)
cat(out,sep="\n")
}
# 	
# with(mtcars, talloee(mpg,am,unit=1))
# with(mtcars, talloee(qsec,y=mpg,unit=.1))
#
################### "WinsorTrimSd" 
#	por Víctor González Fernández
#	Contiene funciones para winsorizar, recortar y obtener
#	la desviación estándar recortada, así como para calcular 
#	la media recortada y la dispersión media según 
#	González y Drennan (2019).
#
#	- Cargar "WinsorTrimSd" y sus funciones:
#    source("http://vigonfer.tripod.com/R_WinsorTrimSd.txt")
#
#    Sintaxis:
#
#	- Winsor (winsoriza un lote numérico):
# 	  Winsor(vector,pr=0.1)# donde pr es "proporción de recorte"
#
#	- Trim (recorta un lote numérico):
#	  Trim(vector,pr=0.1)# donde pr es "proporción de recorte"
#
#	- TrimSd (calcula desviación estándar recortada):
#	  TrimSd(vector,pr=0.1)# donde pr es "proporción de recorte"
#
#	- meanT (calcula la media recortada):
#	  meanT(vector,pr=0.1)# donde pr es "proporción de recorte"
#
#	- DM (calcula la dispersión media o rango intercuartílico)
#	  DM(vector)
###################
#
##### winsorizar
Winsor <- function(A, pr=0.00){
n = length(A)
p05 = ceiling(n*pr)
p06 = p05+1
p95 = n-p05+1
p94 = p95-1
B = sort(A)
for (i in 1:p05) {B[i]=B[p06]}
for (i in p95:n) {B[i]=B[p94]}
A = B[1:n] 
print(A)}
#
# A <- c(2:100,187)
# Winsor(A,.1)
#
##### recortar
Trim <- function(A, pr=0.1){
p05 = ceiling(length(A)*pr)
p06 = p05+1
p95 <- length(A)-p05+1
p94 = p95-1
B = sort(A)
print(B[p06:p94])}
#
# A <- c(2:100,187)
# Trim(A)
#
##### desviación estándar recortada
TrimSd <- function(A,pr=0.1){
n = length(A)
p05 = ceiling(n*pr)
p06 = p05+1
B = sort(A, decreasing=TRUE)
for (i in 1:p05) {B[i]=B[p06]}
B = sort(B, decreasing=FALSE)
for (i in 1:p05) {B[i]=B[p06]}
nt = (n-p05*2)
sqrt((n-1)*var(B)/(nt-1))
}
#
# A <- c(2:100,187)
# TrimSd(A)
#
##### media recortada
meanT <- function(A, pr=0.1){
p05 = ceiling(length(A)*pr)
p06 = p05+1
p95 = length(A)-p05+1
p94 = p95-1
B = sort(A)
mean(B[p06:p94])
}
#
#
##### dispersión media
DM <- function(x){ X=sort(x)	# Necesitamos datos ordenados
A=ceiling(length(x)/4)  # Esto ubicar el cuartil inferior
B=length(x)-A+1		# Esto ubicar el cuartil superior
X[B]-X[A]
}
#
#
##### Medidas de tendencia central
centro <- function(x,y=0,pr=.05){
Y = rep("Todo",length(x))
if(y[1]==0) {y=Y}
round(cbind(Media=tapply(x,y, mean),	
Mediana=tapply(x,y, median),
Media_Recortada=tapply(x,y,meanT,pr=pr)),2)
} 	
# centro(mtcars$mpg,mtcars$gear, pr=.1)
# centro(mtcars$mpg, pr=.1)
#
##### Medidas de dispersión
disper <- function(x,y=0,pr=.1){
Y = rep("Todo",length(x))
if(y[1]==0) {y=Y}
round(cbind(Rango=tapply(x,y,function(x){max(x)-min(x)}),
Disp.Media=tapply(x,y,DM),
Varianza=tapply(x,y,var),
Desv.Est=tapply(x,y,sd),
Desv.Est.Rec=tapply(x,y,TrimSd,pr=pr)),2)
}
# 
# disper(mtcars$mpg,mtcars$gear,pr=.1)
# disper(mtcars$mpg)
#
##### Tabla de frecuencias
tabla.f <- function(x,y){
Xt = table(x,y)
round(addmargins(rbind(Xt,Subtotal=table(y)),2),1)
}
# Ej.:
# tabla.f(mtcars$cyl,mtcars$gear)
# tabla.f(mtcars$gear,mtcars$cyl)
#
##### Tabla de porcentajes
tabla.p <- function(x,y){
Xt = table(x,y)
dimnames(Xt)
round(addmargins(rbind(prop.table(Xt,1),Porc.Promedio=prop.table(table(y))),2)*100,1)
}
# Ej.:
# tabla.p(mtcars$cyl,mtcars$gear)
# tabla.p(mtcars$gear,mtcars$cyl)
#
##### Función para crear gráficas de barra de frecuencias. 
barras.f <- function(x,y=999,ag="topright",LABy=NULL,leg=TRUE){
LAB = deparse(substitute(x))
if (y[[1]]!=999) { TABL= table(y,x)
LABy = deparse(substitute(y)) } 
else { TABL = table(x) }
barplot(TABL, beside=T, legend.text=leg, 
args.legend=list(x=ag,title=LABy),
col=(1:nrow(TABL))+1, ylab="Frecuencia",xlab=LAB)
}
#
##### Función para crear gráficas de barra de porcentajes. 
barras.p <- function(x,y=999,ag="topright",LABy=NULL,leg=TRUE){
LAB = deparse(substitute(x))
if (y[[1]]!=999) { TABL= prop.table(table(y,x),2)*100
LABy = deparse(substitute(y)) }
else { TABL = prop.table(table(x))*100 }
barplot(TABL, beside=T, ylim=c(0,100),legend.text=leg,
args.legend=list(x=ag, title=LABy),col=(1:nrow(TABL))+1, ylab="%",
xlab=LAB)
}
#
# with(mtcars, barras.f(gear))
# with(mtcars, barras.f(gear,cyl))
#
# with(mtcars, barras.p(gear, leg=F))
# with(mtcars, barras.p(gear,cyl,ag="topleft"))
#
################### 
#    Definición de la función "balasM" (Balas para medias)
#	Víctor González Fernández
#
# Para dibujar gráficos de bala (Drennan 2009), en R base.
# Sintaxis: balasM(var.categorica, var.numérica, color, ancho)
#
# Definición:
#######################
#	Requiere el argumento "cat", que es un vector de variable tipo categórico
#	y el argumento "num" que es el vector numérico. 
#	Permite indicar color y ancho de las barras.
#
balasM <- function(cat,num,col=1,an=1,main="") { ct=factor(cat)
SER=function(x) {sd(x)/sqrt(length(x))}
TR=data.frame(N=tapply(num,ct,length),media=tapply(num,ct,mean),
 ser=tapply(num,ct,SER))
TR$p80=qt(0.90,TR$N-1); TR$p95=qt(0.975,TR$N-1); TR$p99=qt(0.995,TR$N-1)
plot(1:nrow(TR),TR$media,pch=3,xlab=deparse(substitute(cat)),
 ylab=as.character(substitute(num)),xaxt="n", xlim=c(0.5,nrow(TR)+.5),
 ylim=c(min(TR$media-1.1*TR$p99*TR$ser),max((TR$media+1.1*TR$p99*TR$ser))),
 cex=2.5*an, col=col, main=main)
arrows(1:nrow(TR),TR$media-TR$ser*TR$p80,1:nrow(TR),TR$media+TR$ser*TR$p80,
 length=.0,angle=90,code=3,lend=1,lwd=12*an, col=col)
arrows(1:nrow(TR),TR$media-TR$ser*TR$p95,1:nrow(TR),TR$media+TR$ser*TR$p95,
 length=.0,angle=90,code=3,lend=1,lwd=6*an, col=col)
arrows(1:nrow(TR),TR$media-TR$ser*TR$p99,1:nrow(TR),TR$media+TR$ser*TR$p99,
 length=.0,angle=90,code=3,lend=1,lwd=3*an, col=col)
axis(side=1,at=1:nrow(TR),labels=row.names(TR))
mtext("Conf.: \u2590\u2588\ 80%  \u2588 95%  \u2590 99%",line=-1,cex=.7,col=col)
}
#######################
# Ejemplo: 
# attach(mtcars)
# balasM(gear,mpg)
# balasM(gear,wt,col="darkblue",an=2)
#
####################### 
#	Definición de la función "balasP" (Balas para proporciones)
#	Víctor González Fernández
#
# Para dibujar gráficos de bala para proporciones (Drennan 2009), en R base.
# Sintaxis: balasP(var.categorica, Título , color)
#
# Definición:
#######################
#	Requiere el argumento "cat", que es un vector de variable tipo categórico.
#	Permite indicar título de gráfica, color, ancho de las barras y nombre
#	de la variable categórica (xlab).
#
balasP <- function (cat,main="Todos los casos",col=1,xlab="Categorías",an=1){
LID = data.frame(table(cat)); DF=sum(LID$Freq)-1
LID$p = LID$Freq/sum(LID$Freq)
LID$ser = sqrt(LID$p*(1-LID$p)) / sqrt(sum(LID$Freq))
LID$er80 = qt(0.900,df=DF)*LID$ser
LID$er95 = qt(0.975,df=DF)*LID$ser
LID$er99 = qt(0.995,df=DF)*LID$ser
ran = 1:nrow(LID)
plot(ran,LID$p,xlim=c(.5,length(LID$p)+.5),pch=3,cex=2.5*an,ylim=c(0,1),
 xaxt="n",xlab=xlab, ylab="Proporción",col=col,main=main)
arrows(ran,LID$p-LID$er99,ran,LID$p+LID$er99,length=.0,angle=90,code=3,
 lend=1,lwd=3*an, col=col)
arrows(ran,LID$p-LID$er95,ran,LID$p+LID$er95,length=.0,angle=90,code=3,
 lend=1,lwd=6*an, col=col)
arrows(ran,LID$p-LID$er80,ran,LID$p+LID$er80,length=.0,angle=90,code=3,
 lend=1,lwd=12*an, col=col)
axis(side=1,at=ran,labels=(LID$cat))
mtext("Conf.: \u2590\u2588\ 80%  \u2588 95%  \u2590 99%",line=-1,cex=.6,col=col)
}
#######################
# Ejemplo:
#
# Tiestos<-data.frame(Sitio=factor(c(rep("San Pablo",30), rep("San Pedro",40))),
# Forma=factor(c(rep("Cuenco",18),rep("Olla",12),rep("Cuenco",18),rep("Olla",22))))
#
# par(mfrow=c(1,2))
# balasP(Tiestos$Forma[Tiestos$Sitio=="San Pablo"], main="San Pablo", col= 1, xlab="Formas")
# balasP(Tiestos$Forma[Tiestos$Sitio=="San Pedro"], main="San Pedro", col= 1, xlab="Formas")
# par(mfrow=c(1,1))
#######
#
##### Función XY
#	Dibuja un gráfico XY con el resultado 
#	de la regresión lineal y una zona de confianza.
XY <- function(x,y,conf=.95){
modelo=lm(y~x)
coefs=coef(modelo)
b0 = round(coefs[1],2)
b1 = round(coefs[2],2)
pr = round(summary(modelo)$coefficients[2,4],10)
pr1 = format(pr, scientific = FALSE)
r2 = round(summary(modelo)$r.squared, 2)
eqn = bquote(italic(y)==.(b1)*italic(x)+.(b0)*","~~r^2==.(r2)*","~~p==.(pr1)*","~~Conf.==.(conf))
plot(y~x, pch=19, xlab=deparse(substitute(x)),ylab=deparse(substitute(y)))
xp = seq(min(x),max(x), length.out=10)
yp = predict(modelo,list(x=xp),interval="confidence",level=conf)
matlines(xp,yp, lty=c(1,2,2),col=c(4,2,2))
mtext(eqn, side=3)
}
#
# with(mtcars, XY(x=wt,y=mpg,conf=.99))
#
##### Gráfico de Ford o barcos de guerra
Ford <- function(x,y,col="gray34"){ 
if (!require(plotrix)) install.packages("plotrix")
library (plotrix)
mtcp <- prop.table(table(x,y),1)
battleship.plot(mtcp[,1:(ncol(mtcp))],col=col, maxyspan=0.5, border=col)
}
#
# Ford(mtcars$cyl,mtcars$gear, "purple")
#
##### Función cora() Correlación de rangos en R
cora <- function(X,Y,col=4,col2=2){
XR = rank(X)
YR = rank(Y)
corrR = cor.test(X,Y,alternative="two.sided",method="spearman",exact = FALSE)
pv = format(round(corrR$p.value, 8), scientific = FALSE)
eqn = bquote(italic("Rho")==.(corrR$estimate)*","~~italic("p")==.(pv))
Xn <- paste("Rango de",deparse(substitute(X)))
Yn <- paste("Rango de",deparse(substitute(Y)))
plot(YR~XR, pch=19, col=col,xlab=Xn, ylab=Yn)
abline(lm(XR~YR), col=col2)
mtext(eqn, side=3)
}
#
# Konsankoro <- data.frame(Suelo=c("A","B","C","D","E","F","G","H","I","J",
# "K","L","M","N","O","P","Q"), Product=c(2,6,3,7,4,8,8,1,3,5,1,8,7,2,4,3,6),
# Densidad=c(0.26,1.35,0.44,1.26,0.35,2.3,1.76,0.31,0.37,0.78,0.04,1.62,1.34,
# 0.47,0.56,0.48,0.76))
# with(Konsankoro, cora(Densidad,Product))
#
##### Función media() para estimativo de la media de la población
media <- function(muestra, pr=0, conf=.95, dec=2, N=Inf){
X = meanT(muestra,pr=pr)
n = length(muestra)
nT = (n-ceiling(n*pr)*2)
gl = (nT-1)
Sd = TrimSd(muestra,pr=pr)
EE = Sd/sqrt(nT)
t = qt((conf+1)/2,df=gl)
CPF = sqrt(1-n/N)
RE = EE*t*CPF
I1 = round(X-RE,dec)
I2 = round(X+RE,dec)
cat(round(X,dec),"±",round(RE,dec)," (",I1,"-",I2,"), p.r.=",pr,", conf.=",conf,", N=",N,"\n",sep="")
}
##### Función mediana() para estimativos de la mediana de la población
mediana <- function(x,conf=.95,rem=10000){
c1=(1-conf)/2
c2=1-c1
QS <- quantile(sapply(1:rem,function(X){median(sample(x,replace=T))}),p=c(c1,c2))
cat(QS[1],"-",QS[2],", conf.=",conf*100,"% (",rem," remuestras).\n", sep="")
}
#
##### Función muestra() para obtener muestreos aleatorios 
muestra <- function (num=10,min=0,max=100){
site = "http://random.org/integers/"
query = paste("num=",num,"&min=",min,"&max=",max,"&col=1&base=10&format=plain&rnd=new", sep="")
txt = paste(site, query, sep="?")
read.table(file=txt)[,1]
}
# 
##### Función tam() para calcular el tamaño de la muestra
tam <- function(cf=.95,Sd=.9,RE=.5,uni="mm"){ 
t = qnorm((cf+1)/2)
n =(Sd*t/RE)^2		
cat(c("El tamaño de muestra que necesitamos, para obtener estimativos al ",cf*100,"% de
confianza, con errores de menos de ", RE," ", uni, " y asumiendo que la desviación
estándar es de ", Sd," ",uni,", es de ",ceiling(n)," elementos.
\nSintaxis: tam(cf=",cf,",Sd=",Sd,",RE=",RE,",uni='",uni,"')\n",
"n = ",ceiling(n),"\n"),
sep="")
}
#
##### Función nada() para calcular confianza estadística en baja proporción
nada <- function(n,p){
D5 = 1-(p/100)
D7 = round(1-(D5^n),4)
cat("La confianza estadística en que la población tiene <", p, "% de un tipo
de elementos ausentes en una muestra de tamaño n =",n,"es del" , D7*100,"%\n")
cat(D7,"\n")}
#
#####
# 	Función caja()
#	Víctor González Fernández
#
# Dibuja gráficos de caja y puntos distinguiendo valores 
# atípicos (>1.5DM) y muy atípicos (>3DM).
#
caja <- function(y,x=NULL,notch=FALSE,col="lightgray", main=""){
if(!is.null(x)){boxplot(y~x,range=3.04948,
outpch=21,bg=1,border=0,col=0,xaxt="none",
xlab=deparse(substitute(x)),ylab=deparse(substitute(y)),main=main)
boxplot(y~x,add=T, notch=notch, col=col)}
else {boxplot(y,range=3.04948,outpch=21,bg=1,
border=0,col=0,xaxt="none", xlab="",
ylab=deparse(substitute(y)),main=main)
boxplot(y,add=T, notch=notch, col=col)}
}
#
# Ejemplos:
# caja(discoveries)
# set.seed(263);caja(rnorm(80,10))
# with(mtcars,caja(hp,am))
##
#####
#  Función propor() para estimar proporciones en la población 
propor <- function(muestra,cat=0,pr=0,conf=.95,dec=2,N=Inf){
if (cat==0) {cat=levels(factor(muestra))[1]}
n = length(muestra) # Tamaño de muestra
tabla = prop.table(table(muestra)) # Proporciones
prop = tabla[cat] # Proporción de obsidiana
s = sqrt(prop*(1-prop)) # La desviación estándar
EE = s/sqrt(n)         # El Error Estándar
t = qt((conf+1)/2, df=n-1) # t
CPF = sqrt(1-n/N)
RE = t*EE*CPF # Rango de error
I1 = round(prop-RE,dec)
I2 = round(prop+RE,dec)
cat(cat, ": " )
cat(round(prop,dec),"±",round(RE,dec)," (",I1,"-",I2,"), conf.=",conf,", N=",N,"\n",sep="")
}
#
# Ejemplo:
#Puntas <- c(rep("Obsidiana",13),rep("Chert",87))
#propor(Puntas)
#propor(Puntas,"Obsidiana")
#propor(Puntas,"Obsidiana", N=1000, conf=.99, dec=4)
#
#####