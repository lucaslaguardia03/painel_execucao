library(relatorios)
source("code/R/lib/set_criterios_desp.R")
source("code/R/lib/demonstrativo_fiscal.R")

#====================================================================
# preparacao dos dados
base <- execucao::ldo_desp

#====================================================================
# aplicacao de criterios
base$BASE <- "LDO"

# coluna ANO nao armazena ano que deve ser usado para fins de criterios
base[, tmp := ANO]
base[, ANO := ANO_REF - 1]

base <- adiciona_desc_desp(base)
base <- add_criterios_desp(base)

base[, ANO := tmp]
base[, tmp := NULL]

#====================================================================
# exportacao dos dados
write.csv2(base, "data-historico/ldo_desp.csv", row.names = FALSE, na="", fileEncoding = "UTF-8")
