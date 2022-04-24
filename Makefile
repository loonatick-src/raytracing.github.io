CC = g++
INCLUDE = -Isrc/TheRestOfYourLife -Isrc/common -Isrc/common/external
CFLAGS = -O2 $(INCLUDE) -DNDEBUG -Wall -pedantic -fwrapv $(OPTFLAGS)
LDLIBS = $(OPTLIBS)

SRC = $(wildcard src/TheRestOfYourLife/main.cc)
OBJECTS = $(patsubst src/TheRestOfYourLife/%.cc, build/%.o, $(SRC))

TARGET = build/TheRestOfYourLife

all: $(TARGET)

$(TARGET): build $(OBJECTS)
	$(CC) $(OBJECTS) -o $@ $(LDLIBS)

source:
	echo $(SRC)

build/%.o: src/TheRestOfYourLife/%.cc
	$(CC) -c $(CFLAGS) $< -o $@

debug: CFLAGS = -g $(INCLUDE) -fwrapv -Wall -pedantic $(OPTFLAGS)
debug: $(TARGET)

# TODO: verify if these are fine for profiling
profile: CFLAGS += -g -fno-omit-frame-pointer -mno-omit-leaf-frame-pointer 
profile: $(TARGET)

build:
	@mkdir -p build

clean:
	rm -rf build
