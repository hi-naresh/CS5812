
save_data<- function(data, data_path){
  if(!dir.exists(paths = data_path)){
    dir.create(data_path)
  }
  
  save(data,file=data_path)
  cat("Prepared data saved successfully!")
}