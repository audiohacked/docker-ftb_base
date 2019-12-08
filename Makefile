# Makefile
base:
	docker build -t base .

example:
	docker build -t ftb -f ftb.Dockerfile .

test_base:
	docker run --interactive --tty --rm --entrypoint="/bin/ls" base -lha

run:
	docker run --interactive --tty --rm --env EULA=TRUE ftb
