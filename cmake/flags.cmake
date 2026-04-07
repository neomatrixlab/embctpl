# SPDX-License-Identifier: MIT
# Unified compile/link flags applied per-target (modern CMake).

include_guard(GLOBAL)

add_library(project_default_flags INTERFACE)
add_library(project::default_flags ALIAS project_default_flags)
add_library(project_build_options INTERFACE)
add_library(project::build_options ALIAS project_build_options)

target_compile_features(project_default_flags INTERFACE c_std_11 cxx_std_17)

target_compile_definitions(
  project_default_flags
  INTERFACE
    $<$<CONFIG:Release>:NDEBUG>
)

target_compile_options(
  project_default_flags
  INTERFACE
    -Wall
    -Wextra
    -Werror
    $<$<CONFIG:Debug>:-O0;-g>
    $<$<CONFIG:Release>:-O3>
    $<$<AND:$<BOOL:${ENABLE_SANITIZER}>,$<CONFIG:Debug>>:-fsanitize=address,undefined;-fno-omit-frame-pointer>
)

target_link_options(
  project_default_flags
  INTERFACE
    $<$<AND:$<BOOL:${ENABLE_SANITIZER}>,$<CONFIG:Debug>>:-fsanitize=address,undefined>
)

target_link_libraries(
  project_build_options
  INTERFACE
    project::default_flags
    $<$<AND:$<BOOL:${ENABLE_COVERAGE}>,$<NOT:$<BOOL:${CMAKE_TOOLCHAIN_FILE}>>,$<TARGET_EXISTS:project_coverage>>:project_coverage>
)
