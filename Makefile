DOTPATH    := $(realpath $(dir $(lastword $(MAKEFILE_LIST))))
CANDIDATES := $(wildcard .??*)
EXCLUSIONS := .DS_Store .git .gitignore .gitmodules
DOTFILES   := $(filter-out $(EXCLUSIONS), $(CANDIDATES))

.DEFAULT_GOAL := help

list: ## Show dot files in this repo
	@$(foreach val, $(DOTFILES), ls -dF $(val);)

deploy: ## Create symlink to home directory
	@echo 'Start to deploy dotfiles to home directory.'
	@echo ''
	@$(foreach file, $(DOTFILES), ln -sfnv $(abspath $(file)) $(HOME)/$(file);)

update: ## Fetch changes for this repo
	git pull origin master

init: ## Setup environment settings
	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/init/init.sh

install: update deploy init ## Run make updte, deploy, init
	@exec $$SHELL

# test: ## Test dotfiles and init scripts
# 	@DOTPATH=$(DOTPATH) bash $(DOTPATH)/etc/test/test.sh

clean: ## Remove the dot files and this repo
	@read -n 1 -p 'Are you sure? [yN]: ' ans; echo; \
			case "$$ans" in 'y') \
				echo 'Remove dot files in your home directory...'; \
				-$(foreach file, $(DOTFILES), rm -vrf $(HOME)/$(file);); \
				-rm -rf $(DOTPATH);; \
			esac


help: ## Self-documented Makefile
	@grep -E '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) \
		| sort \
		| awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

