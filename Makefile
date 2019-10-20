VIM_COMMIT := b1ba9ab
VERSION := $(shell git rev-parse --short HEAD)$(and $(shell git status -s),_dirty_$(shell date +%s))
DOCKER_TAG := vim_compile_$(VIM_COMMIT)_$(VERSION)
RELEASE := vim-$(VIM_COMMIT)-($(VERSION))

vim-$(VIM_COMMIT).tar.gz:
	docker build -t $(DOCKER_TAG) --build-arg VIM_COMMIT=$(VIM_COMMIT) .
	docker create --name $(DOCKER_TAG) $(DOCKER_TAG)
	docker cp $(DOCKER_TAG):vim-$(VIM_COMMIT).tar.gz $(PWD)/
	docker rm $(DOCKER_TAG)
	docker rmi $(DOCKER_TAG)

release: vim-$(VIM_COMMIT).tar.gz
	@test "$(git status -s)" || (echo "A clean working directory is required to release." ; exit 1)
	git tag "$(RELEASE)"
	git push origin "$(RELEASE)"
	hub release create -a vim-*.tar.gz "$(RELEASE)"

clean:
	rm vim-*.tar.gz
