CC = gcc
CFLAGS = -lfl
TARGET = lab2.out

compile lab: $(TARGET)

$(TARGET):
	@ echo "building..."
	@ mkdir -p bin
	@ mkdir -p tmp
	@ bison src/grammar.y --defines=grammar.h -o grammar.c
	@ flex --header-file=lexer.h src/lab.l
	@ mv -t tmp lex.yy.c grammar.h grammar.c lexer.h
	@ $(CC) tmp/lex.yy.c tmp/grammar.c $(CFLAGS) -o bin/$@
	@ echo "binary moved to bin"

clean: 
	@ rm -rf bin
	@ rm -rf tmp
	@echo "----dir cleaned----"

.PHONY: rebuild
rebuild:
	$(MAKE) clean
	$(MAKE)

test: test1 test2 test3
	@echo "----TESTS PASSED----"

test1:
	@echo "TEST: multiple arguments"
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
