library(relatorios)
library(data.table)
source("code/R/lib/set_criterios_desp.R")
source("code/R/lib/demonstrativo_fiscal.R")

#====================================================================
# preparacao dos dados
base <- extract_base_aid(
  repo_aid = "dados-armazem-siafi-2026",
  base_dcaf = "exec_pago_orc"
)
setDT(base)
#====================================================================
# aplicacao de criterios
base$BASE <- "EXEC"
base$MES_COD <- NA
base <- adiciona_desc_desp(base)
base <- add_criterios_desp(base)

#====================================================================
# exportacao dos dados
write.csv2(base, "data/exec_pago_orc.csv", row.names = FALSE, na="", fileEncoding = "UTF-8")


