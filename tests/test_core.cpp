// SPDX-License-Identifier: MIT
#include <gtest/gtest.h>

extern "C" {
#include "core/core.h"
}

TEST(Core, Crc8Empty) { EXPECT_EQ(crc8_compute(nullptr, 0), 0U); }

TEST(Core, Crc8KnownVector) {
  const uint8_t data[] = {0x00U, 0x01U, 0x02U};
  // Polynomial 0x07, init 0; reference value for this implementation.
  EXPECT_EQ(crc8_compute(data, sizeof data), 0x1BU);
}
