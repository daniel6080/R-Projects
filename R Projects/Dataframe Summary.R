#Dataframe Summary

df_summary=function(data) {
  return_value=0
  numeric_bool=FALSE
  stop=FALSE
  
  #check whether numeric value exists in data
  for(i in c(1:nrow(data))) {
    for(j in c(1:ncol(data))) {
      if(mode(data[i,j])=="numeric") numeric_bool=TRUE #TRUE if at least one variable is numeric
      stop=TRUE
    }
    if(stop==TRUE) break #break loop if at least one variable is numeric
  }
  
  #change string values to NA
  for (i in c(1:nrow(data))) {
    for (j in c(1:ncol(data))) if(is.character(data[i,j])) data[i,j]<-NA
  }
  
  #find columns that do not have all NAs
  selected=c()
  for(i in c(1:ncol(data))) {
    if(!all(is.na(data[i]))) selected=c(selected,i) 
  }
  
  #create matrix for returning summary data
  summary=matrix(nrow=length(selected),ncol=5)
  rownames(summary)<-colnames(data)[selected]
  colnames(summary)<-c("min","mean","median","max","sd")
  
  #store values in 'summary' matrix
  val=1
  for(i in selected) {
    min<-min(data[i][!is.na(data[i])])
    mean<-mean(data[i][!is.na(data[i])])
    median<-median((data[i][!is.na(data[i])]))
    max<-max((data[i][!is.na(data[i])]))
    sd<-round(sd((data[i][!is.na(data[i])])),digits=3)
    summary[val,]<-c(min,mean,median,max,sd)
    val=val+1
  }
  
  if(numeric_bool==TRUE) {
    return_value=summary 
  } else { #numeric_bool==FALSE
    return_value="None Numeric Variable"}
  
  return(return_value)
}
