VIM_COMMIT := b1ba9ab
VERSION := $(shell git rev-parse --short HEAD)$(and $(shell git status -s),_dirty_$(shell date +%s))
TAG := vim_compile_$(VIM_COMMIT)_$(VERSION)

vim-$(VIM_COMMIT).tar.gz:
	docker build -t $(TAG) --build-arg VIM_COMMIT=$(VIM_COMMIT) .
	docker create --name $(TAG) $(TAG)
	docker cp $(TAG):vim-$(VIM_COMMIT).tar.gz $(PWD)/
	docker rm $(TAG)
	docker rmi $(TAG)

release: vim-$(VIM_COMMIT).tar.gz
	@test "$(git status -s)" || (echo "A clean working directory is required to release." ; exit 1)
	git tag 'vim-$(VIM_COMMIT)-($(VERSION))'
	git push origin 'vim-$(VIM_COMMIT)-($(VERSION))'
	# TODO: create github release

clean:
	rm vim-*tar.gz
