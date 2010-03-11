.PHONY: clean test-all


define USAGE


Usage:  make <target>

        Valid targets:

	  test-all : run all testcases in testcases/*.csc
          clean    : clean test result files in 'testcases'

 You can also run single testcase by using ./RUN_TEST <test-config-file.csc>


endef


ifeq ($(MAKECMDGOALS),)
    $(error $(USAGE)Please specify a valid target)
endif


test-all: clean
	for i in testcases/*.csc; do ./RUN_TEST $$i; done

clean:
	rm -rf testcases/*log
