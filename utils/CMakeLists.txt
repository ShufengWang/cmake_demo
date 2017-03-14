aux_source_directory(. DIR_LIB_SRCS)

add_library (utils ${DIR_LIB_SRCS})

install (TARGETS utils DESTINATION bin)
install (FILES disp.h DESTINATION include)
