library(openxlsx)
library(C50)

#mempersiapkan data
dataCreditRating <- read.xlsx("dataCreditRating.xlsx", sep='t')
str(dataCreditRating)


dataCreditRating$risk_rating <- as.factor(dataCreditRating$risk_rating)
str(dataCreditRating)

#Menghilangkan beberapa variable input dari dataset 
input_columns <- c("durasi_pinjaman_bulan", "jumlah_tanggungan")
datafeed <- dataCreditRating[ , input_columns ]
str(datafeed)


#Mempersiapkan porsi index acak untuk training dan testing set
set.seed(100)
index_training_set <- sample(900, 800)

#Membuat dan menampilkan training set dan testing set
input_training_set <- datafeed[index_training_set,]
class_training_set <- dataCreditRating[index_training_set,]$risk_rating
input_testing_set <- datafeed[-index_training_set,]


str(input_training_set)
str(class_training_set)
str(input_testing_set)


#menghasilkan dan menampilkan summary model
risk_rating_model <- C5.0(input_training_set, class_training_set, control = C5.0Control(label="Risk Rating"))
summary(risk_rating_model)
plot(risk_rating_model)

#menyimpan hasil prediksi testing set ke dalam kolom hasil_prediksi
input_testing_set$risk_rating <- dataCreditRating[-indeks_training_set,]$risk_rating
input_testing_set$hasil_prediksi <- predict(risk_rating_model, input_testing_set)
print(input_testing_set)

#Menghitung jumlah prediksi yang benar
nrow(input_testing_set[input_testing_set$risk_rating==input_testi ng_set$hasil_prediksi,])
nrow(input_testing_set[input_testing_set$risk_rating!=input_testing_set$hasil_prediksi,])
