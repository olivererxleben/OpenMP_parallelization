UNAME = $(shell uname)

SYMTARGET = warmup1

ifeq ($(UNAME), Darwin)
LIBS = ../tbb-4.1-osx/libtbb.dylib
TARGET = warmup1-osx
else
LIBS = ../tbb-4.1-linux/libtbb.so
TARGET = warmup1-linux
endif

CXXFLAGS = -O2 -g -Wall -fmessage-length=0 -ltbb
OBJS = warmup1-main.o

$(TARGET):	$(OBJS)
	$(CXX) $(CXXFLAGS) -o $(TARGET) $(OBJS) $(LIBS)
	ln -fs $(TARGET) $(SYMTARGET)

all:	$(TARGET)

clean:
	rm -f $(OBJS) $(TARGET)
