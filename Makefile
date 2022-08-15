COMPILER=
ARCHIVER=
CP=cp
COMPILER_FLAGS= -iquote. -std=gnu99
EXTRA_COMPILER_FLAGS=

RELEASEDIR=../../../lib
INCLUDEDIR=../../../include
INCLUDES=-I$(INCLUDEDIR)
ISF_DIR = src
LIBNAME = coap
LIB = lib$(LIBNAME).a

EXPORT_INCLUDE_DIR = include/coap3

LIB_SRCS = $(ISF_DIR)/net.c \
          $(ISF_DIR)/coap_cache.c \
          $(ISF_DIR)/coap_debug.c \
          $(ISF_DIR)/coap_option.c \
          $(ISF_DIR)/resource.c \
          $(ISF_DIR)/pdu.c \
          $(ISF_DIR)/encode.c \
          $(ISF_DIR)/coap_subscribe.c \
          $(ISF_DIR)/coap_io.c \
          $(ISF_DIR)/coap_io_lwip.c \
          $(ISF_DIR)/block.c \
          $(ISF_DIR)/uri.c \
          $(ISF_DIR)/str.c \
          $(ISF_DIR)/coap_session.c \
          $(ISF_DIR)/coap_notls.c \
          $(ISF_DIR)/coap_hashkey.c \
          $(ISF_DIR)/coap_address.c \
          $(ISF_DIR)/coap_tcp.c \
          $(ISF_DIR)/coap_async.c


# create ISF_SRCS based on configured options

ISF_SRCS = $(LIB_SRCS)

ISF_OBJS = $(ISF_SRCS:%.c=%.o)

libs: $(LIB)
	$(CP) $(LIB) $(RELEASEDIR)
	
.PHONY: include
include: 
	$(CP) -r $(EXPORT_INCLUDE_DIR) $(INCLUDEDIR)
	$(CP) -r include/coap_config.h $(INCLUDEDIR)
    
clean:
	rm -f $(ISF_OBJS)
	rm -f $(LIB)

$(LIB): print_msg $(ISF_OBJS)
	@echo "Creating archive $@"
	$(ARCHIVER) rc $@ $(ISF_OBJS)

print_msg:
	@echo "Compiling $(LIBNAME) library"

.c.o:
	$(COMPILER) $(COMPILER_FLAGS) $(EXTRA_COMPILER_FLAGS) $(INCLUDES) -c $< -o $@
