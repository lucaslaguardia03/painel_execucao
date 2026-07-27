library(relatorios)
library(data.table)
source("code/R/lib/set_criterios_desp.R")
source("code/R/lib/demonstrativo_fiscal.R")

#====================================================================
# preparacao dos dados
base <- extract_base_aid(
  repo_aid = "dados-armazem-siafi-2026",
  base_dcaf = "exec_suplementacao"
)
setDT(base)
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
write.csv2(base, "data/exec_suplementacao.csv", row.names = FALSE, na="", fileEncoding = "UTF-8")

#Remover UO_FIN_COD de extract_bases_aid?