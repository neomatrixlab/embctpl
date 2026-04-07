# SPDX-License-Identifier: MIT
cmake_minimum_required(VERSION 3.24)

project(project_xxx VERSION 0.1.0 LANGUAGES C CXX)

include(CTest)
include(GNUInstallDirs)
include(cmake/flags.cmake)

if(ENABLE_COVERAGE)
  include(cmake/coverage.cmake)
endif()

add_subdirectory(src)

if(BUILD_TESTING)
  add_subdirectory(tests)
endif()

include(cmake/packaging.cmake)
