/* SPDX-License-Identifier: MIT */
#include <stdio.h>

#include "core/core.h"

int main(void) {
  const uint8_t payload[] = {0x01U, 0x02U, 0x03U};
  const uint8_t crc = crc8_compute(payload, sizeof payload);
  (void)printf("example crc8=0x%02x\n", (unsigned int)crc);
  return 0;
}
