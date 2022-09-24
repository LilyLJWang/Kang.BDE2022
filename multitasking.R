## 一共多少核
library(parallel)
nCores <- detectCores()#一共多少核
nCores

## lapply Sequential computing
x <- iris[which(iris[,5] != "setosa"), c(1,5)]
trials <- seq(1, 10000)
boot_fx <- function(trial) {
  ind <- sample(100, 100, replace=TRUE)
  result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
  r <- coefficients(result1)
  res <- rbind(data.frame(), r)
}
system.time({
  results <- lapply(trials, boot_fx)
})

## mclapply
# Parallel computing using mclapply
library(parallel)#里面有mclapply
x <- iris[which(iris[,5] != "setosa"), c(1,5)]
trials <- seq(1, 10000)
boot_fx <- function(trial) {
  ind <- sample(100, 100, replace=TRUE)
  result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
  r <- coefficients(result1)
  res <- rbind(data.frame(), r)
}
system.time({
  results <- mclapply(trials, boot_fx, mc.cores = detectCores())
})

## parLapply
# Parallel computing using parLapply
x <- iris[which(iris[,5] != "setosa"), c(1,5)]
trials <- seq(1, 10000)
cl <- makeCluster(nCores, type = 'SOCK')
clusterExport(cl, "x")#加上这行
system.time(results <- parLapply(cl, trials, boot_fx))
stopCluster(cl)


## Almost any OS
# On Windows (and most OS), + + .snow doParallel foreach
library(doParallel)
cl <- makeCluster(nCores, type = 'SOCK')#建立并行
registerDoParallel(cl)
result <- foreach(i = 1:10000) %dopar% sqrt(i)#dopar并行函数，只有do的话是序列运行
head(result)
stopCluster(cl)

## Unix-style OS,在win报错
# On Unix-style OS, + + .multicore doMC foreach
library(doMC)
registerDoMC(nCores)
system.time(result<-foreach(i = 1:10000, .combine = c) %dopar% sqrt(i))#result是列表，combine之后变向量
head(result)

# Parallel computing using foreach-Go back to the bootstraping example
doMC::registerDoMC(cores = nCores)
x <- iris[which(iris[,5] != "setosa"), c(1,5)]
trials <- 10000
system.time({
  r <- foreach(1:trials, .combine = rbind) %dopar% {
    ind <- sample(100, 100, replace=TRUE)
    result1 <- glm(x[ind,2]~x[ind,1], family=binomial(logit))
    coefficients(result1)
  }
})

