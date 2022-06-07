library(dplyr)
library(purrr)
library(tidyr)
library(Rmisc)
library(coda)
library(MCMCglmm)
library(stringr)

#load data
#includeh <- read.csv(file = "outputs/data/includeh.csv")[-c(1)] 
#includeh$genus_species <- str_replace(includeh$genus_species, " ", "_")
#tree100 <- tree100 <- readRDS("data/intermediate_data/tree100.nex")
mod_list_1 <- readRDS("MCMCglmm/model_1_nt/outputs/mod_list_1.rds")
mod_list_2 <- readRDS("MCMCglmm/model_1_nt/outputs/mod_list_2.rds")
mod_list_3 <- readRDS("MCMCglmm/model_1_nt/outputs/mod_list_3.rds")
mod_list_4 <- readRDS("MCMCglmm/model_1_nt/outputs/mod_list_4.rds")
mod_list_5 <- readRDS("MCMCglmm/model_1_nt/outputs/mod_list_5.rds")
mod_list_6 <- readRDS("MCMCglmm/model_1_nt/outputs/mod_list_6.rds")
mod_list_7 <- readRDS("MCMCglmm/model_1_nt/outputs/mod_list_7.rds")
mod_list_8 <- readRDS("MCMCglmm/model_1_nt/outputs/mod_list_8.rds")
mod_list_9 <- readRDS("MCMCglmm/model_1_nt/outputs/mod_list_9.rds")
mod_list_10 <- readRDS("MCMCglmm/model_1_nt/outputs/mod_list_10.rds")
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

# saveRDS(mod_results_flat, "MCMCglmm/model_1_nt/outputs/mod_results_100.rds")
# mod_results_flat <- readRDS("MCMCglmm/model_1_nt/outputs/mod_results_100.rds")

#mean and 95CI

# mod_results_flat %>% #this is not accurate for some reasons
#   summarise_all(CI) #upper, mean, lower

quantile(mod_results_flat$`(Intercept)`, c(0.025, 0.975)) #0.2779005 3.1168842
mean(mod_results_flat$`(Intercept)`) #1.691361
quantile(mod_results_flat$logmass, c(0.025, 0.975)) #0.03548903 0.15427416
mean(mod_results_flat$logmass) #0.09624702
quantile(mod_results_flat$abs_lat, c(0.025, 0.975)) #0.01894442 0.02474701
mean(mod_results_flat$abs_lat) #0.02182998
quantile(mod_results_flat$humanuse_bin, c(0.025, 0.975)) #0.1620011 0.3682333
mean(mod_results_flat$humanuse_bin) #0.2645385
quantile(mod_results_flat$domestication_bin, c(0.025, 0.975)) #-0.5510720 -0.2081509
mean(mod_results_flat$domestication_bin) #-0.3800166
quantile(mod_results_flat$iucn_bin, c(0.025, 0.975)) #-0.2981480 -0.2080749
mean(mod_results_flat$iucn_bin) #-0.2523806
quantile(mod_results_flat$log_sumgtrends, c(0.025, 0.975)) #0.4593977 0.5235030
mean(mod_results_flat$log_sumgtrends) #0.4915549
quantile(mod_results_flat$animal, c(0.025, 0.975)) #1.083318 2.245244; phylogeny
mean(mod_results_flat$animal) #1.604428
quantile(mod_results_flat$units, c(0.025, 0.975)) #0.7460976 0.8706927; non-phylogeny
mean(mod_results_flat$units) #0.8073547

mod_95ci <- function(model) {
  df <- as_tibble(quantile(model, c(0.025, 0.975)))
  df
}
map_df(mod_results_flat, mod_95ci)


#pagel's lambda; animal_post.mean/(animal_post.mean + units_post.mean + v_dist) 
includeh <- read.csv(file = "data/intermediate/includeh.csv")[-c(1)] 
includeh$genus_species <- str_replace(includeh$genus_species, " ", "_")
tree100 <- readRDS("data/intermediate/tree100.nex")
dat_sub <- includeh %>%
  filter(genus_species %in% tree100$tree_6061$tip.label)

v_dist <- log(1 + 1/mean(dat_sub$h)) #0.1058499
v_dist_2 <- log(1 + 1/dat_sub$h)

mean(mod_results_flat$animal)/(mean(mod_results_flat$animal) + mean(mod_results_flat$units) + v_dist) #0.6372764; H2

#95CI

post <- mean(mod_results_flat$animal)/(mean(mod_results_flat$animal) + mean(mod_results_flat$units) + v_dist_2)
quantile(post, c(0.025, 0.975)) #0.0000000, 0.6602226 
hist(post)

#exclude the 0s 

dat_exclude <- cbind(dat_sub, post)
dat_exclude <- dat_exclude$h[dat_exclude$post>0]

v_dist_exclude <- log(1 + 1/mean(dat_exclude)) #0.08509853; taking the mean of everything excluding the 0s

mean(mod_results_flat$animal)/(mean(mod_results_flat$animal) + mean(mod_results_flat$units) + v_dist_exclude) #0.6425728; H2

post_exclude <- post[post>0]
quantile(post_exclude, c(0.025, 0.975)) #0.5167356, 0.6606418; 95CI
hist(post_exclude)

length(post_exclude)/length(post) #0.7955248
(length(post)-length(post_exclude))/length(post) #0.2044752
# 5497-4373 #1124
