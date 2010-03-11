CSC_FIRMWARE = $(wildcard *.$(TARGET))
CSC_BASENAME = $(basename $(CSC_FIRMWARE))
CSC_JS_FILE = $(filter $(addsuffix .js,$(CSC_BASENAME)),$(wildcard *.js))
CSC_SUPPURT_TARGET = $(filter $(TARGET),sky micaz)

test-csc: all
	@echo $(call assert,$(CSC_SUPPURT_TARGET),$(TARGET) is not supported for test!) >/dev/null
	@echo "\n########################################################################################"
	@echo "Creating cooja test configuration $(CSC_FIRMWARE).csc file from:"
	@echo $(CSC_FIRMWARE) $(CSC_JS_FILE)
	@echo $(call assert,$(CSC_JS_FILE),No .js file!)
	@$(VLROOT)/src/tests/templates/gen-csc.sh $(CSC_FIRMWARE) $(CSC_JS_FILE) $(TARGET)
	@echo "\n#########################################################################################"


