# OS type
CC = gcc
SOURCES = my.c
OBJECTS = $(addsuffix .o,$(basename $(SOURCES)))
OS = $(shell uname -s)
CFLAGS = -Wall -Winit-self 
LDLIBS = -lm
DYNAMICLIB = 

ifeq ($(OS),Linux)
# Linux
$(info LINUX)
DYNAMICLIB = -shared -Wl,-soname,libmy.so.1 -Wl,--no-as-needed -ldl
MY_LIB = libmy.so
endif

ifeq ($(OS),Darwin)
# Mac
$(info MAC OS X)
DYNAMICLIB = -dynamiclib -undefined suppress -flat_namespace -shared
MY_LIB = libmy.dylib
endif

all: lib

lib: CFLAGS += -fPIC -O3
lib: lib-start $(MY_LIB)
	@echo "$(OK_COLOR)"
	@echo "MY MADS Shared Library built!"
	@echo "$(NO_COLOR)"

lib-start:
	@echo "$(OK_COLOR)"
	@echo "MADS Library ..."
	@echo "$(NO_COLOR)"

lib-install:
	@echo "$(OK_COLOR)"
	@echo "Install MY MADS Library ..."
	@echo "$(NO_COLOR)"
	cp $(MADS_LIB) $(LIB_DIR)/libmy.so.1.0
	ln -sf $(LIB_DIR)/libmy.so.1.0 $(LIB_DIR)/libmy.so.1
	ln -sf $(LIB_DIR)/libmy.so.1.0 $(LIB_DIR)/libmy.so
	ln -sf $(LIB_DIR)/libmy.so.1.0 $(LIB_DIR)/libmy.dylib

clean clean-lib:
	rm -f $(MY_LIB) $(OBJECTS)

$(MY_LIB): $(OBJECTS)
	@echo "$(OK_COLOR)"
	@echo "Building MY MADS Shared Library ..."
	@echo "$(NO_COLOR)"
	$(CC) $(DYNAMICLIB) -o $@ $(LDLIBS) $(OBJECTS)
	# libtool --mode=link $(CC) $(LDLIBS) $(OBJECTS_LIB) -o $@ -rpath /usr/local/lib -version-info 1:1:14
