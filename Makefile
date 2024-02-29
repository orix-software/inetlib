SOURCES8=$(wildcard src/*.s)
OBJECTS8=$(SOURCES8:.s=.o)

ifeq ($(CC65_HOME),)
        CC = cl65
        AS = ca65
        LD = ld65
        AR = ar65
else
        CC = $(CC65_HOME)/bin/cl65
        AS = $(CC65_HOME)/bin/ca65
        LD = $(CC65_HOME)/bin/ld65
        AR = $(CC65_HOME)/bin/ar65
endif

all: init $(SOURCES8) $(OBJECTS8) tests

tests:
	@$(CC) -ttelestrat inet.lib tests/inetadd.c -o inetadd --include-dir src/include

init: $(SOURCE)
	./configure

$(OBJECTS8): $(SOURCES8)
	@$(AS) -ttelestrat $(@:.o=.s) -o $@ --include-dir src/include
	@$(AR) r inet.lib $@
	@mkdir -p build/lib8
	@mkdir -p build/usr/include/arpa
	@mkdir -p build/usr/include/asm
	@cp src/include/inet.h build/usr/include/arpa/
	@cp inet.lib build/lib8/

clean:
	rm src/*.o
	rm inet.lib
