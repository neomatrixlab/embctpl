# SPDX-License-Identifier: MIT

include_guard(DIRECTORY)

include("${CMAKE_SOURCE_DIR}/cmake/testing.cmake")

file(GLOB unit_test_sources CONFIGURE_DEPENDS "*.cc" "*.cpp")

add_executable(unit_tests ${unit_test_sources})
target_link_libraries(unit_tests PRIVATE project::core project::build_options GTest::gtest_main GTest::gmock)
target_include_directories(unit_tests PRIVATE "${CMAKE_SOURCE_DIR}/include")

include(GoogleTest)
gtest_discover_tests(unit_tests)

if(TARGET coverage)
  add_dependencies(coverage unit_tests)
endif()
