VIM_COMMIT := $(shell git ls-remote -q --exit-code https://github.com/vim/vim master | cut -c -7)
REPO_COMMIT := $(shell git rev-parse --short HEAD)$(and $(shell git status -s),_dirty_$(shell date +%s))
VERSION := $(shell date +%Y%m%d)_$(VIM_COMMIT)_$(REPO_COMMIT)
DOCKER_TAG := vim_compile_$(VERSION)

vim-$(VIM_COMMIT).tar.gz:
	docker build -t $(DOCKER_TAG) --build-arg VIM_COMMIT=$(VIM_COMMIT) .
	docker create --name $(DOCKER_TAG) $(DOCKER_TAG)
	docker cp $(DOCKER_TAG):vim-$(VIM_COMMIT).tar.gz $(PWD)/
	docker rm $(DOCKER_TAG)
	docker rmi $(DOCKER_TAG)
