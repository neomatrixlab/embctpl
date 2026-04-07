/* SPDX-License-Identifier: MIT */
#ifndef CORE_H
#define CORE_H

#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

/**
 * Compute CRC-8 (polynomial 0x07, init 0) over `data[0..len-1]`.
 * If `len == 0`, the result is 0 and `data` is not dereferenced.
 * If `len > 0`, `data` must be a valid pointer.
 */
uint8_t crc8_compute(const uint8_t *data, size_t len);

#ifdef __cplusplus
}
#endif

#endif
