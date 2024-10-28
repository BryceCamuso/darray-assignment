CC = gcc
CFLAGS = -Wall -Wextra -Iinclude -std=c2x

TARGET = lib/libarray.a

.PHONY: release
release: CFLAGS += -O3
release: $(TARGET) tests

debug: CFLAGS += -O0 -g
debug: $(TARGET) tests

.PHONY: build
build:
	mkdir -p include
	mkdir -p bin/tests
	mkdir -p lib

.PHONY: clean
clean:
	rm -rf $(TARGET)
	rm -rf lib bin build


$(TARGET): build build/darray.o
	ar rcs $(TARGET) build/darray.o


.PHONY: tests
tests: LDLIBS += -lcheck -lsubunit
tests: test/test/darray_test.c.c
	$(CC) $(CFLAGS) $(LDFLAGS) $(LDLIBS) test/test/darray_test.c.c $(TARGET) -o bin/tests/test/darray_test.c


build/darray.o: include/darray.c include/darray.h
	$(CC) $(CFLAGS) $(LDFLAGS) $(LDLIBS) -c include/darray.c -o build/darray.o


	
