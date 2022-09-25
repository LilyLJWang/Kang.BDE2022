setwd("C:\\Users\\siyuanmao\\Documents\\imdada\\0-渠道投放和新人券联动模型\\测算")
options(scipen=3)  ##取消科学计数法
channel_ad_ios_data<-seq(0,50000,5000)
channel_ad_android_data<-seq(0,100000,10000)

library(parallel)

func <- function(n){#n=1
  result_data<-read.csv("发券方案.csv",stringsAsFactors=FALSE)
  total_coupon_solution_data<-read.csv("结果表框架.csv",stringsAsFactors=FALSE)
  coupon_solution_data<-subset(result_data,solution== paste('方案',n,sep=""))
  
  for (i in 1:11){#i=3
    coupon_solution_data$channel_ad_cost[3]<-5000*(i-1)
    
    for (j in 1:11){#j=5
      coupon_solution_data$channel_ad_cost[4]<-10000*(j-1)
      solution_mark<-paste('方案',n,i,j,sep="-")
      coupon_solution_data$solution<-solution_mark
      
      total_coupon_solution_data<-rbind(total_coupon_solution_data,coupon_solution_data)
    }
  }
  print(solution_mark)
  return(total_coupon_solution_data)
}

#func(10)
system.time({
  x <- 1:7776
  cl <- makeCluster(4) # 初始化四核心集群
  results <- parLapply(cl,x,func) # lapply的并行版本
  res.df <- do.call('rbind',results) # 整合结果
  stopCluster(cl) # 关闭集群
})




df=as.data.frame(res.df)
