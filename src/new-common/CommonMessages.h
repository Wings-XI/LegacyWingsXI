/**
 *	@file CommonMessages.h
 *	Defintion of structures going in MQ messages
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#ifndef FFXI_COMMON_COMMONMESSAGES
#define FFXI_COMMON_COMMONMESSAGES

#include "MQConnection.h"

// Name of the login server queue
#define LOGIN_MQ_NAME "LOGIN_MQ"
// Magic value that identifies login messages
#define LOGIN_MQ_MSG_MAGIC 0x54574C54

#pragma pack(push, 1)

struct CHAR_MQ_MESSAGE_HEADER
{
    uint32_t dwMagic;
    MQConnection::MQ_MESSAGE_TYPES eType;
    uint32_t dwContentID;
    uint32_t dwCharacterID;
    uint32_t dwAccountID;
};

/**
 *  Full details of a single character
 */
struct CHARACTER_ENTRY
{
    uint32_t dwContentID;
    bool bEnabled;
    uint32_t dwCharacterID;
    char szCharName[16];
    uint8_t cWorldID;
    uint8_t cMainJob;
    uint8_t cMainJobLevel;
    uint16_t wZone;
    uint8_t cRace;
    uint8_t cFace;
    uint8_t cHair;
    uint8_t cSize;
    uint8_t cNation;
    // Whatever the char was wearing when last logged-out
    uint16_t wHead;
    uint16_t wBody;
    uint16_t wHands;
    uint16_t wLegs;
    uint16_t wFeet;
    // Equipped weapons, not jobs
    uint16_t wMain;
    uint16_t wSub;
    char szGoldWorldPass[16];
};

/**
 *  Any generic response packet that contains only the header
 *  and a response code.
 */
struct MESSAGE_GENERIC_RESPONSE
{
    CHAR_MQ_MESSAGE_HEADER Header;
    uint32_t dwResponseCode;
};

/**
 *  Message that is sent from the login server to the world server when
 *  a user attempts to log-in.
 */
struct MESSAGE_LOGIN_REQUEST
{
    CHAR_MQ_MESSAGE_HEADER Header;
    uint8_t bufInitialKey[16];
    uint32_t dwIPAddress;
    // Map server may decide to allow/disallow content based on these
    uint32_t dwExpansions;
    uint32_t dwFeatures;
    char szClientVesion[32];
};

/**
 *  Sent to confirm character creation and provide all character details.
 *  This is sent to the world server after the user selects the starting
 *  nation and confirms character creation.
 */
struct MESSAGE_CONFIRM_CREATE_REQUEST
{
    CHAR_MQ_MESSAGE_HEADER Header;
    CHARACTER_ENTRY Details;
};

#pragma pack(pop)

#endif
