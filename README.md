# Getting-and-Cleaning-Data-Project
Coursera Getting and Cleaning Data Project
# Getting and Cleaning Data - Proyecto Final

Este repositorio contiene mi solución para el proyecto final del curso "Getting and Cleaning Data" de la Universidad Johns Hopkins en Coursera. 

El objetivo del proyecto es demostrar la capacidad para recopilar, trabajar y limpiar un conjunto de datos desordenado hasta convertirlo en un tidy dataset (datos limpios y estructurados) listo para su posterior análisis.

## ¿De qué trata el proyecto?

Los datos de entrada representan las mediciones recolectadas por los acelerómetros y giroscopios de los teléfonos inteligentes (Samsung Galaxy S II) de 30 voluntarios mientras realizaban seis actividades diferentes (caminar, sentarse, acostarse, etc.). 

El problema es que el dataset original viene completamente fragmentado en múltiples archivos de texto dentro de carpetas separadas de entrenamiento (train) y prueba (test). Mi trabajo aquí fue unificar y limpiar todo ese desorden.

---

## Contenido del Repositorio

En este repositorio vas a encontrar los siguientes archivos clave:

* run_analysis.R: El script de R que contiene todo el código que escribí para procesar los datos. Si descargas este archivo y lo ejecutas en tu entorno local (teniendo la carpeta de datos instalada), va a replicar todo el proceso de limpieza automáticamente.
* CodeBook.md: El libro de códigos que detalla a fondo el proceso de transformación que seguí, los archivos de origen y la descripción de las 68 variables finales que quedaron en el dataset limpio.
* tidy_dataset.txt: El archivo de salida final. Contiene los datos ya limpios, ordenados y resumidos con los promedios correspondientes.

---

## ¿Cómo ejecutar el script run_analysis.R?

Si quieres replicar el análisis en tu computadora y comprobar que el código funciona correctamente, solo debes seguir estos pasos:

1. Descargar los datos: Descarga el archivo ZIP original con los datos del proyecto desde este enlace: http://archive.ics.uci.edu/ml/machine-learning-databases/00240/
2. Descomprimir el archivo: Extrae el contenido del ZIP en tu computadora. Esto creará una carpeta llamada "UCI HAR Dataset".
3. Configurar RStudio: Mueve el script run_analysis.R de este repositorio dentro de esa misma carpeta (UCI HAR Dataset).
4. Establecer el directorio de trabajo: Abre RStudio, abre el script y asegúrate de fijar esa carpeta como tu directorio de trabajo usando el menú Session > Set Working Directory > To Source File Location (o usando el comando setwd()).
5. Ejecutar el código: Corre todo el script. Nota: El script utiliza la librería dplyr, por lo que si no la tienes instalada, asegúrate de correr primero install.packages("dplyr").
6. Ver el resultado: Al finalizar la ejecución, verás que se genera un nuevo archivo en tu carpeta llamado tidy_dataset.txt.

## Resumen de lo que hace el script

Si no quieres abrir el código línea por línea, esto es lo que hace a grandes rasgos:
1. Lee los archivos de texto de las carpetas train y test y los une para formar un único gran bloque de datos con sujetos, actividades y mediciones.
2. Filtra las más de 500 columnas originales y se queda solo con las 66 que representan medias (mean()) y desviaciones estándar (std()).
3. Cambia los números de actividad (1 al 6) por nombres claros en texto (como SITTING o WALKING).
4. Limpia los nombres crípticos de las columnas del dataset para que sean legibles en inglés (ej. cambia abreviaturas como Acc por Accelerometer, t por Time, etc.).
5. Genera una tabla final compacta calculando el promedio de cada variable para cada combinación única de sujeto y actividad, exportándola como texto.
