LATEXPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitignore .gitmodules
LATEXFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

.DEFAULT_GOAL := help

list: ## Show dot files in this repo
	@$(foreach val, $(LATEXFILES), ls -dF $(val);)

deploy: ## Create symlink to home directory
	@echo 'Start to deploy LATEXFILES to home directory.'
	@echo ''
	@$(foreach file, $(LATEXFILES), ln -sfnv $(abspath $(file)) $(HOME)/$(file);)

update: ## Fetch changes for this repo
	git pull origin master

init: ## Setup environment settings
	@LATEXPATH=$(LATEXPATH) bash $(LATEXPATH)/etc/init/init.sh

install: update deploy init ## Run make updte, deploy, init
	@exec $$SHELL

# test: ## Test LATEXFILES and init scripts
# 	@LATEXPATH=$(LATEXPATH) bash $(LATEXPATH)/etc/test/test.sh

clean: ## Remove the dot files and this repo
	@read -n 1 -p 'Are you sure? [yN]: ' ans; echo; \
			case "$$ans" in 'y') \
				echo 'Remove dot files in your home directory...'; \
				-$(foreach file, $(LATEXFILES), rm -vrf $(HOME)/$(file);); \
				-rm -rf $(LATEXPATH);; \
			esac


help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

