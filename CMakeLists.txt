
# version required
cmake_minimum_required (VERSION 2.8)

# project name
project (cmake_demo)

# version
set (demo_VERSION_MAJOR 1) # main version
set (demo_VERSION_MINOR 0) # sub version


# check system whether support disp function
include (${CMAKE_ROOT}/Modules/CheckFunctionExists.cmake)
check_function_exists (disp HAVE_DISP)

# config for cmake
configure_file (
    "${PROJECT_SOURCE_DIR}/config.h.in"
    "${PROJECT_BINARY_DIR}/config.h"
    )
# option to use our own library or standard library
option (USE_UTILS
        "Use provided utils implementation" ON)

# whether to include utils library
if (USE_UTILS)
    include_directories ("${PROJECT_SOURCE_DIR}/utils")
    add_subdirectory(utils)
    set (EXTRA_LIBS ${EXTRA_LIBS} utils)
endif (USE_UTILS)


# search all src in current directory,and saved to DIR_SRCS valuable
aux_source_directory(. DIR_SRCS)

# generating object
add_executable(demo ${DIR_SRCS})
# add link library
target_link_libraries(demo ${EXTRA_LIBS})

# install the demo to /usr/local/bin(default)
install (TARGETS demo DESTINATION bin)
install (FILES "${PROJECT_BINARY_DIR}/config.h" DESTINATION include)


# testing our src
enable_testing()
add_test(test_run demo "haha")

add_test(test_usage demo)
set_tests_properties (test_usage
    PROPERTIES PASS_REGULAR_EXPRESSION "usage:")


# enable gdb debug
set(CMAKE_BUILD_TYPE "Debug")
set(CMAKE_CXX_FLAGS_DEBUG "$ENV{CXXFLAGS} -O0 -Wall -g -ggdb")
set(CMAKE_CXX_FLAGS_RELEASE "$ENV{CXXFLAGS} -O3 -Wall")


# generating CPack install package
include (InstallRequiredSystemLibraries)
set (CPACK_RESOURCE_FILE_LICENSE
    "${CMAKE_CURRENT_SOURCE_DIR}/License.txt")
set (CPACK_PACKAGE_VERSION_MAJOR "${demo_VERSION_MAJOR}")
set (CPACK_PACKAGE_VERSION_MINOR "${demo_VERSION_MINOR}")
include (CPack)


