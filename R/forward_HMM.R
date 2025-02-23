#' HMM forward algorithm
#'
#' @param P A transition prob matrix
#' @param E An emission probability matrix
#' @param v An initial state distribution
#' @param y vector of observed states
#' @param s dim of hidden state space
#'
#' @export
forward_HMM <- function(P,E,v,y,s) {
  aarray <- matrix(0,nrow = 2,ncol = length(y))
  a <- c()
  for(j in 1:s){
    a <- c(a,v[j]*E[j,y[1]])
  }
  for(t in 1:(length(y)-1)){
    a_old <- a
    aarray[,t] <- a_old
    for(i in 1:s){
      a[i] <- 0
      for(j in 1:s){
        a[i] <- a[i]+P[j,i]*a_old[j]
      }
      a[i] <- E[i,y[t+1]]*a[i]
    }
  }
  aarray[,length(y)] <- a
  p <- 0
  for(j in 1:s){
    p <- p + a[j]
  }
  return(list(p,aarray))
}
