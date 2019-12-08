# Makefile
base:
	docker build -t base .

example:
	docker build -t ftb -f ftb.Dockerfile .

run:
	docker run --interactive --tty --rm --env EULA=TRUE ftb
