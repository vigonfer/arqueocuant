#	Uso básico de R en arqueología
## 	Por Víctor González Fernández

```{r}
#	Estadística descriptiva de un conjunto de datos
```

```{r}
summary(mtcars); plot(mtcars[1:6], pch="*"); numSummary(mtcars)
```

```{r}
#	Prueba t de dos muestras
```

```{r}
t.test(mtcars$mpg~mtcars$am); boxplot(mtcars$mpg~mtcars$am, col=8)
```

```{r}
#	Prueba t de una muestra
```

```{r}
t.test(mtcars$mpg,alternative='two.sided',mu=26,conf.level=.95);hist(mtcars$mpg);abline(v=26, col=2)
```

```{r}
# 	Anova
```

```{r}
summary((aov(mtcars$mpg~mtcars$gear)));boxplot(mtcars$mpg~mtcars$gear, col=8)
```

```{r}
#	Regresión lineal
```

```{r}
mm <-(mtcars$mpg~mtcars$wt);summary(lm(mm));plot(mm, col=4);abline(lm(mm))
```

```{r}
#	Correlación de orden de rangos
```

```{r}
cor.test(mtcars$mpg,mtcars$hp,method="spearman");plot(mtcars$mpg,mtcars$hp,col=4)
```

```{r}
# 	Análisis jerárquico de agrupamientos
```

```{r}
par(mar=c(2,2,2,7)); plot(as.dendrogram(hclust(dist(scale(mtcars)))),horiz=TRUE);par(mar=c(3,3,3,3))
```

```{r}
#	Escalamiento multidimensional
```

```{r}
m1 <- cmdscale(dist(scale(mtcars)));plot(m1,type="n");text(m1,rownames(mtcars),col=4)
```

```{r}
#	Análisis de componentes principales
```

```{r}
f1 <- princomp(scale(mtcars), cor=TRUE); summary(f1); biplot(f1)
```

```{r}
#	Análisis de agrupamiento por k-medias (k=3)
```

```{r}
cl <- kmeans(mtcars,3); plot(mtcars$mpg,mtcars$wt,col=cl$cluster, pch=cl$cluster);cl
```

```{r}
#	Análisis de correspondencia simples
```

```{r}
library(ca); plot(ca(smoke)); summary(ca(smoke))
```

```{r}
#	Análisis de correspondencia múltiple
```

```{r}
library(MASS); fm <- mjca(farms); plot(fm); text(fm$rowpcoord,fm$rownames, col=4)
```

```{r}
#	Interpolación bicúbica de superficies
```

```{r}
library(akima);data(akima);k<-akima; ak<-interp.new(k$x,k$y,k$z);image(ak);points(k)
```

```{r}
#	Análisis de vecino más cercano
```

```{r}
library(spatstat);xy<-data.frame(k$x,k$y);xyp<-as.ppp(xy,c(0,25,0,20));clarkevans.test(xyp)
```

```{r}
#	Gráfico de Tallo y hojas desdendente
```

```{r}
dt<-cars$dist;o<-capture.output(stem(dt,scale=2));cat(c(o[1:3],rev(o[4:length(o)])),sep="\n")
```

```{r}
#	Gráfico de Tallo y hojas espalda con espalda descendente
```

```{r}
ou<-capture.output(stem.leaf.backback(dt,-dt+124,depths=F,unit=1));cat(rev(ou[3:21]),sep="\n")
```

```{r}
#	Tabulación
```

```{r}
warpbreaks[2:3]; table(warpbreaks[2:3])
```

```{r}
#	Cálculo de porcentajes por niveles (para 3 tipos:F1,F2,CL)
```

```{r}
RP <- rowPercents(data.frame(F1=c(5,8,14),F2=c(40,32,13),CL=c(200,34,10)))[,1:3]; RP
```

```{r}
#	Prueba de Chi-cuadrado
```

```{r}
chisq.test(RP, correct=FALSE);library(vcd); assocstats(RP)
```

```{r}
#	Prueba de Chi-cuadrado contra datos esperados
```

```{r}
observado <-c(19,12,7);p_esperado<-c(.287,.610,.103);chisq.test(observado,p=p_esperado) 
```

```{r}
#	Gráfico de Buques de guerra de proporciones por nivel
```

```{r}
library(plotrix); battleship.plot(RP, col="3", maxyspan=0.5, border="3")
```

```{r}
#	Gráfico de Ford de proporciones por nivel
```

```{r}
kiteChart(t(RP[3:1,]),normalize=T,timex=F,ylab="Nivel",main="%",timelabels=c(3:1),shownorm=F)
```

```{r}
#	Gráfico de bala para medias
```

```{r}
source("http://vigonfer.tripod.com/balas.R.txt"); balas(mtcars$gear,mtcars$mpg)
```

```{r}
#	Gráfico de bala para proporciones
```

```{r}
source("http://vigonfer.tripod.com/balaprop.R.txt");library(car);with(Salaries,balaprop(sex,rank,3))
```

```{r}
#	Remuestreo de medianas
```

```{r}
MedA <- sapply(1:1000, function(x){median(sample(mtcars$mpg, replace=TRUE))});hist(MedA)
```

```{r}
#	Cálculo de cuantiles de una muestra de remuestreo
```

```{r}
quantile(MedA, p=c(.01, .025, .05, .95, .975, .99))
```

```{r}
#	Confianza estadística en una baja proporción por ausencia
```

```{r}
n=100;p=5;D7=round(1-((1-(p/100))^n),4);paste("La conf que hay <",p,"%","por ausencia en muestra n=",n,"es:",
   D7)
```

```{r}
#	Dibujar un punto sobre Google Maps
```

```{r}
library(ggmap);qmap(location="UNAL, Bogota",zoom=17,maptype="hybrid")+geom_point(aes(-74.083, 4.64),cex=3,
  col=4) 
```

```{r}
#
```

```{r}
##
```


## Welcome to GitHub Pages

You can use the [editor on GitHub](https://github.com/vigonfer/arqueocuant/edit/master/README.md) to maintain and preview the content for your website in Markdown files.

Whenever you commit to this repository, GitHub Pages will run [Jekyll](https://jekyllrb.com/) to rebuild the pages in your site, from the content in your Markdown files.

### Markdown

Markdown is a lightweight and easy-to-use syntax for styling your writing. It includes conventions for

```markdown
Syntax highlighted code block

# Header 1
## Header 2
### Header 3

- Bulleted
- List

1. Numbered
2. List

**Bold** and _Italic_ and `Code` text

[Link](url) and ![Image](src)
```

For more details see [GitHub Flavored Markdown](https://guides.github.com/features/mastering-markdown/).

### Jekyll Themes

Your Pages site will use the layout and styles from the Jekyll theme you have selected in your [repository settings](https://github.com/vigonfer/arqueocuant/settings). The name of this theme is saved in the Jekyll `_config.yml` configuration file.

### Support or Contact

Having trouble with Pages? Check out our [documentation](https://help.github.com/categories/github-pages-basics/) or [contact support](https://github.com/contact) and we’ll help you sort it out.
