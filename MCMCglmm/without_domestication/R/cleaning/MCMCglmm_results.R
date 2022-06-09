library(dplyr)
library(purrr)
library(tidyr)
library(Rmisc)
library(coda)
library(MCMCglmm)
library(stringr)

#load data
includeh <- read.csv(file = "data/intermediate/includeh.csv")[-c(1)]
#includeh$genus_species <- str_replace(includeh$genus_species, " ", "_")
#tree100 <- tree100 <- readRDS("data/intermediate_data/tree100.nex")
mod_list_1 <- readRDS("MCMCglmm/without_domestication/outputs/mod_list3_1.rds")
mod_list_2 <- readRDS("MCMCglmm/without_domestication/outputs/mod_list3_2.rds")
mod_list_3 <- readRDS("MCMCglmm/without_domestication/outputs/mod_list3_3.rds")
mod_list_4 <- readRDS("MCMCglmm/without_domestication/outputs/mod_list3_4.rds")
mod_list_5 <- readRDS("MCMCglmm/without_domestication/outputs/mod_list3_5.rds")
mod_list_6 <- readRDS("MCMCglmm/without_domestication/outputs/mod_list3_6.rds")
mod_list_7 <- readRDS("MCMCglmm/without_domestication/outputs/mod_list3_7.rds")
mod_list_8 <- readRDS("MCMCglmm/without_domestication/outputs/mod_list3_8.rds")
mod_list_9 <- readRDS("MCMCglmm/without_domestication/outputs/mod_list3_9.rds")
mod_list_10 <- readRDS("MCMCglmm/without_domestication/outputs/mod_list3_10.rds")
# mod_list_all <- readRDS("data/intermediate_data/MCMCglmm/mod_list_all.rds")
# mod_results_100 <- readRDS("data/intermediate_data/MCMCglmm/mod_results_100.rds")

#combine models
mod_list_all <- do.call(c, list(mod_list_1, mod_list_2, mod_list_3, mod_list_4, mod_list_5,
                                mod_list_6, mod_list_7, mod_list_8, mod_list_9, mod_list_10))
# saveRDS(mod_list_all, "data/intermediate_data/MCMCglmm/mod_list_all.rds")

#create a list
mod_results <- vector(mode = "list", length = 500)
for (i in 1:length(mod_list_all)) {
  mod_results[[i]] <- cbind(mod_list_all[[i]]$Sol[901:1000,], mod_list_all[[i]]$VCV[901:1000,])
}
mod_results_flat <- as.data.frame(do.call(rbind, mod_results))

mod_result <- function(model) {
  df <- as.data.frame(cbind(model$Sol[901:1000,], model$VCV[901:1000,]))
  df
}
mod_results_flat <- map_df(mod_list_all, mod_result)

# saveRDS(mod_results_flat, "MCMCglmm/model_2_nt/outputs/mod_results_100.rds")
# mod_results_flat <- readRDS("MCMCglmm/model_2_nt/outputs/mod_results_100.rds")

#mean and 95CI

# mod_results_flat %>% #this is not accurate for some reasons
#   summarise_all(CI) #upper, mean, lower

quantile(mod_results_flat$`(Intercept)`, c(0.025, 0.975)) #-1.162696  1.451196
mean(mod_results_flat$`(Intercept)`) #0.1490029
quantile(mod_results_flat$logmass, c(0.025, 0.975)) #0.04303399 0.16495094
mean(mod_results_flat$logmass) #0.1047856
quantile(mod_results_flat$abs_lat, c(0.025, 0.975)) #0.01883223 0.02480011
mean(mod_results_flat$abs_lat) #0.02175404
quantile(mod_results_flat$humanuse_bin, c(0.025, 0.975)) #0.1711018 0.3823706
mean(mod_results_flat$humanuse_bin) #0.2767843
quantile(mod_results_flat$`poly(iucn_bin, 2)1`, c(0.025, 0.975)) #-19.45307 -13.69237
mean(mod_results_flat$`poly(iucn_bin, 2)1`) #-16.53905
quantile(mod_results_flat$`poly(iucn_bin, 2)2`, c(0.025, 0.975)) #0.5810157 5.4686947
mean(mod_results_flat$`poly(iucn_bin, 2)2`) #3.021364
quantile(mod_results_flat$log_sumgtrends, c(0.025, 0.975)) #0.4685360 0.5337662
mean(mod_results_flat$log_sumgtrends) #0.5011743
quantile(mod_results_flat$animal, c(0.025, 0.975)) #1.055440 2.209427; phylogeny
mean(mod_results_flat$animal) #1.573439
quantile(mod_results_flat$units, c(0.025, 0.975)) #0.7554593 0.8823674; non-phylogeny
mean(mod_results_flat$units) #0.81821

mod_95ci <- function(model) {
  df <- as_tibble(quantile(model, c(0.025, 0.975)))
  df
}
map_df(mod_results_flat, mod_95ci)


#pagel's lambda; animal_post.mean/(animal_post.mean + units_post.mean + v_dist) 
includeh_wo_dom <- read.csv(file = "data/intermediate/includeh_wo_dom.csv")[-c(1)] 
includeh_wo_dom$genus_species <- str_replace(includeh_wo_dom$genus_species, " ", "_")
tree100 <- readRDS("data/intermediate/tree100.nex")
dat_sub <- includeh_wo_dom %>%
  filter(genus_species %in% tree100$tree_6061$tip.label)

v_dist <- log(1 + 1/mean(dat_sub$h)) #0.1199701
v_dist_2 <- log(1 + 1/dat_sub$h)

mean(mod_results_flat$animal)/(mean(mod_results_flat$animal) + mean(mod_results_flat$units) + v_dist) #0.626464; H2

#95CI

post <- mean(mod_results_flat$animal)/(mean(mod_results_flat$animal) + mean(mod_results_flat$units) + v_dist_2)
quantile(post, c(0.025, 0.975)) #0.0000000, 0.652148
hist(post)

#exclude the 0s 

dat_exclude <- cbind(dat_sub, post)
dat_exclude <- dat_exclude$h[dat_exclude$post>0]

v_dist_exclude <- log(1 + 1/mean(dat_exclude)) #0.0958999; taking the mean of everything excluding the 0s

mean(mod_results_flat$animal)/(mean(mod_results_flat$animal) + mean(mod_results_flat$units) + v_dist_exclude) #0.6325259; H2

post_exclude <- post[post>0]
quantile(post_exclude, c(0.025, 0.975)) #0.5100625 0.6527869; 95CI
hist(post_exclude)

length(post_exclude)/length(post) #0.7896313
(length(post)-length(post_exclude))/length(post) #0.2103687
# 5497-4373 #1124
