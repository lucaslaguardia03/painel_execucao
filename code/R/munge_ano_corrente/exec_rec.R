library(relatorios)
library(dplyr)
source("code/R/lib/set_criterios_rec.R", encoding = "UTF-8")
source("code/R/lib/demonstrativo_fiscal.R")

#====================================================================
# preparacao dos dados
base <- extract_base_aid(
  repo_aid = "dados-armazem-siafi-2026",
  base_dcaf = "exec_rec"
)
#====================================================================
# aplicacao de criterios
base <- adiciona_desc_rec(base)
base <- add_criterios_rec(base)
base$BASE <- "EXEC"
base[, DATA_EXEC := paste(ANO, formatC(MES_COD, width = 2, flag = "0"), "01", sep = "-")]

base = add_de_para_receita(base)
base$RECEITA_DESC_2 = NULL
base[ANO >= 2018, RECEITA_COD_2 := RECEITA_COD]

#====================================================================
# exportacao dos dados
write.csv2(base, "data/exec_rec.csv", row.names = FALSE, na="", fileEncoding = "UTF-8")


