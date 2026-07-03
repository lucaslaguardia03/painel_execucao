library(relatorios)
source("code/R/lib/set_criterios_rec.R")
source("code/R/lib/demonstrativo_fiscal.R")

#====================================================================
# preparacao dos dados
base <- execucao::loa_rec

#====================================================================
# aplicacao de criterios
base$BASE <- "LOA"
base <- adiciona_desc_rec(base)
base <- add_criterios_rec(base)
base$RECEITA_DESC_2 = NULL
base[ANO >= 2018, RECEITA_COD_2 := RECEITA_COD]

#====================================================================
# exportacao dos dados
write.csv2(base, "data-historico/loa_rec.csv", row.names = FALSE, na="", fileEncoding = "UTF-8")
