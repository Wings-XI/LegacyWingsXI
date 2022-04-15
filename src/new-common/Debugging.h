/**
 *	@file Debugging.h
 *	Debugging, logging and execption logging
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#ifndef FFXI_COMMON_DEBUGGING_H
#define FFXI_COMMON_DEBUGGING_H

#include <stdio.h>
#include <stdarg.h>

#ifdef __cplusplus
extern "C"
{
#endif

/// Severity level of logs, controls how much debug info is printed
typedef enum _LOG_SEVERITY_LEVEL
{
	LOG_SEVERITY_DEBUG0 = 0,
	LOG_SEVERITY_DEBUG1 = 1,
	LOG_SEVERITY_INFO = 2,
	LOG_SEVERITY_WARNING = 3,
	LOG_SEVERITY_ERROR = 4,
	LOG_SEVERITY_CRITICAL = 5,
	LOG_SEVERITY_LAST
} LOG_SEVERITY_LEVEL, *PLOG_SEVERITY_LEVEL;

/// Log level threshold, only prints this level or above will actually get logged
extern LOG_SEVERITY_LEVEL geLogLevel;

/// File to log into, in addition to stderr
extern FILE* ghLogFile;

/**
	*	Print a message to the log file specified with var_args
	*	@param szFileName File name of the source code calling file
	*	@param iLineNo Line number in the source code
    *  @param szFuncName Calling function name
	*	@param eSeverity Severity level of the log message
	*	@param pszFormat printf compatible format string
	*	@param vaArgs Message arguments
	*	@return Number of bytes written to log
	*/
int LogPrintV(const char* szFileName, int iLineNo, const char* szFunctionName, LOG_SEVERITY_LEVEL eSeverity, const char* pszFormat, va_list vaArgs);

/**
	*	Print a message to the log file
	*	@param szFileName File name of the source code calling file
	*	@param iLineNo Line number in the source code
    *  @param szFuncName Calling function name
    *	@param eSeverity Severity level of the log message
	*	@param pszFormat printf compatible format string
	*	@param ... Message arguments
	*	@return Number of bytes written to log
	*/
int LogPrint(const char* szFileName, int iLineNo, const char* szFunctionName, LOG_SEVERITY_LEVEL eSeverity, const char* pszFormat, ...);


// Easy to use macro definitions
#if _DEBUG || DEBUG || ENABLE_DEBUG_LOGS
#define LOG_MESSAGE(sev, msg, ...) LogPrint(__FILE__, __LINE__, __FUNCTION__, sev, msg, ##__VA_ARGS__)
#else
#define LOG_MESSAGE(sev, msg, ...) LogPrint(NULL, 0, NULL, sev, msg, ##__VA_ARGS__)
#endif
#define LOG_CRITICAL(msg, ...) LOG_MESSAGE(LOG_SEVERITY_CRITICAL, msg, ##__VA_ARGS__)
#define LOG_ERROR(msg, ...) LOG_MESSAGE(LOG_SEVERITY_ERROR, msg, ##__VA_ARGS__)
#define LOG_WARNING(msg, ...) LOG_MESSAGE(LOG_SEVERITY_WARNING, msg, ##__VA_ARGS__)
#define LOG_INFO(msg, ...) LOG_MESSAGE(LOG_SEVERITY_INFO, msg, ##__VA_ARGS__)
#if _DEBUG || DEBUG || ENABLE_DEBUG_LOGS
#define LOG_DEBUG1(msg, ...) LOG_MESSAGE(LOG_SEVERITY_DEBUG1, msg, ##__VA_ARGS__)
#define LOG_DEBUG0(msg, ...) LOG_MESSAGE(LOG_SEVERITY_DEBUG0, msg, ##__VA_ARGS__)
#else
#define LOG_DEBUG1
#define LOG_DEBUG0
#endif

#ifdef __cplusplus
}
#endif

#endif
