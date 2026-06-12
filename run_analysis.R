setwd("~/UCI HAR Dataset")
library(dplyr)
X_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")
todo_test <- cbind(subject_test, y_test, X_test)
X_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")
todo_train <- cbind(subject_train, y_train, X_train)
dataset_completo <- rbind(todo_train, todo_test)
features <- read.table("features.txt")
columnas_interes <- grep("mean\\(\\)|std\\(\\)", features$V2)
dataset_filtrado <- dataset_completo[, c(1, 2, columnas_interes + 2)]
actividades <- read.table("activity_labels.txt")
dataset_filtrado[, 2] <- factor(dataset_filtrado[, 2], levels = actividades$V1, labels = actividades$V2)
nombres_columnas <- features$V2[columnas_interes]
names(dataset_filtrado) <- c("Sujeto", "Actividad", nombres_columnas)
nombres_limpios <- names(dataset_filtrado)
nombres_limpios <- gsub("^t", "Time", nombres_limpios)
nombres_limpios <- gsub("^f", "Frequency", nombres_limpios)
nombres_limpios <- gsub("Acc", "Accelerometer", nombres_limpios)
nombres_limpios <- gsub("Gyro", "Gyroscope", nombres_limpios)
nombres_limpios <- gsub("Mag", "Magnitude", nombres_limpios)
nombres_limpios <- gsub("\\(\\)", "", nombres_limpios)
nombres_limpios <- gsub("-mean", "Mean", nombres_limpios)
nombres_limpios <- gsub("-std", "Std", nombres_limpios)
names(dataset_filtrado) <- nombres_limpios

dataset_final <- dataset_filtrado %>%
  group_by(Sujeto, Actividad) %>%
  summarise_all(mean)

write.table(dataset_final, "tidy_dataset.txt", row.name = FALSE)

