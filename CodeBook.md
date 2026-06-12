# Proyecto Final: Getting and Cleaning Data

En este repositorio está mi solución para el proyecto final. La idea principal fue agarrar un montón de archivos de texto sueltos que venían en el ZIP de los sensores del teléfono (el *Human Activity Recognition dataset*) y unificarlos en un solo archivo limpio (`tidy_dataset.txt`).

## Limpieza de datos (Paso a Paso)

Cuando descargas el dataset original, te das cuenta de que todo está separado y no hay una columna clara que sirva de clave. Así fue como acomodé todo en mi script `run_analysis.R`:

1.  **Juntar las piezas:** Primero trabajé con la carpeta de pruebas (`test`). Agarré las mediciones (`X_test`), los códigos de las actividades (`y_test`) y a los voluntarios (`subject_test`) y los pegué de lado con `cbind()`. Hice exactamente lo mismo con la carpeta de entrenamiento (`train`). Ya que tenía los dos bloques armados, los apilé uno encima del otro usando `rbind()`.
2.  **Filtrar lo importante:** El dataset original tiene más de 500 variables, pero las instrucciones piden solo las medias y desviaciones estándar. Así que cargué el archivo `features.txt` y usé `grep()` para buscar los nombres que tuvieran `mean()` o `std()`. Con esos índices recorté mi tabla gigante.
3.  **Nombres de actividades reales:** En lugar de dejar los números del 1 al 6 que venían por defecto, cargué `activity_labels.txt` y convertí esa columna en un factor en R. Ahora se lee claramente si el sujeto estaba caminando, sentado o acostado.
4.  **Limpieza de los nombres de columnas:** Los nombres originales tenían demasiados guiones y paréntesis raros. Usé `gsub()` para quitar los `()` y cambié las abreviaturas por palabras completas (por ejemplo, `t` al inicio pasó a ser `Time`, `f` pasó a `Frequency`, `Acc` a `Accelerometer` y `Gyro` a `Gyroscope`). Así es mucho más fácil llamarlas en R.
5.  **Finalmente:** Usando la librería `dplyr`, agrupé toda la tabla por `Sujeto` y por `Actividad`. Al final usé `summarise_all(mean)` para sacar el promedio de cada medición para esa combinación específica. Exporté el resultado con `write.table()`.

------------------------------------------------------------------------

## Diccionario de Variables

Mi archivo final (`tidy_dataset.txt`) terminó con **180 filas** (que corresponden a los 30 voluntarios multiplicado por las 6 actividades que hizo cada uno) y **68 columnas**.

### Identificadores

-   **Sujeto:** El ID del voluntario (va del 1 al 30).
-   **Actividad:** La acción que estaba haciendo la persona en ese momento (un factor con 6 niveles: `WALKING`, `WALKING_UPSTAIRS`, `WALKING_DOWNSTAIRS`, `SITTING`, `STANDING`, `LAYING`).

### Mediciones de los Sensores

Aquí están las otras 66 columnas. Todas son valores **numéricos y promedios** calculados a partir de las señales del acelerómetro y el giroscopio del teléfono.

> **Unidades:** Una cosa importante es que el dataset original ya viene normalizado y escalado entre -1 y 1. Esto significa que estas variables **no tienen unidades de medida** (son adimensionales), así que no te preocupes por buscar si son metros o segundos.

Aquí dejo la lista de las variables tal y como quedaron nombradas en la tabla:

-   **TimeBodyAccelerometerMean-X / Y / Z:** Promedio de la aceleración del cuerpo en el tiempo para los ejes X, Y y Z.
-   **TimeBodyAccelerometerStd-X / Y / Z:** Desviación estándar de la aceleración del cuerpo en el tiempo.
-   **TimeGravityAccelerometerMean-X / Y / Z:** Promedio de la aceleración de la gravedad para cada eje.
-   **TimeGravityAccelerometerStd-X / Y / Z:** Desviación estándar de la aceleración de la gravedad.
-   **TimeBodyAccelerometerJerkMean-X / Y / Z:** Promedio de los cambios bruscos de aceleración (Jerk) del cuerpo.
-   **TimeBodyAccelerometerJerkStd-X / Y / Z:** Desviación estándar de los cambios bruscos de aceleración.
-   **TimeBodyGyroscopeMean-X / Y / Z:** Promedio de la velocidad angular medida por el giroscopio.
-   **TimeBodyGyroscopeStd-X / Y / Z:** Desviación estándar de la velocidad angular.
-   **TimeBodyGyroscopeJerkMean-X / Y / Z:** Promedio de los cambios bruscos de velocidad angular.
-   **TimeBodyGyroscopeJerkStd-X / Y / Z:** Desviación estándar de los cambios bruscos de velocidad angular.
-   **TimeBodyAccelerometerMagnitudeMean / Std:** Promedio y desviación de la magnitud de la aceleración del cuerpo.
-   **TimeGravityAccelerometerMagnitudeMean / Std:** Promedio y desviación de la magnitud de la gravedad.
-   **TimeBodyAccelerometerJerkMagnitudeMean / Std:** Promedio y desviación de la magnitud de los cambios bruscos de aceleración.
-   **TimeBodyGyroscopeMagnitudeMean / Std:** Promedio y desviación de la magnitud de la velocidad angular.
-   **TimeBodyGyroscopeJerkMagnitudeMean / Std:** Promedio y desviación de la magnitud de los cambios bruscos angulares.

*(Nota: Las siguientes variables miden lo mismo que las anteriores, pero aplicando una Transformada Rápida de Fourier para ver los datos en el dominio de la frecuencia)*

-   **FrequencyBodyAccelerometerMean-X / Y / Z**
-   **FrequencyBodyAccelerometerStd-X / Y / Z**
-   **FrequencyBodyAccelerometerJerkMean-X / Y / Z**
-   **FrequencyBodyAccelerometerJerkStd-X / Y / Z**
-   **FrequencyBodyGyroscopeMean-X / Y / Z**
-   **FrequencyBodyGyroscopeStd-X / Y / Z**
-   **FrequencyBodyAccelerometerMagnitudeMean / Std**
-   **FrequencyBodyBodyAccelerometerJerkMagnitudeMean / Std**
-   **FrequencyBodyBodyGyroscopeMagnitudeMean / Std**
-   **FrequencyBodyBodyGyroscopeJerkMagnitudeMean / Std**
