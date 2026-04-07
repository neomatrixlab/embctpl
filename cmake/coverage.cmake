# SPDX-License-Identifier: MIT
# Optional gcov coverage + HTML report (lcov + genhtml for the coverage target).

include_guard(GLOBAL)

add_library(project_coverage INTERFACE)
target_compile_options(project_coverage INTERFACE --coverage -O0 -g)
target_link_options(project_coverage INTERFACE --coverage)

find_program(PROJECT_LCOV_EXECUTABLE lcov)
find_program(PROJECT_GENHTML_EXECUTABLE genhtml)

if(PROJECT_LCOV_EXECUTABLE AND PROJECT_GENHTML_EXECUTABLE)
  add_custom_target(
    coverage
    COMMAND ${CMAKE_CTEST_COMMAND} --output-on-failure
    COMMAND ${PROJECT_LCOV_EXECUTABLE} --capture --ignore-errors inconsistent --directory ${CMAKE_BINARY_DIR}
            --output-file "${CMAKE_BINARY_DIR}/coverage_raw.info"
    COMMAND ${PROJECT_LCOV_EXECUTABLE} --extract "${CMAKE_BINARY_DIR}/coverage_raw.info"
            "${CMAKE_SOURCE_DIR}/src/*"
            --output-file "${CMAKE_BINARY_DIR}/coverage.info"
    COMMAND ${CMAKE_COMMAND} -E remove -f "${CMAKE_BINARY_DIR}/coverage_raw.info"
    COMMAND ${PROJECT_GENHTML_EXECUTABLE} --output-directory "${CMAKE_BINARY_DIR}/coverage-html" "${CMAKE_BINARY_DIR}/coverage.info"
    WORKING_DIRECTORY ${CMAKE_BINARY_DIR}
    COMMENT "Running tests and generating product-only coverage report in ${CMAKE_BINARY_DIR}/coverage-html"
    USES_TERMINAL
    VERBATIM
    COMMAND_EXPAND_LISTS
  )
else()
  message(
    STATUS
    "lcov/genhtml not found: 'coverage' custom target not created (install lcov to enable)."
  )
endif()

