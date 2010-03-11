.PHONY: test-csc

include $(VLROOT)/mak/header.mak

test-csc: 
	@$(VLROOT)/src/tests/templates/gen-csc.sh $(TARGET)


