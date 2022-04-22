CC = g++
INCLUDE = -Isrc/TheRestOfYourLife -Isrc/common -Isrc/common/external
CFLAGS = -O3 $(INCLUDE) -DNDEBUG -Wall -pedantic $(OPTFLAGS)
LDLIBS = $(OPTLIBS)

SRC = $(wildcard src/TheRestOfYourLife/main.cc)
OBJECTS = $(patsubst src/TheRestOfYourLife/%.cc, build/%.o, $(SRC))

TARGET = TheRestOfYourLife

all: build $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) $(OBJECTS) -o $@ $(LDLIBS)

source:
	echo $(SRC)

build/%.o: src/TheRestOfYourLife/%.cc
	$(CC) -c $(CFLAGS) $< -o $@

debug: CFLAGS = -g $(INCLUDE) -Wall -pedantic $(OPTFLAGS)
debug: $(TARGET)

profile: CFLAGS += -fno-omit-frame-pointer
profile: $(TARGET)

build:
	@mkdir -p build

clean:
	rm -rf build
