# SPDX-License-Identifier: MIT

file(GLOB core_sources CONFIGURE_DEPENDS "*.c")

add_library(core STATIC ${core_sources})
add_library(project::core ALIAS core)

target_include_directories(
  core PUBLIC "$<BUILD_INTERFACE:${CMAKE_SOURCE_DIR}/include>"
              "$<INSTALL_INTERFACE:${CMAKE_INSTALL_INCLUDEDIR}>"
)
target_link_libraries(core PRIVATE project::build_options)

install(TARGETS core ARCHIVE DESTINATION ${CMAKE_INSTALL_LIBDIR} LIBRARY DESTINATION ${CMAKE_INSTALL_LIBDIR})
