VIM_COMMIT := $(shell git ls-remote -q --exit-code https://github.com/vim/vim master | cut -c -7)
REPO_COMMIT := $(shell git rev-parse --short HEAD)$(and $(shell git status -s),_dirty_$(shell date +%s))
VERSION := $(VIM_COMMIT)_$(REPO_COMMIT)
DOCKER_TAG := vim_compile_$(VERSION)

vim-$(VIM_COMMIT).tar.gz:
	docker build -t $(DOCKER_TAG) --build-arg VIM_COMMIT=$(VIM_COMMIT) .
	docker create --name $(DOCKER_TAG) $(DOCKER_TAG)
	docker cp $(DOCKER_TAG):vim-$(VIM_COMMIT).tar.gz $(PWD)/
	docker rm $(DOCKER_TAG)
	docker rmi $(DOCKER_TAG)

upload: vim-$(VIM_COMMIT).tar.gz
	@test -z "$(git status -s)" || (echo "A clean working directory is required to upload." ; exit 1)
	curl -uleighmcculloch:$(BINTRAY_API_KEY) 'https://api.bintray.com/content/leighmcculloch/vim_compile/vim/$(VERSION)/vim_$(VERSION).tar.gz' -T vim-$(VIM_COMMIT).tar.gz
	curl -uleighmcculloch:$(BINTRAY_API_KEY) 'https://api.bintray.com/content/leighmcculloch/vim_compile/vim/$(VERSION)/publish' -X POST -d '{"discard":"false"}'

clean:
	rm vim-*.tar.gz
