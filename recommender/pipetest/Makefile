CC=gcc
CFLAGS= -O2 -Wall -c -std=gnu99 -g3
LDFLAGS = -lm
LD=$(CC)

TARGET=pipetest
OBJECTS = $(patsubst %.c, %.o, $(wildcard *.c))
HEADERS = $(wildcard *.h)

$(TARGET):  $(OBJECTS) $(HEADERS)
	$(LD) -o $@ $< $(LDFLAGS) 

%.o: %.c $(HEADERS)
	$(CC) $(CFLAGS) $< -o $@

clean:	
	find . -name "*.o" -o -name "pipetest"|xargs rm -f
