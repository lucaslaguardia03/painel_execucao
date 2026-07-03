adiciona_desc_rec <- function(base) {
  base <- adiciona_desc(base, overwrite = TRUE, expand = TRUE)
  base <- add_poder(base)
  return(base[])
}
  
add_criterios_rec <- function(base) {

  base[, MDE := is_mde_rec(base)]
  base[, FAPEMIG := is_fapemig_rec(base)]
  base[, INTRA := FALSE]
  base[, INTRA := ifelse(nat(RECEITA_COD, 7), TRUE, FALSE)]
  base[, TRANSITA := transita(base)]
  base[, ASPS := is_asps_rec(base)]
  base[, INTRA_SAUDE := is_intra_saude_rec(base)]
  base[, PRIMARIO := is_primario_rec(base)]
  base[, FONTE_STN := is_fonte_stn_rec(base)]

  base[, RCL := is_rcl(base)]
  base[, RCL_PESSOAL := is_rcl_pessoal(base)]
  base[, RCL_DIVIDA := is_rcl_divida(base)]
  base[, PERDA_FUNDEB := is_perda_fundeb(base)]
  base[, SEF := is_receita_SEF(base)]
  base[, PREV := is_rec_prev(base)]

  base <- add_demonst_grupo_rec(base)
  base <- add_demonst_matriz_rec(base)
  base <- add_demonstrativo_rec(base)
  base <- demonstrativo_fontes(base)


  base[, TIPO := "REC"]

  return(base[])
}
