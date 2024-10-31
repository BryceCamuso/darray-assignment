CC = gcc
CFLAGS = -Wall -Wextra -Iinclude -std=c2x

TARGET = lib/libarray.a

.PHONY: release
release: CFLAGS += -O3
release: $(TARGET) tests


debug: CFLAGS += -O0 -g
debug: $(TARGET) tests
debug: $(TARGET) build

.PHONY: build
build:
	mkdir -p include
	mkdir -p bin/tests
	mkdir -p lib
	mkdir -p build

.PHONY: clean
clean:
	rm -rf $(TARGET)
	rm -rf lib bin build


$(TARGET): build build/darray.o
	ar rcs $(TARGET) build/darray.o


.PHONY: tests
tests: LDLIBS += -lcheck -lsubunit
tests: test/darray_test.c
	$(CC) $(CFLAGS) $(LDFLAGS) $(LDLIBS) test/darray_test.c $(TARGET) -o bin/tests/darray_test


build/darray.o: src/darray.c include/darray.h
	$(CC) $(CFLAGS) $(LDFLAGS) $(LDLIBS) -c src/darray.c -o build/darray.o


	

