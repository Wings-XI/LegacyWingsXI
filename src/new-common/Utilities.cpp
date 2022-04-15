/**
 *	@file Utilities.cpp
 *	Misc helper functions
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#include "Utilities.h"
#include "Debugging.h"
#include <string.h>
#include <stdexcept>

std::string FormatStringV(const std::string* pstrFormat, va_list args)
{
    // Temp buffer on stack so we hopefully don't have to allocate on heap
    char szResult[1024];
    // In case we do need to allocate on heap, use this
    char* pszResultEx = NULL;

    LOG_DEBUG0("Called.");
    szResult[sizeof(szResult) - 1] = '\0';
    int iBytesNeeded = vsnprintf(szResult, sizeof(szResult) - 1, pstrFormat->c_str(), args);
    if (iBytesNeeded >= sizeof(szResult)) {
        pszResultEx = new char[iBytesNeeded + 1];
        pszResultEx[iBytesNeeded] = '\0';
        int iResult = vsnprintf(pszResultEx, sizeof(szResult) - 1, pstrFormat->c_str(), args);
        if ((iResult < 0) || (iResult > iBytesNeeded)) {
            // Should never happen....
            free(pszResultEx);
            LOG_ERROR("vsnprintf failed with dynamic allocation.");
            throw std::runtime_error("vsnprintf failed with dynamic allocation.");
        }
        std::string strResult(pszResultEx);
        delete pszResultEx;
        return strResult;
    }
    else if (iBytesNeeded >= 0) {
        return std::string(szResult);
    }
    LOG_ERROR("vsnprintf failed.");
    throw std::runtime_error("vsnprintf failed.");
}

std::string FormatString(const std::string* pstrFormat, ...)
{
    va_list vaArg;

    va_start(vaArg, pstrFormat);
    std::string strResult(FormatStringV(pstrFormat, vaArg));
    va_end(vaArg);
    return strResult;
}

std::shared_ptr<uint8_t> IStreamToBuffer(std::istream* pStream, uint32_t dwMax, size_t* pdwSize)
{
    if (pStream == NULL) {
        return NULL;
    }
    pStream->seekg(0, std::ios_base::end);
    if (pStream->bad() || pStream->fail()) {
        LOG_ERROR("Cannot seek stream.");
        throw std::runtime_error("Stream seek failed.");
    }
    size_t dwStreamSize = pStream->tellg();
    if (pStream->bad() || pStream->fail()) {
        LOG_ERROR("Cannot tell stream.");
        throw std::runtime_error("Stream tell failed.");
    }
    pStream->seekg(0, std::ios_base::beg);
    if (pStream->bad() || pStream->fail()) {
        LOG_ERROR("Cannot seek stream back.");
        throw std::runtime_error("Stream seek back failed.");
    }
    if (dwStreamSize > dwMax) {
        LOG_ERROR("Stream size too big.");
        throw std::runtime_error("Stream size too big.");
    }
    uint8_t* bufOut = new uint8_t[dwStreamSize];
    memset(bufOut, 0, dwStreamSize);
    pStream->read(reinterpret_cast<char*>(bufOut), dwStreamSize);
    if (pStream->bad() || pStream->fail()) {
        LOG_ERROR("Cannot read stream.");
        delete bufOut;
        throw std::runtime_error("Stream read failed.");
    }
    if (pdwSize) {
        *pdwSize = dwStreamSize;
    }
    return std::shared_ptr<uint8_t>(bufOut);
}

std::string BinaryToHex(uint8_t* binBuffer, size_t dwSize)
{
    char Digits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'A', 'B', 'C', 'D', 'E', 'F' };
    std::string Result;

    for (size_t i = 0; i < dwSize; i++) {
        uint8_t cByte = binBuffer[i];
        Result += Digits[cByte >> 4];
        Result += Digits[cByte & 0x0F];
    }
    return Result;
}

size_t HexToBinary(std::string& strHex, uint8_t* binBuffer, size_t dwSize)
{
    const char* pcszHex = strHex.c_str();
    size_t dwHexLen = strlen(pcszHex);
    if (dwHexLen % 2 != 0) {
        dwHexLen -= 1;
    }
    if (dwHexLen / 2 > dwSize) {
        return 0;
    }
    size_t i = 0;
    uint8_t cByte = 0;
    bool bFirst = true;
    size_t dwOut = 0;
    while (i < dwHexLen) {
        cByte = 0;
        bool bFirst = true;
        while (true) {
            if (pcszHex[i] >= '0' && pcszHex[i] <= '9') {
                cByte |= pcszHex[i] - '0';
            }
            else if (pcszHex[i] >= 'A' && pcszHex[i] <= 'Z') {
                cByte |= pcszHex[i] - 'A' + 10;
            }
            else if (pcszHex[i] >= 'a' && pcszHex[i] <= 'z') {
                cByte |= pcszHex[i] - 'a' + 10;
            }
            else {
                return 0;
            }
            i++;
            if (bFirst) {
                cByte <<= 4;
                bFirst = false;
            }
            else {
                break;
            }
        }
        binBuffer[dwOut] = cByte;
        dwOut++;
    }
    return dwOut;
}
