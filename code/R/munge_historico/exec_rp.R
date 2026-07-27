library(relatorios)
source("code/R/lib/set_criterios_desp.R")
source("code/R/lib/demonstrativo_fiscal.R")

#====================================================================
# preparacao dos dados
base <- execucao::exec_rp

#====================================================================
# aplicacao de criterios
base$BASE <- "EXEC"

# coluna ANO nao armazena ano que deve ser usado para fins de criterios
base[, tmp := ANO]
base[, ANO := ANO_ORIGEM_RP]

base <- adiciona_desc_desp(base)
base <- add_criterios_desp(base)

base[, ANO := tmp]
base[, tmp := NULL]

#====================================================================
# exportacao dos dados
write.csv2(base, "data-historico/exec_rp.csv", row.names = FALSE, na="", fileEncoding = "UTF-8")

