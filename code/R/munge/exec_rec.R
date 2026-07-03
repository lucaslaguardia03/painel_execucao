library(relatorios)
library(dplyr)
source("code/R/lib/set_criterios_rec.R", encoding = "UTF-8")
source("code/R/lib/demonstrativo_fiscal.R")

#====================================================================
# preparacao dos dados
base <- execucao::exec_rec

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
write.csv2(base, "data-historico/exec_rec.csv", row.names = FALSE, na="", fileEncoding = "UTF-8")


#====================================================================
# Cria tabela auxiliar para incluir informações referentes à receita nas colunas 'EXEC_LIQ' e 'EXEC_PAGO' dos quadros constitucionais

exec_rec_auxiliar <- left_join(base %>% filter(MDE==TRUE) %>% group_by(ANO) %>% 
                              summarise(Base_Calculo_MDE=sum(VL_EFET_AJUST)),
                               base %>% filter(ASPS==TRUE) %>% group_by(ANO) %>% 
                              summarise(Base_Calculo_ASPS=sum(VL_EFET_AJUST)))

# Incorpora outras informações referentes à receita na tabela auxiliar:

exec_rec_auxiliar <- left_join(exec_rec_auxiliar,
                   base %>% filter(RECEITA_COD_2%in%c(1321001101000,1321010101000), FONTE_COD %in% c(13,23)) %>% group_by(ANO) %>%
                     		 summarise(Aplicacao_fin=sum(VL_EFET_AJUST)))

base_fundeb <- base %>% filter(PERDA_FUNDEB==TRUE & ANO!=2020 | ANO==2020 & PERDA_FUNDEB==TRUE & !nat(RECEITA_COD_2, 1758011103005, 1758011107005, 1758011108005)) %>% group_by(ANO) %>%
                        summarise(Perda_FUNDEB=sum(VL_EFET_AJUST))

base_fundeb$Perda_FUNDEB <- if_else(base_fundeb$ANO==2021, base_fundeb$Perda_FUNDEB - 1969714840,
                            if_else(base_fundeb$ANO==2022, base_fundeb$Perda_FUNDEB - 1477286130,
                                    base_fundeb$Perda_FUNDEB))

exec_rec_auxiliar <- left_join(exec_rec_auxiliar, base_fundeb)

exec_rec_auxiliar <- left_join(exec_rec_auxiliar, 
                   base %>% filter(nat(RECEITA_COD_2, 9) & FONTE_COD == 23) %>% group_by(ANO) %>%
                      		  summarise(Ida_FUNDEB=sum(VL_EFET_AJUST)))


exec_rec_auxiliar$Aplicacao_fin <- if_else(is.na(exec_rec_auxiliar$Aplicacao_fin), 0, exec_rec_auxiliar$Aplicacao_fin)


# exportacao dos dados
write.csv2(exec_rec_auxiliar, "data-historico/exec_rec_auxiliar.csv", row.names = FALSE, na="", fileEncoding = "UTF-8")
