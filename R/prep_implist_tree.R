library(mice)
library(stringr)
library(ape)

#dataset
dat <- read.csv("data/intermediate/includeh.csv")[-c(1)]
dat$genus_species <- str_replace(dat$genus_species, " ", "_")

#MCMCglmm does not like family as a name in the dataset
names(dat)[names(dat) == "family"] <- "spp_family"
dat$animal <- dat$genus_species

#count complete cases
comp <- apply(dat, 1, function(x){ifelse(!is.na(x["BodyMass.Value"]) & !is.na(x["median_lat"]) & !is.na(x["redlistCategory"]) == TRUE, TRUE, FALSE)})
table(comp) #3620 complete cases

#get tree
tree100 <- readRDS("data/intermediate/tree100.nex")
table(tree100$tree_6061$tip.label %in% dat$genus_species) #5518
table(dat$genus_species %in% tree100$tree_6061$tip.label) #5497

#trim tree and list so that they match
tree_sub <- tree100$tree_6061

tree_match <- list()
for (i in 1:length(tree_sub$tip.label)) {
  if (tree_sub$tip.label[i] %in% dat$genus_species) {
    tree_match$tip.label[i] <- tree_sub$tip.label[i]
  }
}
tree_match <- lapply(tree_match, function(x) x[!is.na(x)]) #remove NA entry

tree_sub <- keep.tip(tree_sub, tree_match$tip.label) #5497

dat_sub <- dat %>%
  filter(genus_species %in% tree100$tree_6061$tip.label) #5497 entries

table(tree_sub$tip.label %in% dat_sub$genus_species) #5497


#IMPUTATION

#add orders / families, remove h

data_imp <- dat_sub[, c("animal", "h", "logmass", "humanuse_bin", "domestication_bin", "iucn_bin", "log_sumgtrends")]
data_imp$abs_lat <- abs(dat_sub$median_lat)

#let's try mice (preliminary)
dim(data_imp) #5497; 8
md.pattern(data_imp)

#set up predictor matrix and imputation methods
pred_matrix <- make.predictorMatrix(data_imp)
imp_method <- make.method(data_imp)

#correlation matrix
ggpairs(data_imp[,-1])
#our cluster (-2)
#pred_matrix[ , "species"] <- -2 # cluster variable needs to be integers

#setting 0 for non-missing data
no_missing <- c("animal", "h", "humanuse_bin", "domestication_bin", "log_sumgtrends")
pred_matrix[no_missing, ] <- 0

#also put 0 for diag
diag(pred_matrix) <- 0
pred_matrix

#setting 
imp_method

#perform the imputation
imp <- mice(data_imp,
            m = 10, # need to get at least 5 - preferably 10
            maxit = 50, # we probably need to 20 to converge
            method = imp_method,
            predictorMatrix = pred_matrix,
            seed = 777)
plot(imp) #check convergence

comp1 <- complete(imp, 1)
comp2 <- complete(imp, 2)
comp3 <- complete(imp, 3)
comp4 <- complete(imp, 4)
comp5 <- complete(imp, 5)
comp6 <- complete(imp, 6)
comp7 <- complete(imp, 7)
comp8 <- complete(imp, 8)
comp9 <- complete(imp, 9)
comp10 <- complete(imp, 10)

imp_list <- list(comp1, comp2, comp3, comp4, comp5, comp6, comp7, comp8, comp9, comp10)

#save imputed datasets
saveRDS(imp_list, "MCMCglmm/data/imp_list_2.rds")
