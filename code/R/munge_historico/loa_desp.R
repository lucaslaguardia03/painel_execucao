library(relatorios)
source("code/R/lib/set_criterios_desp.R")
source("code/R/lib/demonstrativo_fiscal.R")

#====================================================================
# preparacao dos dados
base <- execucao::loa_desp

#====================================================================
# aplicacao de criterios
base$BASE <- "LOA"
base$MES_COD <- NA
base <- adiciona_desc_desp(base)
base <- add_criterios_desp(base)

#====================================================================
# exportacao dos dados
write.csv2(base, "data-historico/loa_desp.csv", row.names = FALSE, na="", fileEncoding = "UTF-8")
