##
#  Abrir archivos - funciones
#  Víctor González Fernández 2026
#
xls <- function(hoja){ hoja=1
Filters = matrix(c("Excel",".xls","Excelx",".xlsx"),2,2,byrow=TRUE)
datos <- as.data.frame(readxl::read_excel(tcltk::tk_choose.files(filter=Filters),, sheet=hoja, .name_repair="universal"))
return(datos)
}
#
csv <- function(hoja){ hoja=1
Filters <- matrix(c("CSV",".csv","DAT",".dat","TXT",".txt","Todo", "*"),4,2,byrow=TRUE)
datos <- read.csv(tcltk::tk_choose.files(filter=Filters))
return(datos)
}
#
csv2 <- function(hoja){ hoja=1
Filters <- matrix(c("CSV",".csv","DAT",".dat","TXT",".txt","Todo", "*"),4,2,byrow=TRUE)
datos <- read.csv2(tcltk::tk_choose.files(filter=Filters))
return(datos)
}
#
tsv <- function(hoja){ hoja=1
Filters <- matrix(c("TXT",".txt","DAT",".dat","TSV",".tsv","Todo","*"),4,2,byrow=TRUE)
datos <- read.table(tcltk::tk_choose.files(filter=Filters))
return(datos)
}
#
rds <- function(hoja){ hoja=1
Filters <- matrix(c("RDS",".rds","Todo","*"),2,2,byrow=TRUE)
datos <- readRDS(tcltk::tk_choose.files(filter=Filters))
return(datos)
}
#
ver <- function(hoja){ hoja=1
Filters <- matrix(c("CSV",".csv","DAT",".dat", "TXT",".txt",
"TSV",".tsv","Todo","*"),5,2,byrow=TRUE)
file.show(tcltk::tk_choose.files(filter=Filters))
}
#
scr <- function(hoja){
Filters <- matrix(c("R",".R","Todo","*"),2,2,byrow=TRUE)
file.edit(tcltk::tk_choose.files(filter=Filters), fileEncoding="Latin1")
}
###