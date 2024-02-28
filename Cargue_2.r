# Instala y carga las librerías si aún no las tienes instaladas
# install.packages("stringr")
# install.packages("lubridate")

library(stringr)
library(lubridate)

# Lee el archivo CSV
datos <- read.csv("c:\\1\\Adres\\Prestadores.csv", sep = ";")

# Crea una conexión a una base de datos SQLite (creará la base de datos si no existe)
con <- dbConnect(RSQLite::SQLite(), "mi_base_de_datos.db")

# Convertir el valor a mayúsculas
datos$depa_nombre <- toupper ( datos$depa_nombre)
datos$nombre_prestador <- toupper ( datos$nombre_prestador)
datos$razon_social <- toupper ( datos$razon_social)
datos$clpr_nombre <- toupper ( datos$clpr_nombre)
datos$direccion <- toupper ( datos$direccion)
datos$email <- tolower ( datos$email)
datos$naju_nombre <- toupper ( datos$naju_nombre)
datos$email_adicional <- tolower ( datos$email_adicional)
datos$rep_legal <- toupper ( datos$rep_legal)

# Remover caracteres especiales
datos$nombre_prestador <- gsub("[^a-zA-ZáéíóúÁÉÍÓÚ ]", "", datos$nombre_prestador)
datos$nombre_prestador <- gsub('"', '', datos$nombre_prestador)
datos$razon_social <- gsub("[^a-zA-ZáéíóúÁÉÍÓÚ ]", "", datos$razon_social)
datos$razon_social <- gsub('"', '', datos$razon_social)

# Eliminar espacios en blanco adicionales
datos$codigo_habilitacion <- trimws(datos$codigo_habilitacion)
# Eliminar espacios en blanco adicionales entre las palabras
datos$codigo_habilitacion <- gsub("\\s+", " ",datos$codigo_habilitacion)
datos$codigo_habilitacion <- gsub(" ", "",datos$codigo_habilitacion)

# Dar formato al número para evitar la notación científica
datos$nits_nit <- as.character(datos$nits_nit)

# Extraer año, mes y día de la cadena de fecha_radicacion
año <- substr(datos$fecha_radicacion, 1, 4)
mes <- substr(datos$fecha_radicacion, 5, 6)
dia <- substr(datos$fecha_radicacion, 7, 8)

# Concatenar año, mes y día en el formato deseado
datos$fecha_radicacion <- paste(año, mes, dia, sep = "-")

# Extraer año, mes y día de la cadena de fecha_vencimiento
año <- substr(datos$fecha_vencimiento, 1, 4)
mes <- substr(datos$fecha_vencimiento, 5, 6)
dia <- substr(datos$fecha_vencimiento, 7, 8)

# Asignar el valor "16/02/2024" al campo "fecha_cierre"
datos$fecha_cierre <- ""

# Concatenar año, mes y día en el formato deseado
datos$fecha_vencimiento <- paste(año, mes, dia, sep = "-")

# Asignar el valor "16/02/2024" al campo "Fecha corte REPS"
datos$fecha_corte_REPS <- "2024-02-16"

# Asignar el valor "05:27 PM" al nuevo campo "Hora_fecha_corte_REPS"
datos$Hora_fecha_corte_REPS <- "05:27 PM"

# Especifica la ruta completa donde deseas guardar el archivo CSV
ruta <- "c:\\1\\Adres\\Prestadores_ajustado.csv"

# Escribe el data frame 'datos' en un archivo CSV en la ruta especificada
write.csv(datos, file = ruta, row.names = FALSE)

# Muestra las primeras filas del archivo en la consola
#print(head(datos))

filas_seleccionadas <- datos[datos$codigo_habilitacion == "4700101721", ]

# Mostrar las filas seleccionadas
print(filas_seleccionadas)