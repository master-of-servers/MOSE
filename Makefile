build:
	export GO111MODULE=on
	go get github.com/markbates/pkger/cmd/pkger
	go get -u -v
	go build
	mkdir -p payloads

fmt: ## gofmt and goimports all go files
	find . -name '*.go' -not -wholename './vendor/*' | while read -r file; do gofmt -w -s "$$file"; goimports -w "$$file"; done

test:
	go test -count=1 -v -race ./... ; \
		echo "Testing Complete."

tidy:
	go mod tidy
	pushd cmd/puppet/main/; go mod tidy; popd
	pushd cmd/chef/main/; go mod tidy; popd
	pushd cmd/ansible/main/; go mod tidy; popd
	pushd cmd/salt/main/; go mod tidy; popd