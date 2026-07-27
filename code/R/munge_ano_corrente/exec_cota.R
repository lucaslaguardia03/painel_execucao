library(relatorios)
library(data.table)
source("code/R/lib/set_criterios_desp.R")
source("code/R/lib/demonstrativo_fiscal.R")

#====================================================================
# preparacao dos dados
# Descobrimos que esta função:

# =========================== Avaliado em 06/02/2026==================
# trabalha o excel que vem do BO e padroniza nome de campos.
# Não precisaremos mais desta função a partir do uso do DPM e do dpm install.
# Faremos a troca do nome das colunas diretamente na transformação Python
# ===========================
base <- base <- extract_base_aid(
  repo_aid = "dados-armazem-siafi-2026",
  base_dcaf = "exec_cota"
)


#====================================================================
# buscando a informacao de funcao na base de credito autorizado
cred_aut_desp <- extract_base_aid(
  repo_aid = "dados-armazem-siafi-2026",
  base_dcaf = "exec_cred_aut_desp"
)
cred_aut_desp <- cred_aut_desp %>%
                  dplyr::group_by(UO_COD, ACAO_COD, FUNCAO_COD, GRUPO_COD, IAG_COD, FONTE_COD, IPU_COD) %>%
                  dplyr::summarise(FUNCAO_COD=FUNCAO_COD)

base <- unique(dplyr::left_join(base, cred_aut_desp))

#====================================================================
# aplicacao de criterios
base$BASE <- "COTA"
base$MES_COD <- NA
base$MODALIDADE_COD <- 0
setDT(base)
# Avaliado em 06/02/2026
# Essas ações sempre serão modalidades 91?
base <- base[ACAO_COD %in% c(4263, 4290, 4520, 4254, 4244, 4243, 4287, 2057, 2030, 2031, 2036), MODALIDADE_COD := 91]
base$ELEMENTO_COD <- 0
base$ELEMENTO_ITEM_COD <- 0
base <- adiciona_desc_desp(base)
base <- base[is.na(ITEM_COD), ITEM_COD := 0]
base <- add_criterios_desp_reest_loa(base)

#====================================================================
# exportacao dos dados
write.csv2(base, "data/exec_cota.csv", row.names = FALSE, na="", fileEncoding = "UTF-8")

