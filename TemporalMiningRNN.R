library(keras)

# Number of words to consider as features
max_features <- 10000  

# Cuts off texts after this number of words
maxlen <- 500

imdb <- dataset_imdb(num_words = max_features)
c(c(x_train, y_train), c(x_test, y_test)) %<-% imdb

# Reverses sequences
x_train <- lapply(x_train, rev)
x_test <- lapply(x_test, rev) 

# Pads sequences
x_train <- pad_sequences(x_train, maxlen = maxlen)  
x_test <- pad_sequences(x_test, maxlen = maxlen)

model <- keras_model_sequential() %>% 
  layer_embedding(input_dim = max_features, output_dim = 128) %>% 
  layer_lstm(units = 32) %>% 
  layer_dense(units = 1, activation = "sigmoid")

model %>% compile(
  optimizer = "rmsprop",
  loss = "binary_crossentropy",
  metrics = c("acc")
)

history <- model %>% fit(
  x_train, y_train,
  epochs = 1,
  batch_size = 128,
  validation_split = 0.2
)

predTest=model %>% predict(x_test)

predTest=predTest<0.5

#evaluate result
mean(predTest,y_test)
table(predTest,y_test)
