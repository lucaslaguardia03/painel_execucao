library(relatorios)
source("code/R/lib/set_criterios_desp.R")
source("code/R/lib/demonstrativo_fiscal.R")

#====================================================================
# preparacao dos dados
base <- execucao::exec_suplementacao

#====================================================================
# aplicacao de criterios
base$BASE <- "EXEC"
base$ELEMENTO_COD <- 0
base$ELEMENTO_ITEM_COD <- 0
base <- adiciona_desc_desp(base)
base <- base[is.na(ITEM_COD), ITEM_COD := 0]
base <- add_criterios_desp(base)
base$VL_CRED_AUT_TOTAL <- base$VL_CRED_AUT
base[, VL_CRED_AUT := NULL]

#====================================================================
# exportacao dos dados
write.csv2(base, "data-historico/exec_suplementacao.csv", row.names = FALSE, na="", fileEncoding = "UTF-8")
