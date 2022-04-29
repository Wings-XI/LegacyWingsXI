/**
 *	@file Debugging.c
 *	Debugging, logging and execption logging
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#include "Debugging.h"

#include <malloc.h>
#include <string.h>

LOG_SEVERITY_LEVEL geLogLevel = LOG_SEVERITY_DEBUG0;
FILE* ghLogFile = NULL;

int LogPrintV(const char* szFileName, int iLineNo, const char* szFunctionName, LOG_SEVERITY_LEVEL eSeverity, const char* pszFormat, va_list vaArgs)
{
	// Actual format string to write
	char* pszActualFormat = NULL;
	// Actual format string to write (first try, trying to avoid malloc)
	char szActualFormatTmp[256];
	// Actual log message
	char* pszActualLogMessage = NULL;
	// Actual log message (first try, trying to avoid malloc)
	char szActualLogMessageTmp[1024];
	// Number of bytes needed for the message
	int iBytesNeeded = 0;
	// Severity level as string
	char szSeverityLevel[10];

	if (eSeverity == LOG_SEVERITY_CRITICAL) {
		strncpy(szSeverityLevel, "CRITICAL", sizeof(szSeverityLevel));
	}
	else if (eSeverity == LOG_SEVERITY_ERROR) {
		strncpy(szSeverityLevel, "ERROR", sizeof(szSeverityLevel));
	}
	else if (eSeverity == LOG_SEVERITY_WARNING) {
		strncpy(szSeverityLevel, "WARNING", sizeof(szSeverityLevel));
	}
	else if (eSeverity == LOG_SEVERITY_INFO) {
		strncpy(szSeverityLevel, "INFO", sizeof(szSeverityLevel));
	}
	else if (eSeverity == LOG_SEVERITY_DEBUG1) {
		strncpy(szSeverityLevel, "DEBUG1", sizeof(szSeverityLevel));
	}
	else if (eSeverity == LOG_SEVERITY_DEBUG0) {
		strncpy(szSeverityLevel, "DEBUG0", sizeof(szSeverityLevel));
	}
	else {
		// Unknown severity level
		return -1;
	}
	szSeverityLevel[sizeof(szSeverityLevel) - 1] = '\0';

	// Get the "real" format string, i.e. including file name, line number and severity level
	// Note, this is still not the real log message (vaArgs not expanded yet)
	if ((szFunctionName) && (szFileName) && (szFunctionName)) {
		iBytesNeeded = snprintf(szActualFormatTmp, sizeof(szActualFormatTmp), "[%s][%s][%s:%d] %s\n", szSeverityLevel, szFunctionName, szFileName, iLineNo, pszFormat);
	}
	else {
		iBytesNeeded = snprintf(szActualFormatTmp, sizeof(szActualFormatTmp), "[%s] %s\n", szSeverityLevel, pszFormat);
	}
	if (iBytesNeeded <= 0) {
		return iBytesNeeded;
	}
	if (iBytesNeeded >= sizeof(szActualFormatTmp)) {
		// That's one big format string, allocate on heap
		pszActualFormat = malloc(iBytesNeeded + 1);
		if (pszActualFormat == NULL) {
			return -1;
		}
		// Allocation guarantees enough buffer for format string including terminator
		if ((szFunctionName) && (szFileName) && (szFunctionName)) {
			iBytesNeeded = snprintf(pszActualFormat, iBytesNeeded + 1, "[%s][%s][%s:%d] %s\n", szSeverityLevel, szFunctionName, szFileName, iLineNo, pszFormat);
		}
		else {
			iBytesNeeded = snprintf(pszActualFormat, iBytesNeeded + 1, "[%s] %s\n", szSeverityLevel, pszFormat);
		}
		if (iBytesNeeded <= 0) {
			return iBytesNeeded;
		}
	}
	// Now we can actually expand the caller's arguments
	iBytesNeeded = vsnprintf(szActualLogMessageTmp, sizeof(szActualLogMessageTmp), pszActualFormat ? pszActualFormat : szActualFormatTmp, vaArgs);
	if (iBytesNeeded >= sizeof(szActualLogMessageTmp)) {
		pszActualLogMessage = malloc(iBytesNeeded + 1);
		if (pszActualLogMessage == NULL) {
			free(pszActualFormat);
			return -1;
		}
		iBytesNeeded = vsnprintf(pszActualLogMessage, iBytesNeeded + 1, pszActualFormat ? pszActualFormat : szActualFormatTmp, vaArgs);
		if (iBytesNeeded <= 0) {
			free(pszActualFormat);
			return iBytesNeeded;
		}
	}
	free(pszActualFormat);
	if (pszActualLogMessage) {
		fputs(pszActualLogMessage, stderr);
		if (ghLogFile) {
			fputs(pszActualLogMessage, ghLogFile);
		}
	}
	else {
		fputs(szActualLogMessageTmp, stderr);
		if (ghLogFile) {
			fputs(szActualLogMessageTmp, ghLogFile);
		}
	}
	free(pszActualLogMessage);
	return iBytesNeeded;
}

int LogPrint(const char* szFileName, int iLineNo, const char* szFunctionName, LOG_SEVERITY_LEVEL eSeverity, const char* pszFormat, ...)
{
	va_list vaArg;
	int iWritten = 0;

	va_start(vaArg, pszFormat);
	iWritten = LogPrintV(szFileName, iLineNo, szFunctionName, eSeverity, pszFormat, vaArg);
	va_end(vaArg);
	return iWritten;
}
