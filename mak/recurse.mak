.PHONY: all clean depend distclean

all:
	for dir in $(DIRS); do $(MAKE) -C $$dir all; done

clean:
	for dir in $(DIRS); do $(MAKE) -C $$dir clean ; done
