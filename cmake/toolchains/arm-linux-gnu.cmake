# SPDX-License-Identifier: MIT
# Cross-compile for Linux on ARM (GNU EABIHF).
# IMPORTANT: Customize this path for your machine on first use.

set(CMAKE_SYSTEM_NAME Linux)
set(CMAKE_SYSTEM_PROCESSOR arm)

set(CROSS_TOOLCHAIN_ROOT
    "/opt/toolchains/gcc-linaro-7.5.0-2019.12-x86_64_arm-linux-gnueabihf"
    CACHE PATH
    "Root path of the ARM GNU toolchain")
set(CROSS_TOOLCHAIN_PREFIX
    "arm-linux-gnueabihf"
    CACHE STRING
    "Compiler binary prefix (for example: arm-linux-gnueabihf)")

if(NOT EXISTS "${CROSS_TOOLCHAIN_ROOT}/bin/${CROSS_TOOLCHAIN_PREFIX}-gcc")
  message(FATAL_ERROR
          "ARM toolchain not found at '${CROSS_TOOLCHAIN_ROOT}'.\n"
          "Set -DCROSS_TOOLCHAIN_ROOT=/path/to/your/toolchain or configure it in CMakePresets.json.")
endif()

set(CMAKE_C_COMPILER
    "${CROSS_TOOLCHAIN_ROOT}/bin/${CROSS_TOOLCHAIN_PREFIX}-gcc"
    CACHE FILEPATH "C compiler" FORCE)
set(CMAKE_CXX_COMPILER
    "${CROSS_TOOLCHAIN_ROOT}/bin/${CROSS_TOOLCHAIN_PREFIX}-g++"
    CACHE FILEPATH "C++ compiler" FORCE)

if(EXISTS "${CROSS_TOOLCHAIN_ROOT}/${CROSS_TOOLCHAIN_PREFIX}/sysroot")
  set(CMAKE_SYSROOT
      "${CROSS_TOOLCHAIN_ROOT}/${CROSS_TOOLCHAIN_PREFIX}/sysroot"
      CACHE PATH "Sysroot for cross compilation" FORCE)
endif()

set(CMAKE_FIND_ROOT_PATH "${CMAKE_SYSROOT}" "${CROSS_TOOLCHAIN_ROOT}")
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_PACKAGE ONLY)
