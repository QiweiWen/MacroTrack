CC=g++
CFLAGS= -O2 -Wall -c
LDFLAGS = -lm
LD=$(CC)

TARGET=recommender
OBJECTS = $(patsubst %.cpp, %.o, $(wildcard *.cpp))
HEADERS = $(wildcard *.h)

$(TARGET):  $(OBJECTS) $(HEADERS)
	$(LD) -o $@ $^ $(LDFLAGS) 

%.o: %.cpp $(HEADERS)
	$(CC) $(CFLAGS) $< -o $@

clean:	
	find . -name "*.o" -o -name "recommender"|xargs rm -f

