demonstrativo_fiscal_desp <- function(base) {


# NIVEL 1
  base[GRUPO_COD == 1, FISCAL_NIVEL1_DESP := "I. PESSOAL"]  
  base[GRUPO_COD == 3, FISCAL_NIVEL1_DESP := "II. CUSTEIO"]
  base[GRUPO_COD %in% c(4,5), FISCAL_NIVEL1_DESP := "III. INVESTIMENTOS E INVERSOES"]
  base[GRUPO_COD %in% c(2,6), FISCAL_NIVEL1_DESP := "IV. JUROS E AMORTIZACOES"] 
  base[GRUPO_COD == 9, FISCAL_NIVEL1_DESP := "V. RESERVA DE CONTINGENCIA"] 


# NIVEL 2

  base[FISCAL_NIVEL1_DESP == "I. PESSOAL" & is_mde_desp(base),
            FISCAL_NIVEL2_DESP := "I.1 Constitucionais"]
  base[FISCAL_NIVEL1_DESP == "I. PESSOAL" & is_asps_desp(base, "ACAO_COD"),
            FISCAL_NIVEL2_DESP := "I.1 Constitucionais"]
  base[FISCAL_NIVEL1_DESP == "I. PESSOAL" & is_fapemig_desp(base),
            FISCAL_NIVEL2_DESP := "I.1 Constitucionais"]
  base[FISCAL_NIVEL1_DESP == "I. PESSOAL" & FONTE_COD %in% c(13,23,90),
            FISCAL_NIVEL2_DESP := "I.2 Fundeb"]            
  base[FISCAL_NIVEL1_DESP == "I. PESSOAL" & is_outros_poderes(base), 
        FISCAL_NIVEL2_DESP := "I.3 Outros Poderes"]
  base[FISCAL_NIVEL1_DESP == "I. PESSOAL" & UO_COD %in% c(1911,1941,4461,4711) & is.na(FISCAL_NIVEL2_DESP),
            FISCAL_NIVEL2_DESP := "I.5 Demais - Inativos e Pensionistas"]
  base[FISCAL_NIVEL1_DESP == "I. PESSOAL" & ACAO_COD %in% c(7007,7002) & is.na(FISCAL_NIVEL2_DESP),
            FISCAL_NIVEL2_DESP := "I.5 Demais - Inativos e Pensionistas"]
  base[FISCAL_NIVEL1_DESP == "I. PESSOAL" & ACAO_COD %in% c(4016) & UO_COD == 2121 & is.na(FISCAL_NIVEL2_DESP),
            FISCAL_NIVEL2_DESP := "I.5 Demais - Inativos e Pensionistas"]
  base[FISCAL_NIVEL1_DESP == "I. PESSOAL" & is.na(FISCAL_NIVEL2_DESP),
            FISCAL_NIVEL2_DESP := "I.4 Demais - Ativos"]
  if("MES_COD" %in% names(base)){
  base[FISCAL_NIVEL1_DESP == "I. PESSOAL" & is_mde_desp(base) & UO_COD == 4461 & ANO == 2020 & MES_COD %in% c(7,8,9,10,11,12),
            FISCAL_NIVEL2_DESP := "I.5 Demais - Inativos e Pensionistas"]}


  base[FISCAL_NIVEL1_DESP == "II. CUSTEIO" & is_mde_desp(base),
            FISCAL_NIVEL2_DESP := "II.1 Constitucionais"]
  base[FISCAL_NIVEL1_DESP == "II. CUSTEIO" & is_asps_desp(base, "ACAO_COD"),
            FISCAL_NIVEL2_DESP := "II.1 Constitucionais"]
  base[FISCAL_NIVEL1_DESP == "II. CUSTEIO" & is_fapemig_desp(base),
            FISCAL_NIVEL2_DESP := "II.1 Constitucionais"]
  base[FISCAL_NIVEL1_DESP == "II. CUSTEIO" & FONTE_COD %in% c(13,23,90),
            FISCAL_NIVEL2_DESP := "II.2 Fundeb"]
  base[FISCAL_NIVEL1_DESP == "II. CUSTEIO" & UO_COD == 1911 & ACAO_COD == 7844,
            FISCAL_NIVEL2_DESP := "II.3 Transferencias aos Municipios"]
  base[FISCAL_NIVEL1_DESP == "II. CUSTEIO" & ACAO_COD == 7009, 
            FISCAL_NIVEL2_DESP := "II.4 Intra-orcamentarias (Saude e Comp. Previdenciaria)"] 
  base[FISCAL_NIVEL1_DESP == "II. CUSTEIO" & is_intra_saude_desp(base, "ACAO_COD"),
            FISCAL_NIVEL2_DESP := "II.4 Intra-orcamentarias (Saude e Comp. Previdenciaria)"]
  base[FISCAL_NIVEL1_DESP == "II. CUSTEIO" & is_outros_poderes(base), 
          FISCAL_NIVEL2_DESP := "II.6 Outros Poderes"]
  base[FISCAL_NIVEL1_DESP == "II. CUSTEIO" & IPU_COD == 7 & is.na(FISCAL_NIVEL2_DESP),
            FISCAL_NIVEL2_DESP := "II.5 Auxilios Executivo (exceto Constitucionais)"]  
  base[FISCAL_NIVEL1_DESP == "II. CUSTEIO" & !FONTE_COD %in% c(10,11,12,15,18,19,60) & is.na(FISCAL_NIVEL2_DESP), 
            FISCAL_NIVEL2_DESP := "II.7 Demais Recursos - Vinculados"]
  base[FISCAL_NIVEL1_DESP == "II. CUSTEIO" & is.na(FISCAL_NIVEL2_DESP),
            FISCAL_NIVEL2_DESP := "II.8 Demais Recursos - Nao Vinculados"] 


  base[FISCAL_NIVEL1_DESP == "III. INVESTIMENTOS E INVERSOES" & is_mde_desp(base),
            FISCAL_NIVEL2_DESP := "III.1 Constitucionais"]
  base[FISCAL_NIVEL1_DESP == "III. INVESTIMENTOS E INVERSOES" & is_asps_desp(base, "ACAO_COD"),
            FISCAL_NIVEL2_DESP := "III.1 Constitucionais"]
  base[FISCAL_NIVEL1_DESP == "III. INVESTIMENTOS E INVERSOES" & is_fapemig_desp(base),
            FISCAL_NIVEL2_DESP := "III.1 Constitucionais"]
  base[FISCAL_NIVEL1_DESP == "III. INVESTIMENTOS E INVERSOES" & FONTE_COD %in% c(13,23,90),
            FISCAL_NIVEL2_DESP := "III.2 Fundeb"]
  base[FISCAL_NIVEL1_DESP == "III. INVESTIMENTOS E INVERSOES" & is_outros_poderes(base), 
        FISCAL_NIVEL2_DESP := "III.3 Outros Poderes"]
  base[FISCAL_NIVEL1_DESP == "III. INVESTIMENTOS E INVERSOES" & !FONTE_COD %in% c(10,11,12,15,18,19,60) & is.na(FISCAL_NIVEL2_DESP), 
        FISCAL_NIVEL2_DESP := "III.4 Demais Recursos - Vinculados"]
  base[FISCAL_NIVEL1_DESP == "III. INVESTIMENTOS E INVERSOES" & is.na(FISCAL_NIVEL2_DESP),
            FISCAL_NIVEL2_DESP := "III.5 Demais Recursos - Nao Vinculados"] 


  base[FISCAL_NIVEL1_DESP == "IV. JUROS E AMORTIZACOES" & GRUPO_COD==2,
            FISCAL_NIVEL2_DESP := "IV.1 Juros"] 
  base[FISCAL_NIVEL1_DESP == "IV. JUROS E AMORTIZACOES" & GRUPO_COD==6,
            FISCAL_NIVEL2_DESP := "IV.2 Amortizacoes"]

  base[FISCAL_NIVEL1_DESP == "V. RESERVA DE CONTINGENCIA",
       FISCAL_NIVEL2_DESP := "V. RESERVA DE CONTINGENCIA"]


# NIVEL 3

  base[FISCAL_NIVEL2_DESP == "I.1 Constitucionais" & is_mde_desp(base),
            FISCAL_NIVEL3_DESP := "I.1.1 Educacao"]
  base[FISCAL_NIVEL2_DESP == "I.1 Constitucionais" & is_asps_desp(base, "ACAO_COD"),
            FISCAL_NIVEL3_DESP := "I.1.2 Saude"]            
  base[FISCAL_NIVEL2_DESP == "I.1 Constitucionais" & is_fapemig_desp(base),
            FISCAL_NIVEL3_DESP := "I.1.3 Fapemig"]
  base[FISCAL_NIVEL2_DESP == "I.2 Fundeb",
            FISCAL_NIVEL3_DESP := "I.2 Fundeb"]
  base[FISCAL_NIVEL2_DESP == "I.3 Outros Poderes",
            FISCAL_NIVEL3_DESP := "I.3 Outros Poderes"]
  base[FISCAL_NIVEL2_DESP == "I.4 Demais - Ativos",
            FISCAL_NIVEL3_DESP := "I.4 Demais - Ativos"]
  base[FISCAL_NIVEL2_DESP == "I.5 Demais - Inativos e Pensionistas",
            FISCAL_NIVEL3_DESP := "I.5 Demais - Inativos e Pensionistas"]


  base[FISCAL_NIVEL2_DESP == "II.1 Constitucionais" & is_mde_desp(base),
            FISCAL_NIVEL3_DESP := "II.1.1 Educacao"]
  base[FISCAL_NIVEL2_DESP == "II.1 Constitucionais" & is_asps_desp(base, "ACAO_COD"),
            FISCAL_NIVEL3_DESP := "II.1.2 Saude"]            
  base[FISCAL_NIVEL2_DESP == "II.1 Constitucionais" & is_fapemig_desp(base),
            FISCAL_NIVEL3_DESP := "II.1.3 Fapemig"]
  base[FISCAL_NIVEL2_DESP == "II.2 Fundeb",
            FISCAL_NIVEL3_DESP := "II.2 Fundeb"]     
  base[FISCAL_NIVEL2_DESP == "II.3 Transferencias aos Municipios",
            FISCAL_NIVEL3_DESP := "II.3 Transferencias aos Municipios"]           
  base[FISCAL_NIVEL2_DESP == "II.4 Intra-orcamentarias (Saude e Comp. Previdenciaria)" & ACAO_COD == 7009, 
            FISCAL_NIVEL3_DESP := "II.4.1 Complementacao Previdenciaria"] 
  base[FISCAL_NIVEL2_DESP == "II.4 Intra-orcamentarias (Saude e Comp. Previdenciaria)" & is_intra_saude_desp(base, "ACAO_COD"),
            FISCAL_NIVEL3_DESP := "II.4.2 Intra-Saude"]
  base[FISCAL_NIVEL2_DESP == "II.5 Auxilios Executivo (exceto Constitucionais)",
            FISCAL_NIVEL3_DESP := "II.5 Auxilios Executivo (exceto Constitucionais)"] 
  base[FISCAL_NIVEL2_DESP == "II.6 Outros Poderes",
            FISCAL_NIVEL3_DESP := "II.6 Outros Poderes"]
  base[FISCAL_NIVEL2_DESP == "II.7 Demais Recursos - Vinculados",
            FISCAL_NIVEL3_DESP := "II.7 Demais Recursos - Vinculados"]
  base[FISCAL_NIVEL2_DESP == "II.8 Demais Recursos - Nao Vinculados",
            FISCAL_NIVEL3_DESP := "II.8 Demais Recursos - Nao Vinculados"]  


  base[FISCAL_NIVEL2_DESP == "III.1 Constitucionais" & is_mde_desp(base),
            FISCAL_NIVEL3_DESP := "III.1.1 Educacao"]
  base[FISCAL_NIVEL2_DESP == "III.1 Constitucionais" & is_asps_desp(base, "ACAO_COD"),
            FISCAL_NIVEL3_DESP := "III.1.2 Saude"]            
  base[FISCAL_NIVEL2_DESP == "III.1 Constitucionais" & is_fapemig_desp(base),
            FISCAL_NIVEL3_DESP := "III.1.3 Fapemig"]
  base[FISCAL_NIVEL2_DESP == "III.2 Fundeb",
            FISCAL_NIVEL3_DESP := "III.2 Fundeb"]
  base[FISCAL_NIVEL2_DESP == "III.3 Outros Poderes",
            FISCAL_NIVEL3_DESP := "III.3 Outros Poderes"]
  base[FISCAL_NIVEL2_DESP == "III.4 Demais Recursos - Vinculados",
            FISCAL_NIVEL3_DESP := "III.4 Demais Recursos - Vinculados"]
  base[FISCAL_NIVEL2_DESP == "III.5 Demais Recursos - Nao Vinculados",
            FISCAL_NIVEL3_DESP := "III.5 Demais Recursos - Nao Vinculados"]

  base[FISCAL_NIVEL2_DESP == "IV.1 Juros",
       FISCAL_NIVEL3_DESP := "IV.1 Juros"] 
  base[FISCAL_NIVEL2_DESP == "IV.2 Amortizacoes",
       FISCAL_NIVEL3_DESP := "IV.2 Amortizacoes"]
  
  base[FISCAL_NIVEL2_DESP == "V. RESERVA DE CONTINGENCIA",
       FISCAL_NIVEL3_DESP := "V. RESERVA DE CONTINGENCIA"]

}

demonstrativo_fontes <- function(base) {

    base[FONTE_COD %in% c(10,11,12,15,18,19,20),  FONTE_CATEGORIA := "Recursos Ordinarios"]
    base[FONTE_COD %in% c(60,61),  FONTE_CATEGORIA := "Recursos Diretamente Arrecadados"]
    base[FONTE_COD %in% c(26,27,29,52,53,72,91,94),  FONTE_CATEGORIA := "Taxas Estaduais"]
    base[FONTE_COD %in% c(1:8,16,17,22,24,36,37,55,56,57,62:70,73,74,84:88,92,93,97,98),  FONTE_CATEGORIA := "Convenios e Congeneres"]
    base[FONTE_COD %in% c(9,45,46),  FONTE_CATEGORIA := "TACs e doacoes"]
    base[FONTE_COD %in% c(25),  FONTE_CATEGORIA := "Operacoes de Credito"]
    base[FONTE_COD %in% c(30,42,43,44,58,75,78),  FONTE_CATEGORIA := "Recursos Previdenciarios"]
    base[FONTE_COD %in% c(13,23,90),  FONTE_CATEGORIA := "Recursos FUNDEB"]
    base[FONTE_COD %in% c(80,95),  FONTE_CATEGORIA := "Recursos Desastres Socioambientais"]
    #base[FONTE_COD %in% c(31,32,33,96), FONTE_CATEGORIA := "Compensacoes Exploracao de Recursos Naturais"]
    base[FONTE_COD %in% c(14,21,31,32,33,34,38,39,40,47,48,49,50,51,54,59,71,77,81,82,83,96,99),  FONTE_CATEGORIA := "Outros vinculados"]

}