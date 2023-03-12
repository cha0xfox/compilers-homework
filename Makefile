CC=gcc
CFLAGS=-lfl
current_dir = $(shell pwd)

compile lab: dir a.out

a.out:
	flex $(current_dir)/src/lab1.ll
	mv lex.yy.c $(current_dir)/src/tmp
	$(CC) -o $(current_dir)/bin/$@ $(current_dir)/src/tmp/lex.yy.c $(CFLAGS)

dir:
	mkdir $(current_dir)/bin
	mkdir $(current_dir)/src/tmp

clean:
	rm -rf $(current_dir)/bin
	rm -rf $(current_dir)/src/tmp