CS=src/builtins.c src/expr.c src/gc.c src/interpreter.c src/parser.c src/scope.c src/std.c src/tokenizer.c src/str.c
OBJS=builtins.o expr.o gc.o interpreter.o parser.o scope.o std.o tokenizer.o str.o
CFLAGS=-Wall -Werror

.PHONY: all
all: libebisp.a repl

$(OBJS): $(CS)
	gcc $(CFLAGS) -c $(CS)

libebisp.a: $(OBJS)
	ar -crs libebisp.a $(OBJS)

repl: libebisp.a src/repl.c src/repl_runtime.c
	gcc $(CFLAGS) -o repl src/repl.c src/repl_runtime.c -L. -lebisp

.PHONY: test
test: ebisp_test
	./ebisp_test

ebisp_test: libebisp.a test/main.c
	gcc $(CFLAGS) -Isrc/ -o ebisp_test test/main.c -L. -lebisp
