library(relatorios)
source("code/R/lib/set_criterios_desp.R")
source("code/R/lib/demonstrativo_fiscal.R")

#====================================================================
# preparacao dos dados
base <- base <- extract_base_aid(
  repo_aid = "dados-armazem-siafi-2026",
  base_dcaf = "exec_cred_aut_desp"
)


#====================================================================
# aplicacao de criterios
base$MES_COD <- NA
base$ELEMENTO_COD <- 0
base$ELEMENTO_ITEM_COD <- 0
base <- adiciona_desc_desp(base)
base <- base[is.na(ITEM_COD), ITEM_COD := 0]
base <- add_criterios_desp_reest_loa(base)
base$BASE <- "CRED_AUT"

#====================================================================
# exportacao dos dados
write.csv2(base, "data/exec_cred_aut_desp.csv", row.names = FALSE, na="", fileEncoding = "UTF-8")
