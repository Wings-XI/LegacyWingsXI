/**
 *	@file ViewHandler.h
 *	Implementation of the view protocol
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under AGPLv3
 */

#ifndef FFXI_LOGIN_VIEWHANDLER_H
#define FFXI_LOGIN_VIEWHANDLER_H

#include "ProtocolHandler.h"
#include "FFXILoginPacket.h"
#include "LoginSession.h"
#include <memory>

/**
 *  View handler class, create an object for each connecting client.
 *  This protocol goes between the server and the game client itself,
 *  rather than the bootloader. The protocol is mostly reverse-engineered
 *  so some data may be unexplained and/or hardcoded. Corrections and
 *  documentation are very welcome.
 */
class ViewHandler : public ProtocolHandler
{
public:
    /**
     *  Create a new handler.
     *  @param connection TCP connection to assign to this handler
     */
    ViewHandler(std::shared_ptr<TCPConnection> connection);

    /**
     *  Generally it's advisable to explicitly call Shutdown before
     *  destroying the object.
     */
    virtual ~ViewHandler();

    /**
     *  Run the handler. Should generally not be called directly,
     *  use StartThread() to run the handler in a separate thread.
     */
    void Run();

private:

#pragma pack(push ,1)

    /**
     *  Character details. This struct is embedded within character list and character
     *  creation packets.
     */
    struct VIEW_CHAR_DETAILS_ENTRY {
        uint8_t cRace;          // 0
        uint8_t cZero1;         // 1
        uint8_t cMainJob;       // 2
        uint8_t bufZero2[3];    // 3-->5
        uint8_t cNation;        // 6
        uint16_t wZero2;        // 7-->8
        uint8_t cSize;          // 9
        uint16_t wZero3;        // 10-->11
        uint8_t cFace;          // 12
        uint8_t cHair;          // 13
        uint16_t wHead;         // 14-->15
        uint16_t wBody;         // 16-->17
        uint16_t wHands;        // 18-->19
        uint16_t wLegs;         // 20-->21
        uint16_t wFeet;         // 22-->23
        uint16_t wMain;         // 24-->25
        uint16_t wSub;          // 26-->27
        uint8_t cZone1;         // 28
        uint8_t cMainJobLevel;  // 29
        char bufUnknown5[4];    // 30-->33      (0x01, 0x00, 0x02, 0x00)
        uint16_t wZone2;        // 34-->35
        char bufUnknown6[60];   // 36-->95
    };

    /**
     *  Entry of a character in the character list packet
     */
    struct VIEW_CHAR_LIST_ENTRY {
        uint32_t dwContentID;             // 0-->3
        uint32_t dwCharacterID;           // 4-->7
        uint32_t dwEnabled;               // 8-->11
        char szCharacterName[16];         // 12-->27
        char szWorldName[16];             // 28-->43
        VIEW_CHAR_DETAILS_ENTRY Details;
    };

    /**
     *  Full character list packet
     */
    struct VIEW_PACKET_CHARACTER_LIST
    {
        uint32_t dwContentIds;  // 0-->3
        VIEW_CHAR_LIST_ENTRY CharList[16];
    };

    /**
     *  Features and expansion packet
     */
    struct VIEW_PACKET_EXPANSION_AND_FEATURES
    {
        uint32_t dwUnknown;
        uint32_t dwExpansions;
        uint32_t dwFeatures;
    };

    /**
     *  Server confirms login request (0x0B)
     */
    struct LOGIN_CONFIRM_PACKET
    {
        uint32_t dwContentID;
        uint32_t dwCharacterID;
        char szCharacterName[16];
        uint32_t dwUnknown; // Seems to always be 0x00000002
        uint32_t dwZoneIP;
        uint16_t wZonePort; // Network byte order
        uint16_t wZero1; // Seems to be little endian
        uint32_t dwSearchIP;
        uint16_t wSearchPort;
        uint16_t wZero2;
    };

    /**
     *  Client requests to log-in (0x07)
     */
    struct LOGIN_REQUEST_PACKET
    {
        uint32_t dwContentID;
        uint32_t dwCharacterID;
        char szCharacterName[16];
        uint8_t bufUnknown1[16];
        uint32_t dwUnknown2; // Seems to always be 0x00000003
        uint8_t bufUnknown3[16];
    };

    /**
     *  Client requests to create a new character (0x22)
     */
    struct CREATE_REQUEST_PACKET
    {
        uint32_t dwContentID;
        char szCharacterName[16];
        uint8_t bufUnknown1[16];
        char szWorldName[16];
        char szGoldWorldPass[11];
        uint8_t bufUnknown2[5];
    };

    /**
     *  Client confirms character creation (0x21)
     */
    struct CONFIRM_CREATE_REQUEST_PACKET
    {
        uint32_t dwContentID;            // 0-->3
        uint8_t bufUnknown1[16];         // 4-->19
        VIEW_CHAR_DETAILS_ENTRY Details;
    };

    /**
     *  Client requests to delete a character (0x14)
     */
    struct DELETE_REQUEST_PACKET
    {
        uint32_t dwContentID;
        uint32_t dwCharacterID;
        uint8_t bufUnknown1[16];
    };

#pragma pack(pop)

    /**
     *  Get the session pointer from either the first packet or
     *  the connecting IP address (depending on settings).
     *  @param pRequestPacket The payload of the request packet
     */
    bool GetSessionFromFirstPacket(const uint8_t* pRequestPacket);

    /**
     *  Check the client version and send back a list of features
     *  @param pRequestPacket The payload of the request packet
     */
    void CheckVersionAndSendFeatures(const uint8_t* pRequestPacket);

    /**
     *  Send the accout character list to the client.
     */
    void SendCharacterList();

    /**
     *  Send the world list packet to the client.
     */
    void SendWorldList();

    /**
     *  Handle a character login request (first phase).
     *  @param pRequestPacket Login request packet without headers
     */
    void HandleLoginRequest(const LOGIN_REQUEST_PACKET* pRequestPacket);

    /**
     *  Receive initial character details and associate them with a
     *  given content ID.
     *  @param pRequestPacket Request packet as sent by the client
     */
    void PrepareNewCharacter(const CREATE_REQUEST_PACKET* pRequestPacket);

    /**
     *  Set up all details for a new character and notify world server to confirm
     *  character creation.
     *  @param pRequestPacket Request packet as sent by the client
     */
    void ConfirmNewCharacter(const CONFIRM_CREATE_REQUEST_PACKET* pRequestPacket);

    /**
     *  Delete an existing character from the user's account and free the content ID
     *  @param pRequestPacket Request packet as sent by the client
     */
    void DeleteCharacter(const DELETE_REQUEST_PACKET* pRequestPacket);

    /**
     *  Clean any half-created characters from DB (i.e. characters that were reserved
     *  but whose creation process was not successfully completed.
     */
    void CleanHalfCreatedCharacters();

    /// FFXI Packet parser
    FFXILoginPacket mParser;
    /// Associated session
    std::shared_ptr<LoginSession> mpSession;
    /// Last login request packet received
    LOGIN_REQUEST_PACKET mLastLoginRequestPacket;
    /// Timeout for the current wait operation
    time_t mtmOperationTimeout;
};

#endif