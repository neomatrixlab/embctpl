/* SPDX-License-Identifier: MIT */
#include "core/core.h"

enum {
  kCrc8BitsPerByte = 8,
};

static const uint8_t kCrc8Poly = 0x07U;
static const uint8_t kCrc8TopBit = 0x80U;

uint8_t crc8_compute(const uint8_t *data, size_t len) {
  uint8_t crc = 0U;

  for (size_t i = 0U; i < len; ++i) {
    crc ^= data[i];
    for (int bit = 0; bit < kCrc8BitsPerByte; ++bit) {
      if ((crc & kCrc8TopBit) != 0U) {
        crc = (uint8_t)((crc << 1) ^ kCrc8Poly);
      } else {
        crc <<= 1;
      }
    }
  }

  return crc;
}
