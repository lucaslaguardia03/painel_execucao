adiciona_desc_desp <- function(base) {
  base <- adiciona_desc(base, overwrite = TRUE)
  base <- add_poder(base)
  return(base)
}

add_criterios_desp <- function(base) {

  base[, MDE := is_mde_desp(base)]
  base[, ASPS := is_asps_desp(base, "ELEMENTO_ITEM_COD")]
  base[, FAPEMIG := is_fapemig_desp(base)]
  base[, INTRA := FALSE]
  base[, INTRA := ifelse(MODALIDADE_COD == 91, TRUE, FALSE)]
  base[, INTRA_SAUDE := is_intra_saude_desp(base, "ELEMENTO_ITEM_COD")]
  base[, OBRIG := is_obrig(base, "ELEMENTO_ITEM_COD")]
  base[, TRANSITA := transita(base)]
  base[, DTP := is_dtp(base)]
  base[, DBP := is_dbp(base)]
  base[, TETO_GASTO := is_teto_gasto(base)]
  base <- demonstrativo_fiscal_desp(base)
  base <- demonstrativo_fontes(base)
  base[, PRIMARIO := is_primario_desp(base)]
  base[ ,FONTE_STN := is_fonte_stn_desp(base)]
  base[, PREV := is_desp_prev(base)]
  base[, TETO_PROPAG := is_teto_propag(base)]
  base[, TIPO := "DESP"]
  
  return(base[])
}

add_criterios_desp_reest_loa <- function(base) {

  base[, MDE := is_mde_desp(base)]
  base[, ASPS := is_asps_desp(base, "ACAO_COD")]
  base[, FAPEMIG := is_fapemig_desp(base)]
  base[, INTRA := FALSE]
  base[, INTRA := ifelse(MODALIDADE_COD == 91, TRUE, FALSE)]
  base[, INTRA_SAUDE := is_intra_saude_desp(base, "ACAO_COD")]
  base[, OBRIG := is_obrig(base, "ACAO_COD")]
  base[, TRANSITA := transita(base)]
  base[, DTP := is_dtp(base)]
  base[, DBP := is_dbp(base)]
  base[, TETO_GASTO := is_teto_gasto(base)]
  base <- demonstrativo_fiscal_desp(base)
  base <- demonstrativo_fontes(base)
  base[, PRIMARIO := is_primario_desp(base)]
  base[ ,FONTE_STN := is_fonte_stn_desp(base)]
  base[, PREV := is_prev_loa_desp(base)]
  base[, TETO_PROPAG := is_teto_propag(base)]
  base[, TIPO := "DESP"]
  
  return(base[])
}

add_criterios_desp_ldo <- function(base) {
  
  #base[, MDE := is_mde_desp(base)]
  base[, ASPS := is_asps_desp(base, "ACAO_COD")]
  base[, FAPEMIG := is_fapemig_desp(base)]
  base[, INTRA := FALSE]
  base[, INTRA := ifelse(MODALIDADE_COD == 91, TRUE, FALSE)]
  base[, INTRA_SAUDE := is_intra_saude_desp(base, "ACAO_COD")]
  #base[, OBRIG := is_obrig(base, "ACAO_COD")]
  base[, TRANSITA := transita(base)]
  #base[, DTP := is_dtp(base)]
  #base[, DBP := is_dbp(base)]
  #base[, TETO_GASTO := is_teto_gasto(base)]
  #base <- demonstrativo_fiscal_desp(base)
  base <- demonstrativo_fontes(base)
  #base[, PRIMARIO := is_primario_desp(base)]
  #base[ ,FONTE_STN := is_fonte_stn_desp(base)]
  #base[, PREV := is_prev_loa_desp(base)]
  #base[, TETO_PROPAG := is_teto_propag(base)]
  base[, TIPO := "DESP"]
  
  return(base[])
}
