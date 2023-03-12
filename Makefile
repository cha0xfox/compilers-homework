CC = gcc
CFLAGS = -lfl
current_dir = $(shell pwd)
TARGET = lab1.out

compile lab: dir lab1.out testAll

lab1.out:
	flex $(current_dir)/src/lab1.l
	mv lex.yy.c $(current_dir)/src/tmp
	$(CC) -o $(current_dir)/bin/$@ $(current_dir)/src/tmp/lex.yy.c $(CFLAGS)

dir:
	mkdir $(current_dir)/bin
	mkdir $(current_dir)/src/tmp

clean: 
	rm -rf $(current_dir)/bin
	rm -rf $(current_dir)/src/tmp

.PHONY: rebuild
rebuild:
	$(MAKE) clean
	$(MAKE)

testAll: test1 test2 test3
	@echo "--------------------"
	@echo "----TESTS PASSED----"
	@echo "--------------------"

test1:
	@echo "TEST: wrong arguments"
	if ./bin/$(TARGET) $(current_dir)/tests/tests.txt $(current_dir)/tests/tests2.txt; then false; fi

test2:
	@echo "TEST: pipe working"
	echo "0xF | 0x2" | ./bin/$(TARGET) $2>/dev/null

test3:
	@echo "TEST: file working"
	./bin/$(TARGET) $(current_dir)/tests/tests2.txt $2>/dev/null
