library(relatorios)
source("code/R/lib/set_criterios_desp.R")
source("code/R/lib/demonstrativo_fiscal.R")

#====================================================================
# preparacao dos dados
base <- execucao::exec_pago_orc

#====================================================================
# aplicacao de criterios
base$BASE <- "EXEC"
base$MES_COD <- NA
base <- adiciona_desc_desp(base)
base <- add_criterios_desp(base)

#base[, DATA_EXEC := paste(ANO, formatC(MES_COD, width = 2, flag = "0"), "01", sep = "-")]
#====================================================================
# exportacao dos dados
write.csv2(base, "data-historico/exec_pago_orc.csv", row.names = FALSE, na="", fileEncoding = "UTF-8")



# Cria base e coluna com os valores da despesa paga (pago orc)
base$BASE <- "EXEC_PAGO"
base$VL <- base$VL_PAGO_ORC
base <- base[,c("VL_PAGO_ORC") := NULL]

#====================================================================
# exportacao dos dados
write.csv2(base, "data-historico/exec_desp_pago.csv", row.names = FALSE, na="", fileEncoding = "UTF-8")

