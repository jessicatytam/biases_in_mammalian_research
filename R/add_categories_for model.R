library(tidyverse)
library(GGally)
library(glmmTMB)
library(here)
library(ape)
library(rotl)
library(phylolm)
library(car)
library(phyr)

#save and read

write.csv(includeh, file = "data/intermediate/includeh.csv")
includeh <- read.csv("data/intermediate/includeh.csv")[-c(1)]

#adding coloums

includeh <- includeh %>% 
  arrange(genus_species) %>%
  mutate(iucn_bin = NA,
         humanuse_bin = NA,
         domestication_bin = NA)

#1:6 for iucn
for (i in 1:length(includeh$redlistCategory)) {
  if (!is.na(includeh$redlistCategory[i]) & includeh$redlistCategory[i] == "Least Concern") {
    includeh$iucn_bin[i] <- 1
  } else if (!is.na(includeh$redlistCategory[i]) & includeh$redlistCategory[i] == "Near Threatened") {
    includeh$iucn_bin[i] <- 2
  } else if (!is.na(includeh$redlistCategory[i]) & includeh$redlistCategory[i] == "Vulnerable") {
    includeh$iucn_bin[i] <- 3
  } else if (!is.na(includeh$redlistCategory[i]) & includeh$redlistCategory[i] == "Endangered") {
    includeh$iucn_bin[i] <- 4
  } else if (!is.na(includeh$redlistCategory[i]) & includeh$redlistCategory[i] == "Critically Endangered") {
    includeh$iucn_bin[i] <- 5
  } else if (!is.na(includeh$redlistCategory[i]) & includeh$redlistCategory[i] == "Extinct in the Wild") {
    includeh$iucn_bin[i] <- 6
  }
}

#binary for human use
for (i in 1:length(includeh$use1)) {
  if (is.na(includeh$use1[i])) {
    includeh$humanuse_bin[i] <- 0
  } else {
    includeh$humanuse_bin[i] <- 1
  }
}

#1:3 for domestication
for (i in 1:length(includeh$domestication)) {
  if (includeh$domestication[i] == "Domesticated") {
    includeh$domestication_bin[i] <- 1
  } else if (includeh$domestication[i] == "Partially-domesticated") {
    includeh$domestication_bin[i] <- 2
  } else if (includeh$domestication[i] == "Wild") {
    includeh$domestication_bin[i] <- 3
  }
}

includeh$gtrends_bin <- ifelse(includeh$sum_gtrends == 0, 0, 1)


#add h-index of conserv* to the master df

conserv <- read_csv("outputs/hindex_conserv.csv")[-c(1)]
conserv_select <- conserv[, c("genus_species", "h")]
conserv_select <- conserv_select %>%
  rename(h_conserv = h)
conserv_select$genus_species <- str_replace_all(conserv_select$genus_species, "_", " ")

includeh <- left_join(includeh, conserv_select)

includeh$logh1_conserv <- log10(includeh$h_conserv+1)

#count complete cases

complete_list <- data.frame() #3393 records
for (i in 1:length(includeh$genus_species)) {
  if (!is.na(includeh$BodyMass.Value[i]) & !is.na(includeh$median_lat[i]) & !is.na(includeh$redlistCategory[i])) {
    complete_list <- rbind(complete_list, includeh[i,])
  }
}

#change above variables to discrete

complete_list$iucn_bin <- as.factor(complete_list$iucn_bin)
complete_list$humanuse_bin <- as.factor(complete_list$humanuse_bin)
complete_list$domestication_bin <- as.factor(complete_list$domestication_bin)

#correlation matrix of complete cases

ggpairs(complete_list, columns = c(10, 40, 20, 46, 47, 48, 49),
        aes(colour = clade),
        upper = list(combo = wrap("box",
                                  alpha = 0.3),
                     mapping = aes(fill = clade)),
        lower = list(continuous = wrap("smooth",
                                       alpha = 0.3),
                     discrete = "facetbar",
                     combo = "facetdensity"),
        diag = list(continuous = wrap("densityDiag",
                                     alpha = 0.5))) +
  scale_colour_manual(values = c("#f1c40f", "#e67e22", "#e74c3c", "#8e44ad", "#3498db"))

#get tree for complete cases

tree_complete <- tol_induced_subtree(ott_ids = complete_list$id, label_format = "name")
  
#h & mass

table(includeh$BodyMass.SpecLevel)
#0 inferred from genus of family typical values = 703 species
#1 based on species level data = 3276 species
#2 based on phylogenetically imputed values = 502 species
sum(is.na(includeh$BodyMass.SpecLevel))
#NA = 2308 species

summary(lm(h ~ BodyMass.Value, includeh)) 
summary(glm(h ~ BodyMass.Value, includeh, family = poisson))
summary(glmmTMB(h ~ BodyMass.Value, includeh, ziformula = ~1, family = poisson))

#h & phylogeny

#h & latitude

summary(lm(h ~ median_lat, includeh))

#h & iucn

summary(aov(h ~ iucn_bin, includeh))

#h & human use

summary(aov(h ~ humanuse_bin, includeh))

#h & domestication

summary(aov(h ~ domestication_bin, includeh))



# get phylo
tree <- read.tree(here("intermediate_data", "tree.tre"))
tree <- compute.brlen(tree) 
tree_complete <- compute.brlen(tree_complete) 

# this seems to make correlation matrix anyways!!!
cov_tree <- vcv2(tree, corr = FALSE)

#ultrametric(tree)

#testing
# wrong model but it is a nice start

mod1 <- glm(h ~ logmass + 
              abs(median_lat) + 
              I(scale(median_lat)^2) + 
              scale(iucn_bin) + 
              I(scale(iucn_bin)^2)  + # original hypothesis has this
              humanuse_bin + 
              domestication_bin + 
              log_sumgtrends, 
            family = "quasipoisson", 
            data = includeh)
summary(mod1)
vif(mod1)

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

# pglmm

includeh$sp <- includeh$genus_species

mod_p <-  pglmm(h ~ logmass + 
                     #scale(median_lat) + 
                     #I(scale(median_lat)^2) + 
                     #scale(iucn_bin) + 
                     # I(scale(iucn_bin)^2)  + # original hypothesis has this
                     #humanuse_bin + 
                     #domestication_bin +
                     #gtrends_bin +
                     (1 |sp__), 
                   cov_ranef = list(sp = cov_tree),
                   add.obs.re = TRUE,
                   family  = "poisson",
                   data = includeh,
                   verbose = TRUE)
summary(mod_p)  



# forget about this 
# phylo model

mod3 <- phyloglm(h ~ logmass + 
              scale(abs(median_lat)) + 
              #I(scale(median_lat)^2) + 
              scale(iucn_bin) + 
              # I(scale(iucn_bin)^2)  + # original hypothesis has this
              humanuse_bin + 
              domestication_bin + 
              gtrends_bin, 
            data = includeh,
            phy = tree,
            method  = "poisson_GEE")
summary(mod2)  


row.names(complete_list)<-complete_list$genus_species
#phylo model of only the complete cases
mod3 <- phyloglm(h ~ scale(logmass) + #still not working
                   scale(abs(median_lat)) + 
                   #I(scale(median_lat)^2) + 
                   scale(iucn_bin) + 
                   # I(scale(iucn_bin)^2)  + # original hypothesis has this
                   scale(humanuse_bin) + 
                   scale(domestication_bin) + 
                   scale(gtrends_bin), 
                 data = complete_list,
                 phy = tree_complete,
                 method  = "poisson_GEE")
summary(mod3)

