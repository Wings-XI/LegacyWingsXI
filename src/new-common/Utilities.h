/**
 *	@file Utilities.h
 *	Misc helper functions
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#ifndef FFXI_COMMON_UTILITIES_H
#define FFXI_COMMON_UTILITIES_H

#include <stdarg.h>
#include <string>
#include <istream>
#include <memory>

#define ffxi_min(a,b) (((a)<(b)) ? (a) : (b))
#define ffxi_max(a,b) (((a)>(b)) ? (a) : (b))

/**
 *  Format a string in a C-printf fansion given varargs and return
 *  as C++ string.
 *  @param pstrFormat Format string
 *  @param args Arguments as var_arg object
 *  @return Formatted string
 */
std::string FormatStringV(const std::string* pstrFormat, va_list args);

/**
 *  Format a string in a C-printf fansion given varargs and return
 *  as C++ string.
 *  @param pstrFormat Format string
 *  @param ... any further arguments
 *  @return Formatted string
 */
std::string FormatString(const std::string* pstrFormat, ...);

/**
 *  Reads the entire value of an input stream and return it as a buffer
 *  shared pointer.
 *  @param pStream istream to read from
 *  @param dwMax Max size to read in bytes
 *  @param pdwSize If not null receives the size of the data
 *  @return Pointer to the data
 */
std::shared_ptr<uint8_t> IStreamToBuffer(std::istream* pStream, uint32_t dwMax, size_t* pdwSize = NULL);

/**
 *  Return a hexdecimal string representation of a binary buffer
 *  @param binBuffer Buffer to convert
 *  @param dwSize Size of the buffer in bytes
 */
std::string BinaryToHex(uint8_t* binBuffer, size_t dwSize);

/**
 *  Return a binary representation of a hex string
 *  @param strHex String to convert
 *  @param binBuffer Buffer which receives the binary output
 *  @param dwSize Size of binBuffer in bytes
 *  @return Number of bytes written to the buffer or zero on failure
 */
size_t HexToBinary(std::string& strHex, uint8_t* binBuffer, size_t dwSize);

#endif
