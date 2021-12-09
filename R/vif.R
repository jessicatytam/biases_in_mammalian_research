library(car)
includeh <- read.csv("data/intermediate/includeh.csv")[-c(1)]

mod2 <- glm(h ~ logmass +
             abs(median_lat) +
             humanuse_bin +
             domestication_bin +
             I(iucn_bin^2) +
             log_sumgtrends, 
           family = "quasipoisson", 
           data = includeh)
summary(mod2)
vif(mod2)
