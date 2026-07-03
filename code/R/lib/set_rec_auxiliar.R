library(dplyr)

add_rec_auxiliar <- function(base) {

  # Cria tabela auxiliar para incluir informações referentes à receita nas colunas 'EXEC_LIQ' e 'EXEC_PAGO' dos quadros constitucionais
  exec_rec_auxiliar <- left_join(base %>% filter(MDE==TRUE) %>% group_by(ANO) %>%
                                 summarise(Base_Calculo_MDE=sum(VL_EFET_AJUST)),
                                 base %>% filter(ASPS==TRUE) %>% group_by(ANO) %>%
                                 summarise(Base_Calculo_ASPS=sum(VL_EFET_AJUST)))

  # Incorpora outras informações referentes à receita na tabela auxiliar:
  exec_rec_auxiliar <- left_join(exec_rec_auxiliar,
                                base %>%
                                  filter(RECEITA_COD_2%in%c(1321001101000,1321010101000), FONTE_COD %in% c(13,23)) %>%
                                  group_by(ANO) %>%
                                  summarise(Aplicacao_fin=sum(VL_EFET_AJUST)))

  base_fundeb <- base %>%
    filter(PERDA_FUNDEB==TRUE & ANO!=2020 | ANO==2020 & PERDA_FUNDEB==TRUE & !nat(RECEITA_COD_2, 1758011103005, 1758011107005, 1758011108005)) %>%
    group_by(ANO) %>%
    summarise(Perda_FUNDEB=sum(VL_EFET_AJUST)) %>%
    mutate(Perda_FUNDEB = if_else(ANO == 2021, Perda_FUNDEB - 1969714840,
                                  if_else(ANO == 2022, Perda_FUNDEB - 1477286130, Perda_FUNDEB)))

  exec_rec_auxiliar <- left_join(exec_rec_auxiliar, base_fundeb)

  exec_rec_auxiliar <- left_join(exec_rec_auxiliar, base %>%
                                 filter(nat(RECEITA_COD_2, 9) & FONTE_COD == 23) %>%
                                 group_by(ANO) %>%
                                 summarise(Ida_FUNDEB=sum(VL_EFET_AJUST)))

  exec_rec_auxiliar$Aplicacao_fin <- if_else(is.na(exec_rec_auxiliar$Aplicacao_fin), 0, exec_rec_auxiliar$Aplicacao_fin)

  return(exec_rec_auxiliar)
  
}
