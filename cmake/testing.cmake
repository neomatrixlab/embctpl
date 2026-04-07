# SPDX-License-Identifier: MIT
# Test dependencies (GoogleTest/GoogleMock).

include_guard(GLOBAL)

# GoogleTest package already provides GoogleMock.
# Require preinstalled GTest (for example under /opt/googletest).
find_package(
  GTest 1.14 CONFIG REQUIRED
  HINTS
    /opt/googletest
    /opt/googletest/lib/cmake/GTest
)
