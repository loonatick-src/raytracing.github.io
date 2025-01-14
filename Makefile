CC = g++
INCLUDE = -Isrc/common -I/src/theRestOfYourLife -Isrc/common/extra
CFLAGS = -O3 -Wall -Wextra -pedantic  -fopenmp -fwrapv $(INCLUDE) $(OPTFLAGS)
CFLAGS_INIT = -fopenmp -Wall -Wextra -pedantic -fwrapv $(INCLUDE) $(OPTFLAGS)


MAIN = src/TheRestOfYourLife/main.cc
TARGET = build/theRestOfYourLife

all: $(TARGET)

release: CFLAGS += -DNDEBUG
release: $(TARGET)

profile: CFLAGS = -pg $(CFLAGS_INIT)
profile: release

debug: CFLAGS = -g -Wall -Wextra -pedantic -fopenmp -fwrapv $(INCLUDE) $(OPTFLAGS)
debug: $(TARGET)

$(TARGET): build src/TheRestOfYourLife/main.cc src/TheRestOfYourLife/*.h src/common/*.h
	$(CC) $(CFLAGS) $(MAIN) -o $@

# bench: bench2/rect_hit.cpp build
	# $(CC) -g $(CFLAGS) -mno-omit-leaf-frame-pointer -fno-omit-frame-pointer bench2/*.cpp -o build/bench


build:
	@mkdir -p build

clean:
	rm -rf build
