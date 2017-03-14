# CMake generated Testfile for 
# Source directory: /media/dl/sdc2/cmake_demo
# Build directory: /media/dl/sdc2/cmake_demo
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
ADD_TEST(test_run "demo" "haha")
ADD_TEST(test_usage "demo")
SET_TESTS_PROPERTIES(test_usage PROPERTIES  PASS_REGULAR_EXPRESSION "usage:")
SUBDIRS(utils)
