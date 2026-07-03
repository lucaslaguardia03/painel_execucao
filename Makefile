SHELL := /bin/sh

build_historico:
	@for script in "code/R/munge"/*.R; do \
		echo "Rodando $$script..."; \
		Rscript --verbose "$${script}" 2> logs/log.Rout; \
	done
	@echo "build_historico completo."