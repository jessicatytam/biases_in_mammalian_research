# Biases in mammalian research

## Data
The main [dataset](data/intermediate/includeh.csv) was created from combining the raw data (data [here](data/raw); code [here](R/combine_again.R)) with citation data extracted from Scopus (data [here](https://zenodo.org/record/5711932#.Yq_R7iYRVGo); code [here](R/mammal_list_query_script.R)).

## Plots
Please refer to the following links to code and data to recreate the plots.

### Main text
Figure 1 - [here](https://github.com/jessicatytam/biases_in_mammalian_research/blob/2c86092f1f6c71fbc819beb37d8104d93ac81c2e/R/plots.R#L87-L130) and [here](https://github.com/jessicatytam/biases_in_mammalian_research/blob/2c86092f1f6c71fbc819beb37d8104d93ac81c2e/R/model_without_domesticated_spp.R#L272-L306)\
[Figure 2](https://github.com/jessicatytam/biases_in_mammalian_research/blob/829ecc425e0d7459211a2c78cc29f258e12de641/R/plots.R#L948-L1037)\
[Figure 3](https://github.com/jessicatytam/biases_in_mammalian_research/blob/829ecc425e0d7459211a2c78cc29f258e12de641/R/plots.R#L477-L621)\
Figure 4 - [here](https://github.com/jessicatytam/biases_in_mammalian_research/blob/829ecc425e0d7459211a2c78cc29f258e12de641/R/plots.R#L1111-L1260) and [here](https://github.com/jessicatytam/biases_in_mammalian_research/blob/2c86092f1f6c71fbc819beb37d8104d93ac81c2e/R/model_without_domesticated_spp.R#L308-L458)

### Supplementary materials
[Table S1](R/table_data_completeness.R)\
[Table S3](R/vif.R)\
[Figure S4](https://github.com/jessicatytam/biases_in_mammalian_research/blob/2c86092f1f6c71fbc819beb37d8104d93ac81c2e/R/plots_again.R#L77-L85)\
[Figure S5](https://github.com/jessicatytam/biases_in_mammalian_research/blob/2c86092f1f6c71fbc819beb37d8104d93ac81c2e/R/plots_again.R#L305-L328)\
[Figure S6](https://github.com/jessicatytam/biases_in_mammalian_research/blob/2c86092f1f6c71fbc819beb37d8104d93ac81c2e/R/plots_again.R#L332-L430)\
[Figure S7](https://github.com/jessicatytam/biases_in_mammalian_research/blob/2c86092f1f6c71fbc819beb37d8104d93ac81c2e/R/plots_again.R#L718-L757)\
[Figure S8](https://github.com/jessicatytam/biases_in_mammalian_research/blob/2c86092f1f6c71fbc819beb37d8104d93ac81c2e/R/plots_again.R#L108-L165)

## MCMCglmm
Data used to run the models in Table 2 & 3 can be found [here](MCMCglmm/data).\
<<<<<<< HEAD
Scripts to run and clean the model in Table 2 can be found [here](MCMCglmm/model_1_nt/R).\
Scripts to run and clean the model in Table 3 can be found [here](MCMCglmm/model_2_nt/R).\
Results of models were uploaded to [zenodo](https://zenodo.org/record/6644032#.Yq_RSSYRVGo).

