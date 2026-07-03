library(relatorios)
source("code/R/lib/set_criterios_desp.R")
source("code/R/lib/demonstrativo_fiscal.R")

#====================================================================
# preparacao das bases
base_anteriores <- execucao::exec_desp

#====================================================================
## adiciona critérios nos anos anteriores -- não pode ser feita a junção antes, pois a adição artificial da coluna UO_FIN_COD atrapalharia na aplicação da função is_teto_propag
base_anteriores$BASE <- "EXEC"
base_anteriores <- add_criterios_desp(base_anteriores)
base_anteriores$UO_FIN_COD <- 0

#====================================================================
# Aplicação de critérios finais
base <- adiciona_desc_desp(base_anteriores)

#====================================================================
# Adição de critérios de pessoal
base <- add_evento(base, overwrite = TRUE)
base <- add_uo_inativo(base)

#====================================================================
# Ajustes finais
base$VL <- base$VL_EMP

base[, DATA_EXEC := paste(ANO, formatC(MES_COD, width = 2, flag = "0"), "01", sep = "-")]
#====================================================================
# exportacao dos dados
write.csv2(base, "data-historico/exec_desp.csv", row.names = FALSE, na="", fileEncoding = "UTF-8")


# Cria base e coluna com os valores da despesa liquidada
base$BASE <- "EXEC_LIQ"
base$VL <- base$VL_LIQ
base <- base[,c("VL_EMP", "VL_LIQ", "VL_PAGO_FIN") := NULL]

#====================================================================
# exportacao dos dados
write.csv2(base, "data-historico/exec_desp_liq.csv", row.names = FALSE, na="", fileEncoding = "UTF-8")



