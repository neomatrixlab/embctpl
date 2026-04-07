# SPDX-License-Identifier: MIT

add_subdirectory(core)

file(GLOB app_sources CONFIGURE_DEPENDS "*.c")

add_executable(app ${app_sources})
target_link_libraries(app PRIVATE project::core project::build_options)

install(TARGETS app RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR})
install(DIRECTORY "${CMAKE_SOURCE_DIR}/include/core" DESTINATION "${CMAKE_INSTALL_INCLUDEDIR}")
