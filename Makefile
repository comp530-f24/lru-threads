all: lru-sequential lru-mutex lru-fine lru-fine-thread-sanitizer

CFLAGS = -g -Wall -Werror -pthread

%.o: %.c *.h
	gcc $(CFLAGS) -c -o $@ $<

lru-sequential: main.c sequential-lru.o
	gcc $(CFLAGS) -o lru-sequential sequential-lru.o main.c

lru-mutex: main.c mutex-lru.o
	gcc $(CFLAGS) -o lru-mutex mutex-lru.o main.c

lru-fine: main.c fine-lru.o
	gcc $(CFLAGS) -o lru-fine fine-lru.o main.c

lru-fine-thread-sanitizer: main.c fine-lru.c
	clang -fsanitize=thread -fsanitize-blacklist=.ignore.txt -g -O0 fine-lru.c main.c -o lru-fine-thread-sanitizer

update:
	git checkout main
	git pull https://github.com/comp530-f23/lab3.git master

clean:
	rm -f *~ *.o lru-sequential lru-mutex lru-rw lru-fine lru-fine-thread-sanitizer
