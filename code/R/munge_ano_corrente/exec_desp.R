library(relatorios)
library(data.table)
source("code/R/lib/set_criterios_desp.R")
source("code/R/lib/demonstrativo_fiscal.R")

#====================================================================
# preparacao das bases
base <- base <- extract_base_aid(
  repo_aid = "dados-armazem-siafi-2026",
  base_dcaf = "exec_desp"
)
setDT(base)
#====================================================================
# aplicacao de criterios base data-raw (ano atual)
base$BASE <- "EXEC"
base <- add_criterios_desp(base)

#====================================================================
# aplicação de critérios finais
base <- add_uo_setor(base)
base <- adiciona_desc_desp(base)

#====================================================================
# Adição de critérios de pessoal
base <- add_evento(base, overwrite = TRUE)
base <- add_uo_inativo(base)

#====================================================================
# Ajustes finais
base$VL <- base$VL_EMP

base[, DATA_EXEC := paste(ANO, formatC(MES_COD, width = 2, flag = "0"), "01", sep = "-")]


#======================== Data de Atualização

library(httr2)
library(data.table)

owner <- "splor-mg"
repo  <- "dados-armazem-siafi-2026"

resp <- request(sprintf(
  "https://api.github.com/repos/%s/%s/commits",
  owner, repo
)) |>
  req_url_query(
    path = "data",
    per_page = 1
  ) |>
  req_auth_bearer_token(Sys.getenv("GITHUB_SPLOR_PAT")) |>
  req_perform()

commit <- resp_body_json(resp)

DATA_ATUALIZACAO <- as.POSIXct(
  commit[[1]]$commit$author$date,
  format = "%Y-%m-%dT%H:%M:%SZ",
  tz = "UTC"
)

base[, DATA_ATUALIZACAO := DATA_ATUALIZACAO]

#====================================================================
# exportacao dos dados
write.csv2(base, "data/exec_desp.csv", row.names = FALSE, na="", fileEncoding = "UTF-8")




