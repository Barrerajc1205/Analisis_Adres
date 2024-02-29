# Lee el archivo CSV
datos <- read.csv("c:\\1\\Adres\\Municipios.csv", sep = ";")

# Crea una conexión a una base de datos SQLite (creará la base de datos si no existe)
con <- dbConnect(RSQLite::SQLite(), "mi_base_de_datos.db")

# Carga los datos en una tabla llamada "Municipios" en la base de datos
dbWriteTable(con, "Municipios", datos, overwrite = TRUE)

# Corregir el campo Dep según el códida asignar el nombre del Departamento
datos$Departamento <- ifelse(datos$Dep == 5, "ANTIOQUIA", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 8, "ATLÁNTICO", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 11, "BOGOTÁ D.C", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 13, "BOLÍVAR", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 15, "BOYACÁ", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 17, "CALDAS", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 18, "CAQUETÁ", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 19, "CAUCA", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 20, "CESAR", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 23, "CÓRDOBA", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 25, "CUNDINAMARCA", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 27, "CHOCÓ", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 41, "HUILA", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 44, "LA GUAJIRA", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 47, "MAGDALENA", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 50, "META", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 52, "NARIÑO", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 54, "NORTE DE SANTANDER", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 63, "QUINDÍO", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 66, "RISARALDA", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 68, "SANTANDER", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 70, "SUCRE", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 73, "TOLIMA", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 76, "VALLE DEL CAUCA", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 81, "ARAUCA", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 85, "CASANARE", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 86, "PUTUMAYO", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 88, "SAN ANDRÉS", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 91, "AMAZONAS", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 94, "GUAINÍA", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 95, "GUAVIARE", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 97, "VAUPÉS", datos$Departamento)
datos$Departamento <- ifelse(datos$Dep == 99, "VICHADA", datos$Departamento)

# Remover caracteres especiales
datos$Municipio <- gsub("[^a-zA-ZáéíóúÁÉÍÓÚñÑ ]", "", datos$Municipio)

# Eliminar espacios en blanco adicionales
datos$Municipio <- trimws(datos$Municipio)

# Eliminar espacios en blanco adicionales entre las palabras
datos$Municipio <- gsub("\\s+", " ", datos$Municipio)

# Convertir el valor a mayúsculas
datos$Municipio<- toupper ( datos$Municipio)

# Reemplazar la coma por un punto y convertir en número
datos$Superficie  <- as.numeric(gsub(",", ".", datos$Superficie ))

# Redondear el número a dos decimales
datos$Superficie  <- round(datos$Superficie , 0)

# Convertir el número redondeado en una cadena de caracteres con coma como separador decimal
datos$Superficie <- format(datos$Superficie , decimal.mark = ",")
# Especifica la ruta completa donde deseas guardar el archivo CSV
ruta <- "c:\\1\\Adres\\Municipios_ajustado.csv"

# Escribe el data frame 'datos' en un archivo CSV en la ruta especificada
write.csv(datos, file = ruta, row.names = FALSE)

# Muestra el contenido del archivo en la consola
print(head(datos))
dbDisconnect(con)