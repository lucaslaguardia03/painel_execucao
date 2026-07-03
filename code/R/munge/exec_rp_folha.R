library(relatorios)
source("code/R/lib/set_criterios_desp.R")
source("code/R/lib/demonstrativo_fiscal.R")

#====================================================================
# preparacao dos dados
base <- execucao::exec_rp_folha

#====================================================================
# aplicacao de criterios
base$BASE <- "EXEC"

# coluna ANO nao armazena ano que deve ser usado para fins de criterios
base[, tmp := ANO]
base[, ANO := ANO_ORIGEM_RP]

base <- adiciona_desc_desp(base)
base[, INTRA := FALSE]
base[, INTRA := ifelse(MODALIDADE_COD == 91, TRUE, FALSE)]
base[, TRANSITA := transita(base)]

base[, ANO := tmp]
base[, tmp := NULL]

#====================================================================
# exportacao dos dados
write.csv2(base, "data-historico/exec_rp_folha.csv", row.names = FALSE, na="", fileEncoding = "UTF-8")
