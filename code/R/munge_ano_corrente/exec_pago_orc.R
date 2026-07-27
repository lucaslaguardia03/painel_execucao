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

base[, DATA_EXEC := paste(ANO, formatC(MES_COD, width = 2, flag = "0"), "01", sep = "-")]
#====================================================================
# exportacao dos dados
write.csv2(base, "data/exec_pago_orc.csv", row.names = FALSE, na="", fileEncoding = "UTF-8")

teste <- relatorios:::get_resource("dados-armazem-siafi-2026","alteracoes_orcamentarias",Sys.getenv("GITHUB_SPLOR_PAT"))
