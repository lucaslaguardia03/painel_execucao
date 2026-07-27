SHELL := /bin/sh

build_historico:
	@for script in "code/R/munge_historico"/*.R; do \
		echo "Rodando $$script..."; \
		Rscript --verbose "$$script" 2> logs/log.Rout; \
	done
	@echo "build_historico completo."

build_ano_corrente:
	@for script in "code/R/munge_ano_corrente"/*.R; do \
		echo "Rodando $$script..."; \
		Rscript --verbose "$$script" 2> logs/log.Rout; \
	done
	@echo "build_ano_corrente completo."

build:
	@$(MAKE) build_historico
	@$(MAKE) build_ano_corrente
	@echo "build completo."