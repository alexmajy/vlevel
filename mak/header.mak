ifeq ($(TARGET),)
  -include Makefile.target
  ifeq ($(TARGET),)
    ${info TARGET not defined, using target 'native'}
    TARGET=native
  else
    ${info using saved target '$(TARGET)'}
  endif
endif

define assert
  $(if $1,,$(error Assertion failed: $2))
endef



