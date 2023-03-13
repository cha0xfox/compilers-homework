CC = gcc
CFLAGS = -lfl
TARGET = lab1.out

compile lab: lab1.out testAll

lab1.out:
	@ echo "building..."
	@ mkdir -p bin
	@ mkdir -p tmp
	@ flex src/lab1.l
	@ mv lex.yy.c tmp
	@ $(CC) -o bin/$@ tmp/lex.yy.c $(CFLAGS)
	@ echo "binary moved to bin"

clean: 
	@ rm -rf bin
	@ rm -rf tmp
	@echo "----dir cleaned----"

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
	@ if ./bin/$(TARGET) tests/tests.txt tests/tests2.txt; then false; fi
	@echo "OK"

test2:
	@echo "TEST: pipe working"
	@ echo "0xF | 0x2" | ./bin/$(TARGET) $2>/dev/null
	@echo "OK"

test3:
	@echo "TEST: file working"
	@ ./bin/$(TARGET) tests/tests2.txt $2>/dev/null
	@echo "OK"
