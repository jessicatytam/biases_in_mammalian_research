# Biases in mammalian research

## Data
The main [dataset](data/intermediate/includeh.csv) was created from combining the raw data (data [here](data/raw); code [here](R/combine_again.R)) with citation data extracted from Scopus (data [here](data/intermediate/scopus_results1.RDS) and [here](data/intermediate/scopus_results2.RDS); code [here](R/mammal_list_query_script.R)).

## Plots
Please refer to the following links to code and data to recreate the plots.

### Main text
[Figure 1](https://github.com/jessicatytam/biases_in_mammalian_research/blob/829ecc425e0d7459211a2c78cc29f258e12de641/R/plots.R#L85-L143)\
[Figure 2](https://github.com/jessicatytam/biases_in_mammalian_research/blob/829ecc425e0d7459211a2c78cc29f258e12de641/R/plots.R#L437-L725)\
[Figure 3](https://github.com/jessicatytam/biases_in_mammalian_research/blob/829ecc425e0d7459211a2c78cc29f258e12de641/R/plots.R#L368-L394)\
[Figure 4](https://github.com/jessicatytam/biases_in_mammalian_research/blob/829ecc425e0d7459211a2c78cc29f258e12de641/R/plots.R#L727-L876)

### Supplementary materials
[Table S1](R/table_data_completeness.R)\
[Figure S2](data/h-index.xlsx)\
[Table S3](R/vif.R)\
[Figure S4](https://github.com/jessicatytam/biases_in_mammalian_research/blob/829ecc425e0d7459211a2c78cc29f258e12de641/R/plots.R#L75-L83)\
[Figure S5](https://github.com/jessicatytam/biases_in_mammalian_research/blob/829ecc425e0d7459211a2c78cc29f258e12de641/R/plots.R#L176-L199)\
[Figure S6](https://github.com/jessicatytam/biases_in_mammalian_research/blob/829ecc425e0d7459211a2c78cc29f258e12de641/R/plots.R#L203-L301)\
[Figure S7](https://github.com/jessicatytam/biases_in_mammalian_research/blob/829ecc425e0d7459211a2c78cc29f258e12de641/R/plots.R#L396-L435)

## MCMCglmm
Data used to run the models in Table 2 & 3 can be found [here](MCMCglmm/data).\
[Code](MCMCglmm/model_1/R) and [output](MCMCglmm/model_1/outputs) of the model in Table 2 can be found [here](MCMCglmm/model_1).\
[Code](MCMCglmm/model_2/R) and [output](MCMCglmm/model_2/outputs) of the model in Table 3 can be found [here](MCMCglmm/model_2).
