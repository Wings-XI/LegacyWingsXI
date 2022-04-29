/**
 *	@file BlowfishMod.h
 *	Implements the FFXI packet encryption scheme, which is a modified
 *  variant of the Blowfish algorithm.
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#ifndef FFXI_COMMON_BLOWFISHMOD_H
#define FFXI_COMMON_BLOWFISHMOD_H

#include <stdint.h>

#ifdef __cplusplus
extern "C"
{
#endif

#pragma pack(push, 1)
/**
 *  Blowfish tables, used as the key for encryption and decryption.
 */
typedef struct _BLOWFISH_MOD_KEY
{
    uint32_t P[18];
    uint32_t S[4][256];
} BLOWFISH_MOD_KEY, *PBLOWFISH_MOD_KEY;
#pragma pack(pop)

/**
 *  Initialize a new Blowfish key table from a given variable length key
 *  (e.g. password)
 *  @param keytable New key table to initialize, will be overwritten.
 *  @param keyin The encryption key (or password) to set
 *  @param keyinlen The length of keyin in bytes
 */
void bfmod_init_table(BLOWFISH_MOD_KEY* keytable, char* keyin, uint32_t keyinlen);

/**
 *  Encrypts a buffer of data in place.
 *  @param keytable Blowfish key table to use as key
 *  @param buffer Buffer to encrypt
 *  @param len Length of the buffer in bytes. Must be divisible by 64.
 */
void bfmod_encrypt_inplace(const BLOWFISH_MOD_KEY* keytable, char* buffer, uint32_t len);

/**
 *  Encrypts a buffer of data.
 *  @param keytable Blowfish key table to use as key
 *  @param input Input buffer to encrypt, must be a product of 64 bytes.
 *  @param output Buffer to write the encrypted data into.
 *  @param len Length of the buffers in bytes. Must be divisible by 64.
 */
void bfmod_encrypt(const BLOWFISH_MOD_KEY* keytable, const char* input, char* output, uint32_t len);

/**
 *  Decrypts a buffer of data in place.
 *  @param keytable Blowfish key table to use as key
 *  @param buffer Buffer to decrypt
 *  @param len Length of the buffer in bytes. Must be divisible by 64.
 */
void bfmod_decrypt_inplace(const BLOWFISH_MOD_KEY* keytable, char* buffer, uint32_t len);

/**
 *  Decrypts a buffer of data.
 *  @param keytable Blowfish key table to use as key
 *  @param input Input buffer to decrypt, must be a product of 64 bytes.
 *  @param output Buffer to write the decrypted data into.
 *  @param len Length of the buffers in bytes. Must be divisible by 64.
 */
void bfmod_decrypt(const BLOWFISH_MOD_KEY* keytable, const char* input, char* output, uint32_t len);

#ifdef __cplusplus
}
#endif

#endif
