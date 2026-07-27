library(relatorios)
source("code/R/lib/set_criterios_desp.R")
source("code/R/lib/demonstrativo_fiscal.R")

#====================================================================
# preparacao dos dados
base <- extract_base_aid(
  repo_aid = "dados-armazem-siafi-2026",
  base_dcaf = "exec_alem_credito"
)

#====================================================================
# aplicacao de criterios
base <- adiciona_desc_desp(base)

base$ALEM_CRED <- base$alem_credito
base <- base[,-"alem_credito"]
base$REGULARIZADO <- base$regularizado
base <- base[,-"regularizado"]
base$ANULADO <- base$anulado
base <- base[,-"anulado"]

base <- add_criterios_desp(base)

base$BASE <- "ALEM_CRED"

#====================================================================
# exportacao dos dados
write.csv2(base, "data/exec_alem_credito.csv", row.names = FALSE, na="", fileEncoding = "UTF-8")
