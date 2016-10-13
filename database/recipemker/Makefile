CC=g++
CFLAGS= -O2 -Wall -c -std=gnu++11 -g3 -I ${PGDATA}/../include
LDFLAGS = -lm -lpq
LD=$(CC)

TARGET=mkres
OBJECTS = $(patsubst %.cpp, %.o, $(wildcard *.cpp))
HEADERS = $(wildcard *.h)

$(TARGET):  $(OBJECTS) $(HEADERS)
	$(LD) -o $@ $< $(LDFLAGS) 

%.o: %.cpp $(HEADERS)
	$(CC) $(CFLAGS) $< -o $@

clean:	
	find . -name "*.o" -o -name "mkres"|xargs rm -f
