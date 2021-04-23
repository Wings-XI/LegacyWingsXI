/*
===========================================================================

This file is part of Tonberry source code.

===========================================================================
*/

#include "flistutils.h"
#include "../message.h"



//    if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0 && Sql_NextRow(SqlHandle) == SQL_SUCCESS)





bool FLinitialize(CCharEntity* PChar) // make sure we have a SQL entry before we do anything
{

	int32 ret = Sql_Query(SqlHandle, "SELECT * FROM flist_settings WHERE callingchar = %u;", PChar->id);

	if (ret == SQL_ERROR)
	{
		ShowWarning(CL_WHITE"flistutils (FLinitialize) SQL ERROR...\n");
		return false;
	}

	if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) == 0)
	{
		uint32 now = (uint32)CVanaTime::getInstance()->getVanaTime();
		Sql_Query(SqlHandle, "INSERT INTO flist_settings VALUES (%u,1,3,29,3,0,%u);", PChar->id,now); // default settings
		return true;
	}

	if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) > 0)
	{
		return false;
	}

	return false;
}

int32 FLgetSetting(CCharEntity* PChar, uint8 setting) // 1:callingchar,2:visible,3:notifs,4:channel,5:size,6:lastcall,7:lastonline
{
	
	int32 ret = Sql_Query(SqlHandle, "SELECT * FROM flist_settings WHERE callingchar = %u;", PChar->id);

	if (ret == SQL_ERROR || Sql_NextRow(SqlHandle) != SQL_SUCCESS)
	{
		ShowWarning(CL_WHITE"flistutils (FLgetSetting) SQL ERROR...\n");
		return -1;
	}

	return (int32)Sql_GetIntData(SqlHandle, setting - 1);

}

int32 FLgetSettingByID(uint32 id, uint8 setting)
{

	int32 ret = Sql_Query(SqlHandle, "SELECT * FROM flist_settings WHERE callingchar = %u;", id);

	if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) == 0 && setting == 2) // trying to find someone's hide status when they don't have a settings entry yet
	{
		return 1; // not hidden
	}

	if (ret == SQL_ERROR || Sql_NextRow(SqlHandle) != SQL_SUCCESS)
	{
		ShowWarning(CL_WHITE"flistutils (FLgetSettingByID) SQL ERROR...\n");
		return 1;
	}

	return (int32)Sql_GetIntData(SqlHandle, setting - 1);

}

int32 FLnotify(CCharEntity* PChar, bool logoff, bool force)
{
	int32 visible = FLgetSetting(PChar, 2);
	if (visible == 0 && !force) // we have hidden set and we aren't forcing the notif
	{
		return 1; // don't notify anyone
	}

	int32 ret = Sql_Query(SqlHandle, "SELECT flist.callingchar,flist.listedchar,flist_settings.notifications,flist_settings.channel,flist.name,accounts_sessions.accid FROM flist INNER JOIN flist_settings ON flist.callingchar = flist_settings.callingchar INNER JOIN accounts_sessions ON flist.callingchar = accounts_sessions.charid WHERE flist.listedchar = %u;", PChar->id);
    int32 ret2 = 0;

	if (ret == SQL_ERROR)
	{
		ShowWarning(CL_WHITE"flistutils (FLnotify) SQL ERROR...\n");
		return 1;
	}

	if (Sql_NumRows(SqlHandle) == 0)
	{
		return 1;
	}

    Sql_t* sqlH2 = Sql_Malloc();
    if (map_config.mysql_ssl) {
        if (Sql_SSL(sqlH2,
            true,
            map_config.mysql_ssl_verify,
            map_config.mysql_ssl_ca.c_str(),
            map_config.mysql_ssl_cert.c_str(),
            map_config.mysql_ssl_key.c_str()) == SQL_ERROR) {
            return 1;
        }
    }

    if (Sql_Connect(sqlH2, map_config.mysql_login.c_str(),
        map_config.mysql_password.c_str(),
        map_config.mysql_host.c_str(),
        map_config.mysql_port,
        map_config.mysql_database.c_str()) == SQL_ERROR) {
        return 1;
    }

	uint32 callingchar;
	uint32 listedchar;
	uint32 notifications; // 0 = off, 1 = logoff, 2 = login, 3 = all
	uint32 channel;
	std::string line;
	std::string listedname;
    const char* listednameNT; // null terminated
	bool notify;

	while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
	{
		notify = false;
		callingchar = (uint32)Sql_GetIntData(SqlHandle, 0);
		listedchar = (uint32)Sql_GetIntData(SqlHandle, 1);
		notifications = (uint32)Sql_GetIntData(SqlHandle, 2);
		channel = (uint32)Sql_GetIntData(SqlHandle, 3);
		listedname = (const char*)Sql_GetData(SqlHandle, 4);

		if (!logoff && (notifications == 2 || notifications == 3)) // LOGINS ONLY or ON
			notify = true;
		if (logoff && (notifications == 1 || notifications == 3)) // LOGOUTS ONLY or ON
			notify = true;

        ret2 = Sql_Query(sqlH2, "SELECT * FROM flist WHERE listedchar = %u AND callingchar = %u;",callingchar,PChar->id); // i must be added on this person's list
        if (ret2 == SQL_ERROR || Sql_NumRows(sqlH2) == 0)
            notify = false;

        if (notify)
        {
            CCharEntity* targChar = zoneutils::GetChar(callingchar);
            if (targChar)
            {
                if (logoff)
                {
                    targChar->pushPacket(new CChatMessagePacket(targChar, (CHAT_MESSAGE_TYPE)channel, "== FLIST MESSAGE ==", ""));
                    line = "Notification: " + listedname + " has logged out.";
                    targChar->pushPacket(new CChatMessagePacket(targChar, (CHAT_MESSAGE_TYPE)channel, line, ""));
                }
                else
                {
                    targChar->pushPacket(new CChatMessagePacket(targChar, (CHAT_MESSAGE_TYPE)channel, "== FLIST MESSAGE ==", ""));
                    line = "Notification: " + listedname + " has logged in.";
                    targChar->pushPacket(new CChatMessagePacket(targChar, (CHAT_MESSAGE_TYPE)channel, line, ""));
                }
            }
            else
            {
                // send to message server, this target is either offline or on another server cluster
                listednameNT = listedname.c_str();

                int8 packetData[25]{};
                ref<bool>(packetData, 0) = logoff;
                ref<uint32>(packetData, 1) = callingchar;
                ref<uint8>(packetData, 5) = listednameNT[0];
                ref<uint8>(packetData, 6) = listednameNT[1];
                ref<uint8>(packetData, 7) = listednameNT[2];
                ref<uint8>(packetData, 8) = listednameNT[3];
                ref<uint8>(packetData, 9) = listednameNT[4];
                ref<uint8>(packetData, 10) = listednameNT[5];
                ref<uint8>(packetData, 11) = listednameNT[6];
                ref<uint8>(packetData, 12) = listednameNT[7];
                ref<uint8>(packetData, 13) = listednameNT[8];
                ref<uint8>(packetData, 14) = listednameNT[9];
                ref<uint8>(packetData, 15) = listednameNT[10];
                ref<uint8>(packetData, 16) = listednameNT[11];
                ref<uint8>(packetData, 17) = listednameNT[12];
                ref<uint8>(packetData, 18) = listednameNT[13];
                ref<uint8>(packetData, 19) = listednameNT[14];
                ref<uint8>(packetData, 20) = listednameNT[15];
                ref<uint32>(packetData, 21) = channel;
                message::send(MSG_SEND_FL_NOTIF, packetData, sizeof packetData, nullptr);
            }
		}
	}

    Sql_Free(sqlH2);
	return 1;
}

int32 FLnotifyCrossCluster(CCharEntity* PChar, bool logoff, std::string listedcharname, uint32 channel)
{
    std::string line;
    if (logoff)
    {
        PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)channel, "== FLIST MESSAGE ==", ""));
        line = "Notification: " + listedcharname + " has logged out.";
        PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)channel, line, ""));
    }
    else
    {
        PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)channel, "== FLIST MESSAGE ==", ""));
        line = "Notification: " + listedcharname + " has logged in.";
        PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)channel, line, ""));
    }

    return 1;
}

int32 FLsetNote(CCharEntity* PChar, uint8 sChannel, std::string listedcharname, std::string note)
{
	bool removed = false;
	if (note != "actualempty")
	{
		removed = false;
	}
	if (note == "actualempty")
	{
		removed = true;
	}
	
	uint8 c = 0;
	bool truncated = false;
	while (note[c] != '\0' && c < 16) { c++; } // count string length
	if (c == 16 && note[c] != '\0') { note[c] = '\0'; truncated = true; } // if 17 or more, truncate
	char notex[16 * 2 + 1];
	Sql_EscapeString(SqlHandle, notex, note.c_str());
	
	std::string line;
	int32 ret = Sql_Query(SqlHandle, "SELECT charid,charname FROM chars WHERE charname like '%s';", listedcharname);

	if (ret == SQL_ERROR)
	{
		ShowWarning(CL_WHITE"flistutils (FLsetNote) SQL ERROR...\n");
		return -1;
	}

	if (Sql_NumRows(SqlHandle) == 0)
	{
		//PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "== FLIST MESSAGE (ERROR) ==", ""));
		//line = "Player does not exist: " + removecharname;
		//PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, line, ""));
		//return 1;
	}

	std::string listedcharnamenew = listedcharname;

	if (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
	{
		listedcharnamenew = (const char*)Sql_GetData(SqlHandle, 1);
	}
	else
	{
		ShowWarning(CL_WHITE"flistutils (FLsetNote) SQL NONFATAL ERROR...\n");
		//return -1;
	}

	ret = Sql_Query(SqlHandle, "SELECT callingchar,listedchar,name FROM flist WHERE callingchar = %u AND name like '%s';", PChar->id, listedcharnamenew);

	if (ret == SQL_ERROR)
	{
		ShowWarning(CL_WHITE"flistutils (FLsetNote) SQL ERROR...\n");
		return -1;
	}
	if (Sql_NumRows(SqlHandle) == 0)
	{
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "== FLIST MESSAGE (ERROR) ==", ""));
		line = "Player is not on your friend list: " + listedcharnamenew;
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, line, ""));
		return 1;
	}

	ret = Sql_Query(SqlHandle, "UPDATE flist SET note = '%s' WHERE callingchar = %u AND name like '%s';", notex, PChar->id, listedcharnamenew);
	
	if (ret == SQL_ERROR)
	{
		ShowWarning(CL_WHITE"flistutils (FLsetNote)(update) SQL ERROR...\n");
		return -1;
	}

	if (!removed)
	{
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "== FLIST MESSAGE ==", ""));
		line = "Friend note successfully updated for: " + listedcharnamenew;
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, line, ""));
		if (truncated) { PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "(Friend note was truncated to 16 characters)", "")); }
		return 1;
	}
	if (removed)
	{
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "== FLIST MESSAGE ==", ""));
		line = "Friend note removed for: " + listedcharnamenew;
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, line, ""));
		return 1;
	}

	return 2;

}

int32 FLsetNotifs(CCharEntity* PChar, uint8 sChannel, uint8 notifs)
{
	
	int32 ret = Sql_Query(SqlHandle, "UPDATE flist_settings SET notifications = %u WHERE callingchar = %u;", notifs, PChar->id);

	if (ret == SQL_ERROR) { ShowWarning(CL_WHITE"flistutils (FLsetNotifs) SQL ERROR...\n"); return 1; }

	std::string line;
	PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "== FLIST MESSAGE ==", ""));
	line = "Notifications set to: ";
	if (notifs == 0) { line += "OFF"; }
	if (notifs == 1) { line += "LOGOUTS ONLY"; }
	if (notifs == 2) { line += "LOGINS ONLY"; }
	if (notifs == 3) { line += "ON"; }
	PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, line, ""));
	return 1;
}

int32 FLsetSize(CCharEntity* PChar, uint8 sChannel, uint8 size)
{

	int32 ret = Sql_Query(SqlHandle, "UPDATE flist_settings SET size = %u WHERE callingchar = %u;", size, PChar->id);

	if (ret == SQL_ERROR) { ShowWarning(CL_WHITE"flistutils (FLsetNotifs) SQL ERROR...\n"); return 2; }

	std::string line;
	PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "== FLIST MESSAGE ==", ""));
	line = "List size set to: ";
	if (size == 3) { line += "FULL"; }
	if (size == 2) { line += "COMPACT"; }
	PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, line, ""));

	return 1;
}

int32 FLsetChannel(CCharEntity* PChar, uint8 channel)
{

	int32 ret = Sql_Query(SqlHandle, "UPDATE flist_settings SET channel = %u WHERE callingchar = %u;", channel, PChar->id);

	if (ret == SQL_ERROR) { ShowWarning(CL_WHITE"flistutils (FLsetNotifs) SQL ERROR...\n"); return 1; }

	std::string line;
	PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)channel, "== FLIST MESSAGE ==", ""));
	line = "Channel set to: ";
	if (channel == 13) { line += "SAY"; }
	if (channel == 14) { line += "SHOUT"; }
	if (channel == 15) { line += "PARTY"; }
	if (channel == 16) { line += "LS1"; }
	if (channel == 28) { line += "LS2"; }
	if (channel == 29) { line += "SYSTEM (DEFAULT)"; }
	PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)channel, line, ""));
	return 1;
}

int32 FLhide(CCharEntity* PChar, uint8 sChannel, bool hide, bool silent)
{
	int32 ret;
	
	if (hide)
	{
		
		if (!silent) { FLnotify(PChar, true, true); }
		
		if (!silent)
		{
			ret = Sql_Query(SqlHandle, "UPDATE flist_settings SET lastonline = %u WHERE callingchar = %u;", (uint32)CVanaTime::getInstance()->getVanaTime(), PChar->id);
			if (ret == SQL_ERROR) { ShowWarning(CL_WHITE"flistutils (FLhide)(1)(0) SQL ERROR...\n"); return 1; }
		}
		
		ret = Sql_Query(SqlHandle, "UPDATE flist_settings SET visible = 0 WHERE callingchar = %u;", PChar->id);
		if (ret == SQL_ERROR) { ShowWarning(CL_WHITE"flistutils (FLhide)(1)(1) SQL ERROR...\n"); return 1; }
		ret = Sql_Query(SqlHandle, "UPDATE flist SET status = -1 WHERE listedchar = %u;", PChar->id);
		if (ret == SQL_ERROR) { ShowWarning(CL_WHITE"flistutils (FLhide)(1)(2) SQL ERROR...\n"); return 1; }
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "== FLIST MESSAGE ==", ""));
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "Your status has been set to hidden.", ""));
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "You will show up as OFFLINE on your friends' lists.", ""));
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "Your friends will not be notified when you login or logout.", ""));
		if (!silent) { PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "*A logout notification was sent out now.", "")); }
		if (!silent) { PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "*(Use '!flist hide silent' to avoid this)", "")); }

		return 1;
	}

	if (!hide)
	{

		if (!silent) { FLnotify(PChar, false, true); }

		ret = Sql_Query(SqlHandle, "UPDATE flist_settings SET visible = 1 WHERE callingchar = %u;", PChar->id);
		if (ret == SQL_ERROR) { ShowWarning(CL_WHITE"flistutils (FLhide)(2)(1) SQL ERROR...\n"); return 1; }
		ret = Sql_Query(SqlHandle, "UPDATE flist SET status = 1 WHERE listedchar = %u;", PChar->id);
		if (ret == SQL_ERROR) { ShowWarning(CL_WHITE"flistutils (FLhide)(2)(2) SQL ERROR...\n"); return 1; }
		ret = Sql_Query(SqlHandle, "UPDATE flist_settings SET lastonline = %u WHERE callingchar = %u;", (uint32)CVanaTime::getInstance()->getVanaTime(), PChar->id);
		if (ret == SQL_ERROR) { ShowWarning(CL_WHITE"flistutils (FLhide)(2)(3) SQL ERROR...\n"); return 1; }
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "== FLIST MESSAGE ==", ""));
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "Your status has been set to visible.", ""));
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "You will show up as ONLINE on your friends' lists.", ""));
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "Your friends will be notified when you login or logout.", ""));
		if (!silent) { PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "*A login notification was sent out now.", "")); }
		if (!silent) { PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "*(Use '!flist unhide silent' to avoid this)", "")); }

		return 1;
	}

	return 2;

}

int32 FLremove(CCharEntity* PChar, std::string removecharname, uint8 sChannel)
{

	std::string line;
	int32 ret = Sql_Query(SqlHandle, "SELECT charid,charname FROM chars WHERE charname like '%s';", removecharname);

	if (ret == SQL_ERROR)
	{
		ShowWarning(CL_WHITE"flistutils (FLremove) SQL ERROR...\n");
		return -1;
	}

	if (Sql_NumRows(SqlHandle) == 0)
	{
		//PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "== FLIST MESSAGE (ERROR) ==", ""));
		//line = "Player does not exist: " + removecharname;
		//PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, line, ""));
		//return 1;
	}

	std::string removecharnamenew = removecharname;

	if (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
	{
		removecharnamenew = (const char*)Sql_GetData(SqlHandle, 1);
	}
	else
	{
		ShowWarning(CL_WHITE"flistutils (FLremove) SQL NONFATAL ERROR...\n");
		//return -1;
	}

	ret = Sql_Query(SqlHandle, "SELECT callingchar,listedchar,name FROM flist WHERE callingchar = %u AND name like '%s';", PChar->id, removecharnamenew);

	if (ret == SQL_ERROR)
	{
		ShowWarning(CL_WHITE"flistutils (FLremove)(2) SQL ERROR...\n");
		return -1;
	}
	if (Sql_NumRows(SqlHandle) == 0)
	{
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "== FLIST MESSAGE (ERROR) ==", ""));
		line = "Player is not on your friend list: " + removecharnamenew;
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, line, ""));
		return 1;
	}

	ret = Sql_Query(SqlHandle, "DELETE FROM flist WHERE callingchar = %u AND name like '%s';", PChar->id, removecharnamenew);
	if (ret == SQL_ERROR)
	{
		ShowWarning(CL_WHITE"flistutils (FLremove)(3) SQL ERROR...\n");
		return -1;
	}

	PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "== FLIST MESSAGE ==", ""));
	line = "Friend successfully removed: " + removecharnamenew;
	PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, line, ""));

	return 1;

}

int32 FLadd(CCharEntity* PChar, std::string addcharname, uint8 sChannel, uint8 sVisible) // add a person to my friend's list
{

	int32 ret = Sql_Query(SqlHandle, "SELECT * FROM flist WHERE callingchar = %u;", PChar->id);
	
	if (ret == SQL_ERROR)
	{
		ShowWarning(CL_WHITE"flistutils (FLadd) SQL ERROR...\n");
		return -1;
	}

	if (Sql_NumRows(SqlHandle) >= 48)
	{
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "== FLIST MESSAGE (ERROR) ==", ""));
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "You have reached the maximum friend count (48)!", ""));
		return 1;
	}

	std::string line;
	ret = Sql_Query(SqlHandle, "SELECT charid,charname FROM chars WHERE charname like '%s';", addcharname);

	if (ret == SQL_ERROR)
	{
		ShowWarning(CL_WHITE"flistutils (FLadd) SQL ERROR...\n");
		return -1;
	}

	if (Sql_NumRows(SqlHandle) == 0)
	{
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "== FLIST MESSAGE (ERROR) ==", ""));
		line = "Player does not exist: " + addcharname;
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, line, ""));
		return 1;
	}

	if (Sql_NextRow(SqlHandle) != SQL_SUCCESS)
	{
		ShowWarning(CL_WHITE"flistutils (FLadd) SQL ERROR...\n");
		return -1;
	}

	uint32 addcharid = Sql_GetIntData(SqlHandle, 0);
	std::string addcharnamenew = (const char*)Sql_GetData(SqlHandle, 1);

	if (addcharid == PChar->id)
	{
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "== FLIST MESSAGE (ERROR) ==", ""));
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "You cannot add yourself to your friend list!", ""));
		return 1;
	}

	ret = Sql_Query(SqlHandle, "SELECT * FROM flist WHERE callingchar = %u AND listedchar = %u;", PChar->id, addcharid);

	if (ret == SQL_ERROR)
	{
		ShowWarning(CL_WHITE"flistutils (FLadd) SQL ERROR...\n");
		return -1;
	}

	if (Sql_NumRows(SqlHandle) != 0)
	{
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "== FLIST MESSAGE (ERROR) ==", ""));
		line = "Friend is already on your list: " + addcharnamenew;
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, line, ""));
		return 1;
	}

	int8 status = 1; // online
	if (sVisible == 0) { status = -1; } // we are invisible/hidden

	ret = Sql_Query(SqlHandle, "SELECT * FROM flist WHERE callingchar = %u AND listedchar = %u;", addcharid, PChar->id); // flipped around, we are checking their flist

	if (ret == SQL_ERROR)
	{
		ShowWarning(CL_WHITE"flistutils (FLadd) SQL ERROR...\n");
		return -1;
	}

	if (Sql_NumRows(SqlHandle) != 0) // they have us added already!!
	{
		ret = Sql_Query(SqlHandle, "UPDATE flist SET status = %i WHERE callingchar = %u AND listedchar = %u;", status, addcharid, PChar->id); // inserting our status into their flist
	}

	int32 theirvisible = FLgetSettingByID(addcharid,2);
	int8 theirstatus = 1;

	ret = Sql_Query(SqlHandle, "SELECT * FROM accounts_sessions WHERE charid = %u;", addcharid);

	if (ret == SQL_ERROR)
	{
		ShowWarning(CL_WHITE"flistutils (FLadd) SQL ERROR...\n");
		return -1;
	}
	if (Sql_NumRows(SqlHandle) == 0) { theirstatus = 0; } // they are offline
	if (theirvisible == 0) { theirstatus = -1; } // their status is hidden

	ret = Sql_Query(SqlHandle, "INSERT INTO flist VALUES (%u,%u,%i,'%s','actualempty');", PChar->id, addcharid, theirstatus, addcharnamenew); // inserting them into our flist

	if (ret == SQL_ERROR)
	{
		ShowWarning(CL_WHITE"flistutils (FLadd) SQL ERROR...\n");
		return -1;
	}

	PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "== FLIST MESSAGE ==", ""));
	line = "Friend successfully added: " + addcharnamenew;
	PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, line, ""));
	return 1;
}

int32 FLprintList(CCharEntity* PChar, uint8 sChannel, uint8 sSize)
{
	std::string headerText;
	
	uint8 numOnline = FLnumOnline(PChar);
	uint8 numTotal = FLnumTotal(PChar);

	if (sSize == 3) // full
	{
																		headerText = "                                    FRIEND LIST: ";
		headerText += std::to_string(numOnline) + " / " + std::to_string(numTotal);
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, headerText, ""));
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "===========================================================================", ""));
		FLpopulate(PChar, sChannel, sSize);
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "===========================================================================", ""));
	}

	if (sSize == 2) // compact
	{
																		headerText = "                  FRIEND LIST: ";
		headerText += std::to_string(numOnline) + " / " + std::to_string(numTotal);
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, headerText, ""));
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "=============================================", ""));
		FLpopulate(PChar, sChannel, sSize);
		PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, "=============================================", ""));
	}

	int32 ret = Sql_Query(SqlHandle, "UPDATE flist_settings SET lastcall = %u WHERE callingchar = %u;", (uint32)CVanaTime::getInstance()->getVanaTime(), PChar->id);

	if (ret == SQL_ERROR)
	{
		ShowWarning(CL_WHITE"flistutils (FLprintList) SQL ERROR...\n");
		return -1;
	}

	return 0;

}

std::string FLgetRace(uint8 raceid)
{
	/*
	-- 1: HUMEM
	-- 2: HUMEF
	-- 3: ELVNM
	-- 4: ELVNF
	-- 5: TARUM
	-- 6: TARUF
	-- 7: MITHF
	-- 8: GALKM
	*/
	
	switch (raceid)
	{
	case 1:
		return "HUMM";
		break;
	case 2:
		return "HUMF";
		break;
	case 3:
		return "ELVM";
		break;
	case 4:
		return "ELVF";
		break;
	case 5:
		return "TARM";
		break;
	case 6:
		return "TARF";
		break;
	case 7:
		return "MITF";
		break;
	case 8:
		return "GALM";
		break;
	}

	return "ERROR";
}

void FLpopulate(CCharEntity* PChar, uint8 sChannel, uint8 sSize)
{
	std::string line;
	uint8 mjob;
	uint8 mlvl;
	uint8 sjob;
	uint8 slvl;
	uint32 nameflag;
	uint16 zone;
	uint32 lastonline;
	uint16 race;
	
	// online reciprocated friends first
	
	int32 ret = Sql_Query(SqlHandle, "SELECT flist.listedchar,flist.status,flist.name,flist.note,char_stats.mjob,char_stats.mlvl,char_stats.sjob,char_stats.slvl,char_stats.nameflags,chars.pos_zone,flist_settings.lastonline,char_look.race FROM flist INNER JOIN char_stats ON flist.listedchar = char_stats.charid INNER JOIN chars ON flist.listedchar = chars.charid INNER JOIN flist_settings ON flist.listedchar = flist_settings.callingchar INNER JOIN char_look ON flist.listedchar = char_look.charid WHERE status = 1 AND flist.callingchar = %u AND flist.listedchar IN (SELECT flist.callingchar FROM flist WHERE flist.listedchar = %u) ORDER BY flist.status DESC,flist.name ASC;", PChar->id, PChar->id);
	
	if (ret == SQL_ERROR)
	{
		ShowWarning(CL_WHITE"flistutils (FLpopulate) SQL ERROR...\n");
		return;
	}

	if (sSize == 3) // full
	{
		while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
		{
			if (Sql_GetIntData(SqlHandle, 1) == 1) // online
			{
				mjob = Sql_GetIntData(SqlHandle, 4);
				mlvl = Sql_GetIntData(SqlHandle, 5);
				sjob = Sql_GetIntData(SqlHandle, 6);
				slvl = Sql_GetIntData(SqlHandle, 7);
				nameflag = (uint32)Sql_GetIntData(SqlHandle, 8);
				zone = (uint16)Sql_GetIntData(SqlHandle, 9);
				race = (uint16)Sql_GetIntData(SqlHandle, 11);

				line = "~ ";
				line += (const char*)Sql_GetData(SqlHandle, 2); line += " ";
				line += FLgetRace((uint8)race); line += " - ";
				if (nameflag & FLAG_ANON) { line += "(  ??? / ???  ) - "; }
				else { line += "("; line += FLgetJob(mjob); line += std::to_string(mlvl); line += "/"; line += FLgetJob(sjob); line += std::to_string(slvl); line += ")"; line += " - "; }
				line += FLgetZone(zone,sSize);
				if ((std::string)((const char*)Sql_GetData(SqlHandle, 3)) != "actualempty") { line += " - *"; line += (const char*)Sql_GetData(SqlHandle, 3); line += "*"; } // if we have a note
			}
			PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, line, ""));
		}
	}

	if (sSize == 2) // compact
	{
		while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
		{
			if (Sql_GetIntData(SqlHandle, 1) == 1) // online
			{
				mjob = Sql_GetIntData(SqlHandle, 4);
				mlvl = Sql_GetIntData(SqlHandle, 5);
				sjob = Sql_GetIntData(SqlHandle, 6);
				slvl = Sql_GetIntData(SqlHandle, 7);
				nameflag = (uint32)Sql_GetIntData(SqlHandle, 8);
				zone = (uint16)Sql_GetIntData(SqlHandle, 9);
				race = (uint16)Sql_GetIntData(SqlHandle, 11);

				line = "~ ";
				line += (const char*)Sql_GetData(SqlHandle, 2); line += " - ";
				if (nameflag & FLAG_ANON) { line += "(  ??? / ???  ) - "; }
				else { line += "("; line += FLgetJob(mjob); line += std::to_string(mlvl); line += "/"; line += FLgetJob(sjob); line += std::to_string(slvl); line += ")"; line += " - "; }
				line += FLgetZone(zone, sSize);
				if ((std::string)((const char*)Sql_GetData(SqlHandle, 3)) != "actualempty") { line += " - *"; line += (const char*)Sql_GetData(SqlHandle, 3); } // if we have a note
			}
			PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, line, ""));
		}
	}

	// offline reciprocated friends next

	ret = Sql_Query(SqlHandle, "SELECT flist.listedchar,flist.status,flist.name,flist.note,char_stats.mjob,char_stats.mlvl,char_stats.sjob,char_stats.slvl,char_stats.nameflags,chars.pos_zone,flist_settings.lastonline,char_look.race FROM flist INNER JOIN char_stats ON flist.listedchar = char_stats.charid INNER JOIN chars ON flist.listedchar = chars.charid INNER JOIN flist_settings ON flist.listedchar = flist_settings.callingchar INNER JOIN char_look ON flist.listedchar = char_look.charid WHERE status IN (0,-1) AND flist.callingchar = %u AND flist.listedchar IN (SELECT flist.callingchar FROM flist WHERE flist.listedchar = %u) ORDER BY flist.status DESC,flist_settings.lastonline DESC;", PChar->id, PChar->id);

	if (ret == SQL_ERROR)
	{
		ShowWarning(CL_WHITE"flistutils (FLpopulate) SQL ERROR...\n");
		return;
	}

	if (sSize == 3) // full
	{
		while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
		{
			if (Sql_GetIntData(SqlHandle, 1) == 0 || Sql_GetIntData(SqlHandle, 1) == -1) // offline or invisible
			{
				lastonline = (uint32)CVanaTime::getInstance()->getVanaTime() - (uint32)Sql_GetIntData(SqlHandle, 10);
				race = (uint16)Sql_GetIntData(SqlHandle, 11);

				line = "    ";
				line += (const char*)Sql_GetData(SqlHandle, 2); line += " ";
				line += FLgetRace((uint8)race); line += " - ";
				line += "OFFLINE"; line += " ";
				line += "["; line += FLgetLastOnline(lastonline); line += "]";
				if ((std::string)((const char*)Sql_GetData(SqlHandle, 3)) != "actualempty") { line += " - *"; line += (const char*)Sql_GetData(SqlHandle, 3); line += "*"; } // if we have a note
			}
			PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, line, ""));
		}
	}

	if (sSize == 2) // compact
	{
		while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
		{
			if (Sql_GetIntData(SqlHandle, 1) == 0 || Sql_GetIntData(SqlHandle, 1) == -1) // offline or invisible
			{
				lastonline = (uint32)CVanaTime::getInstance()->getVanaTime() - (uint32)Sql_GetIntData(SqlHandle, 10);
				race = (uint16)Sql_GetIntData(SqlHandle, 11);

				line = "    ";
				line += (const char*)Sql_GetData(SqlHandle, 2); line += " - ";
				line += "OFFLINE"; line += " ";
				line += "["; line += FLgetLastOnline(lastonline); line += "]";
				if ((std::string)((const char*)Sql_GetData(SqlHandle, 3)) != "actualempty") { line += " - *"; line += (const char*)Sql_GetData(SqlHandle, 3); } // if we have a note
			}
			PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, line, ""));
		}
	}

	// now, unreciprocated "friends"
	
	ret = Sql_Query(SqlHandle, "SELECT listedchar,status,name,note FROM flist WHERE callingchar = %u AND listedchar NOT IN (SELECT callingchar FROM flist WHERE listedchar = %u) ORDER BY name ASC;", PChar->id, PChar->id);

	if (ret == SQL_ERROR)
	{
		ShowWarning(CL_WHITE"flistutils (FLpopulate) SQL ERROR...\n");
		return;
	}

	if (sSize == 3) // full
	{
		while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
		{
			line = "  ";
			line += (const char*)Sql_GetData(SqlHandle, 2); line += " - ";
			line += "OFFLINE";
			if ((std::string)((const char*)Sql_GetData(SqlHandle, 3)) != "actualempty") { line += " - *"; line += (const char*)Sql_GetData(SqlHandle, 3); line += "*"; } // if we have a note
			PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, line, ""));
		}
	}

	if (sSize == 2) // compact
	{
		while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
		{
			line = "  ";
			line += (const char*)Sql_GetData(SqlHandle, 2); line += " - ";
			line += "OFFLINE";
			if ((std::string)((const char*)Sql_GetData(SqlHandle, 3)) != "actualempty") { line += " - *"; line += (const char*)Sql_GetData(SqlHandle, 3); } // if we have a note
			PChar->pushPacket(new CChatMessagePacket(PChar, (CHAT_MESSAGE_TYPE)sChannel, line, ""));
		}
	}

	return;
}

uint8 FLnumOnline(CCharEntity* PChar)
{
	int32 ret = Sql_Query(SqlHandle, "SELECT * FROM flist WHERE status = 1 AND callingchar = %u AND listedchar IN(SELECT callingchar FROM flist WHERE listedchar = %u) ORDER BY status DESC, name ASC;", PChar->id, PChar->id);
	
	if (ret != SQL_ERROR)
	{
		return (uint8)Sql_NumRows(SqlHandle);
	}

	return 0;
}

uint8 FLnumTotal(CCharEntity* PChar)
{
	int32 ret = Sql_Query(SqlHandle, "SELECT * FROM flist WHERE callingchar = %u;", PChar->id);
	
	if (ret != SQL_ERROR)
	{
		return (uint8)Sql_NumRows(SqlHandle);
	}

	return 0;
}

std::string FLgetLastOnline(uint32 time)
{
	
	if (time >= 31536000) // 1y or more
	{
		return std::to_string(time / 31536000) + "y";
	}

	if (time >= 86400 && time < 31536000) // more than 1d, less than 365d
	{
		return std::to_string(time / 86400) + "d";
	}

	if (time >= 3600 && time < 86400) // more than 1h, less than 24h
	{
		return std::to_string(time / 3600) + "h";
	}

	if (time >= 60 && time < 3600) // more than 1m, less than 60m
	{
		return std::to_string(time / 60) + "m";
	}

	if (time < 60) // less than 60s
	{
		return std::to_string(time) + "s";
	}
	
	return "ERROR";
}

std::string FLgetJob(uint8 jobid)
{
	switch (jobid)
	{
	case (JOBTYPE)JOB_WAR:
		return "WAR";
		break;
	case (JOBTYPE)JOB_MNK:
		return "MNK";
		break;
	case (JOBTYPE)JOB_WHM:
		return "WHM";
		break;
	case (JOBTYPE)JOB_BLM:
		return "BLM";
		break;
	case (JOBTYPE)JOB_RDM:
		return "RDM";
		break;
	case (JOBTYPE)JOB_THF:
		return "THF";
		break;
	case (JOBTYPE)JOB_PLD:
		return "PLD";
		break;
	case (JOBTYPE)JOB_DRK:
		return "DRK";
		break;
	case (JOBTYPE)JOB_BST:
		return "BST";
		break;
	case (JOBTYPE)JOB_BRD:
		return "BRD";
		break;
	case (JOBTYPE)JOB_RNG:
		return "RNG";
		break;
	case (JOBTYPE)JOB_SAM:
		return "SAM";
		break;
	case (JOBTYPE)JOB_NIN:
		return "NIN";
		break;
	case (JOBTYPE)JOB_DRG:
		return "DRG";
		break;
	case (JOBTYPE)JOB_SMN:
		return "SMN";
		break;
	case (JOBTYPE)JOB_BLU:
		return "BLU";
		break;
	case (JOBTYPE)JOB_COR:
		return "COR";
		break;
	case (JOBTYPE)JOB_PUP:
		return "PUP";
		break;
	case (JOBTYPE)JOB_DNC:
		return "DNC";
		break;
	case (JOBTYPE)JOB_SCH:
		return "SCH";
		break;
	}
	return "???";
}

std::string FLgetZone(uint16 zoneid, uint8 sSize)
{
	if (sSize == 3) // full
	{
		switch (zoneid)
		{
		case 0:
			return "ERROR";
			break;
		case 1:
			return "Phanauet Channel";
			break;
		case 2:
			return "Carpenters' Landing";
			break;
		case 3:
			return "Manaclipper";
			break;
		case 4:
			return "Bibiki Bay";
			break;
		case 5:
			return "Uleguerand Range";
			break;
		case 6:
			return "Bearclaw Pinnacle";
			break;
		case 7:
			return "Attohwa Chasm";
			break;
		case 8:
			return "Boneyard Gully";
			break;
		case 9:
			return "Pso'Xja";
			break;
		case 10:
			return "The Shrouded Maw";
			break;
		case 11:
			return "Oldton Movalpolos";
			break;
		case 12:
			return "Newton Movalpolos";
			break;
		case 13:
			return "Mine Shaft 2716";
			break;
		case 14:
			return "Hall of Transference";
			break;
		case 16:
			return "Promyvion Holla";
			break;
		case 17:
			return "Spire of Holla";
			break;
		case 18:
			return "Promyvion Dem";
			break;
		case 19:
			return "Spire of Dem";
			break;
		case 20:
			return "Promyvion Mea";
			break;
		case 21:
			return "Spire of Mea";
			break;
		case 22:
			return "Promyvion Vahzl";
			break;
		case 23:
			return "Spire of Vahzl";
			break;
		case 24:
			return "Lufaise Meadows";
			break;
		case 25:
			return "Misareaux Coast";
			break;
		case 26:
			return "Tavnazian Safehold";
			break;
		case 27:
			return "Phomiuna Aqueducts";
			break;
		case 28:
			return "Sacrarium";
			break;
		case 29:
			return "Riverne Site B01";
			break;
		case 30:
			return "Riverne Site A01";
			break;
		case 31:
			return "Monarch Linn";
			break;
		case 32:
			return "Sealion's Den";
			break;
		case 33:
			return "Al'Taieu";
			break;
		case 34:
			return "Grand Palace of Hu'Xzoi";
			break;
		case 35:
			return "The Garden of Ru'Hmet";
			break;
		case 36:
			return "Empyreal Paradox";
			break;
		case 37:
			return "Temenos";
			break;
		case 38:
			return "Apollyon";
			break;
		case 39:
			return "Dynamis Valkurm";
			break;
		case 40:
			return "Dynamis Buburimu";
			break;
		case 41:
			return "Dynamis Qufim";
			break;
		case 42:
			return "Dynamis Tavnazia";
			break;
		case 43:
			return "Diorama Abdhaljs Ghelsba";
			break;
		case 44:
			return "Abdhaljs Isle Purgonorgo";
			break;
		case 46:
			return "Open sea route to Al Zahbi";
			break;
		case 47:
			return "Open sea route to Mhaura";
			break;
		case 48:
			return "Al Zahbi";
			break;
		case 50:
			return "Aht Urhgan Whitegate";
			break;
		case 51:
			return "Wajaom Woodlands";
			break;
		case 52:
			return "Bhaflau Thickets";
			break;
		case 53:
			return "Nashmau";
			break;
		case 54:
			return "Arrapago Reef";
			break;
		case 55:
			return "Ilrusi Atoll";
			break;
		case 56:
			return "Periqia";
			break;
		case 57:
			return "Talacca Cove";
			break;
		case 58:
			return "Silver Sea route to Nashmau";
			break;
		case 59:
			return "Silver Sea route to Al Zahbi";
			break;
		case 60:
			return "The Ashu Talif";
			break;
		case 61:
			return "Mount Zhayolm";
			break;
		case 62:
			return "Halvung";
			break;
		case 63:
			return "Lebros Cavern";
			break;
		case 64:
			return "Navukgo Execution Chamber";
			break;
		case 65:
			return "Mamook";
			break;
		case 66:
			return "Mamool Ja Training Grounds";
			break;
		case 67:
			return "Jade Sepulcher";
			break;
		case 68:
			return "Aydeewa Subterrane";
			break;
		case 69:
			return "Leujaoam Sanctum";
			break;
		case 70:
			return "Chocobo Circuit";
			break;
		case 71:
			return "The Colosseum";
			break;
		case 72:
			return "Alzadaal Undersea Ruins";
			break;
		case 73:
			return "Zhayolm Remnants";
			break;
		case 74:
			return "Arrapago Remnants";
			break;
		case 75:
			return "Bhaflau Remnants";
			break;
		case 76:
			return "Silver Sea Remnants";
			break;
		case 77:
			return "Nyzul Isle";
			break;
		case 78:
			return "Hazhalm Testing Grounds";
			break;
		case 79:
			return "Caedarva_Mire";
			break;
		case 82:
			return "Jugner Forest [S]";
			break;
		case 100:
			return "West Ronfaure";
			break;
		case 101:
			return "East Ronfaure";
			break;
		case 102:
			return "La Theine Plateau";
			break;
		case 103:
			return "Valkurm Dunes";
			break;
		case 104:
			return "Jugner Forest";
			break;
		case 105:
			return "Batallia Downs";
			break;
		case 106:
			return "North Gustaberg";
			break;
		case 107:
			return "South Gustaberg";
			break;
		case 108:
			return "Konschtat Highlands";
			break;
		case 109:
			return "Pashhow Marshlands";
			break;
		case 110:
			return "Rolanberry Fields";
			break;
		case 111:
			return "Beaucedine Glacier";
			break;
		case 112:
			return "Xarcabard";
			break;
		case 113:
			return "Cape Teriggan";
			break;
		case 114:
			return "Eastern Altepa Desert";
			break;
		case 115:
			return "West Sarutabaruta";
			break;
		case 116:
			return "East Sarutabaruta";
			break;
		case 117:
			return "Tahrongi Canyon";
			break;
		case 118:
			return "Buburimu Peninsula";
			break;
		case 119:
			return "Meriphataud Mountains";
			break;
		case 120:
			return "Sauromugue Champaign";
			break;
		case 121:
			return "The Sanctuary of Zi'Tah";
			break;
		case 122:
			return "Ro'Maeve";
			break;
		case 123:
			return "Yuhtunga Jungle";
			break;
		case 124:
			return "Yhoator Jungle";
			break;
		case 125:
			return "Western Altepa Desert";
			break;
		case 126:
			return "Qufim Island";
			break;
		case 127:
			return "Behemoths Dominion";
			break;
		case 128:
			return "Valley of Sorrows";
			break;
		case 129:
			return "Ghoyus Reverie";
			break;
		case 130:
			return "Ru'Aun Gardens";
			break;
		case 131:
			return "Mordion Gaol";
			break;
		case 132:
			return "Abyssea La Theine";
			break;
		case 134:
			return "Dynamis Beaucedine";
			break;
		case 135:
			return "Dynamis Xarcabard";
			break;
		case 139:
			return "Horlais Peak";
			break;
		case 140:
			return "Ghelsba Outpost";
			break;
		case 141:
			return "Fort Ghelsba";
			break;
		case 142:
			return "Yughott Grotto";
			break;
		case 143:
			return "Palborough Mines";
			break;
		case 144:
			return "Waughroon Shrine";
			break;
		case 145:
			return "Giddeus";
			break;
		case 146:
			return "Balga's Dais";
			break;
		case 147:
			return "Beadeaux";
			break;
		case 148:
			return "Qulun Dome";
			break;
		case 149:
			return "Davoi";
			break;
		case 150:
			return "Monastic Cavern";
			break;
		case 151:
			return "Castle Oztroja";
			break;
		case 152:
			return "Altar Room";
			break;
		case 153:
			return "The Boyahda Tree";
			break;
		case 154:
			return "Dragons Aery";
			break;
		case 157:
			return "Middle Delkfutt's Tower";
			break;
		case 158:
			return "Upper Delkfutt's Tower";
			break;
		case 159:
			return "Temple of Uggalepih";
			break;
		case 160:
			return "Den of Rancor";
			break;
		case 161:
			return "Castle Zvahl Baileys";
			break;
		case 162:
			return "Castle Zvahl Keep";
			break;
		case 163:
			return "Sacrificial Chamber";
			break;
		case 165:
			return "Throne Room";
			break;
		case 166:
			return "Ranguemont Pass";
			break;
		case 167:
			return "Bostaunieux Oubliette";
			break;
		case 168:
			return "Chamber of Oracles";
			break;
		case 169:
			return "Toraimarai Canal";
			break;
		case 170:
			return "Full Moon Fountain";
			break;
		case 172:
			return "Zeruhn Mines";
			break;
		case 173:
			return "Korroloka Tunnel";
			break;
		case 174:
			return "Kuftal Tunnel";
			break;
		case 176:
			return "Sea Serpent Grotto";
			break;
		case 177:
			return "Ve'Lugannon Palace";
			break;
		case 178:
			return "The Shrine of Ru'Avitau";
			break;
		case 179:
			return "Stellar Fulcrum";
			break;
		case 180:
			return "La'Loff Amphitheater";
			break;
		case 181:
			return "The Celestial Nexus";
			break;
		case 182:
			return "Walk of Echoes";
			break;
		case 183:
			return "Maquette Abdhaljs Legion";
			break;
		case 184:
			return "Lower Delkfutt's Tower";
			break;
		case 185:
			return "Dynamis San d'Oria";
			break;
		case 186:
			return "Dynamis Bastok";
			break;
		case 187:
			return "Dynamis Windurst";
			break;
		case 188:
			return "Dynamis Jeuno";
			break;
		case 189:
			return "Residential Area";
			break;
		case 190:
			return "King Ranperre's Tomb";
			break;
		case 191:
			return "Dangruf Wadi";
			break;
		case 192:
			return "Inner Horutoto Ruins";
			break;
		case 193:
			return "Ordelle's Caves";
			break;
		case 194:
			return "Outer Horutoto Ruins";
			break;
		case 195:
			return "The Eldieme Necropolis";
			break;
		case 196:
			return "Gusgen Mines";
			break;
		case 197:
			return "Crawlers' Nest";
			break;
		case 198:
			return "Maze of Shakhrami";
			break;
		case 199:
			return "Residential_Area";
			break;
		case 200:
			return "Garlaige Citadel";
			break;
		case 201:
			return "Cloister of Gales";
			break;
		case 202:
			return "Cloister of Storms";
			break;
		case 203:
			return "Cloister of Frost";
			break;
		case 204:
			return "Fei'Yin";
			break;
		case 205:
			return "Ifrit's Cauldron";
			break;
		case 206:
			return "Qu'Bia Arena";
			break;
		case 207:
			return "Cloister of Flames";
			break;
		case 208:
			return "Quicksand Caves";
			break;
		case 209:
			return "Cloister of Tremors";
			break;
		case 210:
			return "GM Home";
			break;
		case 211:
			return "Cloister of Tides";
			break;
		case 212:
			return "Gustav Tunnel";
			break;
		case 213:
			return "Labyrinth of Onzozo";
			break;
		case 214:
			return "Residential Area";
			break;
		case 219:
			return "Residential Area";
			break;
		case 220:
			return "Ship bound for Selbina";
			break;
		case 221:
			return "Ship bound for Mhaura";
			break;
		case 222:
			return "Provenance";
			break;
		case 223:
			return "San d'Oria/Jeuno Airship";
			break;
		case 224:
			return "Bastok/Jeuno Airship";
			break;
		case 225:
			return "Windurst/Jeuno Airship";
			break;
		case 226:
			return "Kazham/Jeuno Airship";
			break;
		case 227:
			return "Ship bound for Selbina";
			break;
		case 228:
			return "Ship bound for Mhaura";
			break;
		case 230:
			return "Southern San d'Oria";
			break;
		case 231:
			return "Northern San d'Oria";
			break;
		case 232:
			return "Port San d'Oria";
			break;
		case 233:
			return "Chateau d'Oraguille";
			break;
		case 234:
			return "Bastok Mines";
			break;
		case 235:
			return "Bastok Markets";
			break;
		case 236:
			return "Port Bastok";
			break;
		case 237:
			return "Metalworks";
			break;
		case 238:
			return "Windurst Waters";
			break;
		case 239:
			return "Windurst Walls";
			break;
		case 240:
			return "Port Windurst";
			break;
		case 241:
			return "Windurst Woods";
			break;
		case 242:
			return "Heavens Tower";
			break;
		case 243:
			return "Ru'Lude Gardens";
			break;
		case 244:
			return "Upper Jeuno";
			break;
		case 245:
			return "Lower Jeuno";
			break;
		case 246:
			return "Port Jeuno";
			break;
		case 247:
			return "Rabao";
			break;
		case 248:
			return "Selbina";
			break;
		case 249:
			return "Mhaura";
			break;
		case 250:
			return "Kazham";
			break;
		case 251:
			return "Hall of the Gods";
			break;
		case 252:
			return "Norg";
			break;
		case 280:
			return "Mog Garden";
			break;
		case 294:
			return "Dynamis San d'Oria";
			break;
		case 295:
			return "Dynamis Bastok";
			break;
		case 296:
			return "Dynamis Windurst";
			break;
		case 297:
			return "Dynamis Jeuno";
			break;
		}
	}

	if (sSize == 2) // compact
	{
		switch (zoneid)
		{
		case 0:
			return "ERROR";
			break;
		case 1:
			return "Phanauet Channel";
			break;
		case 2:
			return "Carpenters' Landing";
			break;
		case 3:
			return "Manaclipper";
			break;
		case 4:
			return "Bibiki Bay";
			break;
		case 5:
			return "Uleguerand Range";
			break;
		case 6:
			return "Bearclaw Pinnacle";
			break;
		case 7:
			return "Attohwa Chasm";
			break;
		case 8:
			return "Boneyard Gully";
			break;
		case 9:
			return "Pso'Xja";
			break;
		case 10:
			return "The Shrouded Maw";
			break;
		case 11:
			return "Oldton Movalpolos";
			break;
		case 12:
			return "Newton Movalpolos";
			break;
		case 13:
			return "Mine Shaft 2716";
			break;
		case 14:
			return "Hall of Transference";
			break;
		case 16:
			return "Promyvion Holla";
			break;
		case 17:
			return "Spire of Holla";
			break;
		case 18:
			return "Promyvion Dem";
			break;
		case 19:
			return "Spire of Dem";
			break;
		case 20:
			return "Promyvion Mea";
			break;
		case 21:
			return "Spire of Mea";
			break;
		case 22:
			return "Promyvion Vahzl";
			break;
		case 23:
			return "Spire of Vahzl";
			break;
		case 24:
			return "Lufaise Meadows";
			break;
		case 25:
			return "Misareaux Coast";
			break;
		case 26:
			return "Tavnazian Safehold";
			break;
		case 27:
			return "Phomiuna Aqueducts";
			break;
		case 28:
			return "Sacrarium";
			break;
		case 29:
			return "Riverne Site B01";
			break;
		case 30:
			return "Riverne Site A01";
			break;
		case 31:
			return "Monarch Linn";
			break;
		case 32:
			return "Sealion's Den";
			break;
		case 33:
			return "Al'Taieu";
			break;
		case 34:
			return "G. Palace of Hu'Xzoi";
			break;
		case 35:
			return "Garden of Ru'Hmet";
			break;
		case 36:
			return "Empyreal Paradox";
			break;
		case 37:
			return "Temenos";
			break;
		case 38:
			return "Apollyon";
			break;
		case 39:
			return "Dynamis Valkurm";
			break;
		case 40:
			return "Dynamis Buburimu";
			break;
		case 41:
			return "Dynamis Qufim";
			break;
		case 42:
			return "Dynamis Tavnazia";
			break;
		case 43:
			return "Diorama Abd. Ghelsba";
			break;
		case 44:
			return "Abd. Isle Purgonorgo";
			break;
		case 46:
			return "Sea Route to Al Zahbi";
			break;
		case 47:
			return "Sea route to Mhaura";
			break;
		case 48:
			return "Al Zahbi";
			break;
		case 50:
			return "Aht Urhgan Whitegate";
			break;
		case 51:
			return "Wajaom Woodlands";
			break;
		case 52:
			return "Bhaflau Thickets";
			break;
		case 53:
			return "Nashmau";
			break;
		case 54:
			return "Arrapago Reef";
			break;
		case 55:
			return "Ilrusi Atoll";
			break;
		case 56:
			return "Periqia";
			break;
		case 57:
			return "Talacca Cove";
			break;
		case 58:
			return "S. Sea R. to Nashmau";
			break;
		case 59:
			return "S. Sea R. to Al Zahbi";
			break;
		case 60:
			return "The Ashu Talif";
			break;
		case 61:
			return "Mount Zhayolm";
			break;
		case 62:
			return "Halvung";
			break;
		case 63:
			return "Lebros Cavern";
			break;
		case 64:
			return "Navukgo Exec. Chamber";
			break;
		case 65:
			return "Mamook";
			break;
		case 66:
			return "Mamool Ja Tn. Grounds";
			break;
		case 67:
			return "Jade Sepulcher";
			break;
		case 68:
			return "Aydeewa Subterrane";
			break;
		case 69:
			return "Leujaoam Sanctum";
			break;
		case 70:
			return "Chocobo Circuit";
			break;
		case 71:
			return "The Colosseum";
			break;
		case 72:
			return "Alz. Undersea Ruins";
			break;
		case 73:
			return "Zhayolm Remnants";
			break;
		case 74:
			return "Arrapago Remnants";
			break;
		case 75:
			return "Bhaflau Remnants";
			break;
		case 76:
			return "Silver Sea Remnants";
			break;
		case 77:
			return "Nyzul Isle";
			break;
		case 78:
			return "Hazhalm Tst. Grounds";
			break;
		case 79:
			return "Caedarva_Mire";
			break;
		case 82:
			return "Jugner Forest [S]";
			break;
		case 100:
			return "West Ronfaure";
			break;
		case 101:
			return "East Ronfaure";
			break;
		case 102:
			return "La Theine Plateau";
			break;
		case 103:
			return "Valkurm Dunes";
			break;
		case 104:
			return "Jugner Forest";
			break;
		case 105:
			return "Batallia Downs";
			break;
		case 106:
			return "North Gustaberg";
			break;
		case 107:
			return "South Gustaberg";
			break;
		case 108:
			return "Konschtat Highlands";
			break;
		case 109:
			return "Pashhow Marshlands";
			break;
		case 110:
			return "Rolanberry Fields";
			break;
		case 111:
			return "Beaucedine Glacier";
			break;
		case 112:
			return "Xarcabard";
			break;
		case 113:
			return "Cape Teriggan";
			break;
		case 114:
			return "Eastern Altepa Desert";
			break;
		case 115:
			return "West Sarutabaruta";
			break;
		case 116:
			return "East Sarutabaruta";
			break;
		case 117:
			return "Tahrongi Canyon";
			break;
		case 118:
			return "Buburimu Peninsula";
			break;
		case 119:
			return "Meriphataud Mountains";
			break;
		case 120:
			return "Sauromugue Champaign";
			break;
		case 121:
			return "Sanctuary of Zi'Tah";
			break;
		case 122:
			return "Ro'Maeve";
			break;
		case 123:
			return "Yuhtunga Jungle";
			break;
		case 124:
			return "Yhoator Jungle";
			break;
		case 125:
			return "Western Altepa Desert";
			break;
		case 126:
			return "Qufim Island";
			break;
		case 127:
			return "Behemoths Dominion";
			break;
		case 128:
			return "Valley of Sorrows";
			break;
		case 129:
			return "Ghoyus Reverie";
			break;
		case 130:
			return "Ru'Aun Gardens";
			break;
		case 131:
			return "Mordion Gaol";
			break;
		case 132:
			return "Abyssea La Theine";
			break;
		case 134:
			return "Dynamis Beaucedine";
			break;
		case 135:
			return "Dynamis Xarcabard";
			break;
		case 139:
			return "Horlais Peak";
			break;
		case 140:
			return "Ghelsba Outpost";
			break;
		case 141:
			return "Fort Ghelsba";
			break;
		case 142:
			return "Yughott Grotto";
			break;
		case 143:
			return "Palborough Mines";
			break;
		case 144:
			return "Waughroon Shrine";
			break;
		case 145:
			return "Giddeus";
			break;
		case 146:
			return "Balga's Dais";
			break;
		case 147:
			return "Beadeaux";
			break;
		case 148:
			return "Qulun Dome";
			break;
		case 149:
			return "Davoi";
			break;
		case 150:
			return "Monastic Cavern";
			break;
		case 151:
			return "Castle Oztroja";
			break;
		case 152:
			return "Altar Room";
			break;
		case 153:
			return "The Boyahda Tree";
			break;
		case 154:
			return "Dragons Aery";
			break;
		case 157:
			return "Mid. Delkfutt's Tower";
			break;
		case 158:
			return "Up. Delkfutt's Tower";
			break;
		case 159:
			return "Temple of Uggalepih";
			break;
		case 160:
			return "Den of Rancor";
			break;
		case 161:
			return "Castle Zvahl Baileys";
			break;
		case 162:
			return "Castle Zvahl Keep";
			break;
		case 163:
			return "Sacrificial Chamber";
			break;
		case 165:
			return "Throne Room";
			break;
		case 166:
			return "Ranguemont Pass";
			break;
		case 167:
			return "Bostaunieux Oubliette";
			break;
		case 168:
			return "Chamber of Oracles";
			break;
		case 169:
			return "Toraimarai Canal";
			break;
		case 170:
			return "Full Moon Fountain";
			break;
		case 172:
			return "Zeruhn Mines";
			break;
		case 173:
			return "Korroloka Tunnel";
			break;
		case 174:
			return "Kuftal Tunnel";
			break;
		case 176:
			return "Sea Serpent Grotto";
			break;
		case 177:
			return "Ve'Lugannon Palace";
			break;
		case 178:
			return "Shrine of Ru'Avitau";
			break;
		case 179:
			return "Stellar Fulcrum";
			break;
		case 180:
			return "La'Loff Amphitheater";
			break;
		case 181:
			return "The Celestial Nexus";
			break;
		case 182:
			return "Walk of Echoes";
			break;
		case 183:
			return "Maquette Abd. Legion";
			break;
		case 184:
			return "Low. Delkfutt's Tower";
			break;
		case 185:
			return "Dynamis San d'Oria";
			break;
		case 186:
			return "Dynamis Bastok";
			break;
		case 187:
			return "Dynamis Windurst";
			break;
		case 188:
			return "Dynamis Jeuno";
			break;
		case 189:
			return "Residential Area";
			break;
		case 190:
			return "King Ranperre's Tomb";
			break;
		case 191:
			return "Dangruf Wadi";
			break;
		case 192:
			return "Inner Horutoto Ruins";
			break;
		case 193:
			return "Ordelle's Caves";
			break;
		case 194:
			return "Outer Horutoto Ruins";
			break;
		case 195:
			return "Eldieme Necropolis";
			break;
		case 196:
			return "Gusgen Mines";
			break;
		case 197:
			return "Crawlers' Nest";
			break;
		case 198:
			return "Maze of Shakhrami";
			break;
		case 199:
			return "Residential_Area";
			break;
		case 200:
			return "Garlaige Citadel";
			break;
		case 201:
			return "Cloister of Gales";
			break;
		case 202:
			return "Cloister of Storms";
			break;
		case 203:
			return "Cloister of Frost";
			break;
		case 204:
			return "Fei'Yin";
			break;
		case 205:
			return "Ifrit's Cauldron";
			break;
		case 206:
			return "Qu'Bia Arena";
			break;
		case 207:
			return "Cloister of Flames";
			break;
		case 208:
			return "Quicksand Caves";
			break;
		case 209:
			return "Cloister of Tremors";
			break;
		case 210:
			return "GM Home";
			break;
		case 211:
			return "Cloister of Tides";
			break;
		case 212:
			return "Gustav Tunnel";
			break;
		case 213:
			return "Labyrinth of Onzozo";
			break;
		case 214:
			return "Residential Area";
			break;
		case 219:
			return "Residential Area";
			break;
		case 220:
			return "Ship bd. for Selbina";
			break;
		case 221:
			return "Ship bd. for Mhaura";
			break;
		case 222:
			return "Provenance";
			break;
		case 223:
			return "San./Jeuno Airship";
			break;
		case 224:
			return "Bastok/Jeuno Airship";
			break;
		case 225:
			return "Wind./Jeuno Airship";
			break;
		case 226:
			return "Kazham/Jeuno Airship";
			break;
		case 227:
			return "Ship bd. for Selbina";
			break;
		case 228:
			return "Ship bd. for Mhaura";
			break;
		case 230:
			return "Southern San d'Oria";
			break;
		case 231:
			return "Northern San d'Oria";
			break;
		case 232:
			return "Port San d'Oria";
			break;
		case 233:
			return "Chateau d'Oraguille";
			break;
		case 234:
			return "Bastok Mines";
			break;
		case 235:
			return "Bastok Markets";
			break;
		case 236:
			return "Port Bastok";
			break;
		case 237:
			return "Metalworks";
			break;
		case 238:
			return "Windurst Waters";
			break;
		case 239:
			return "Windurst Walls";
			break;
		case 240:
			return "Port Windurst";
			break;
		case 241:
			return "Windurst Woods";
			break;
		case 242:
			return "Heavens Tower";
			break;
		case 243:
			return "Ru'Lude Gardens";
			break;
		case 244:
			return "Upper Jeuno";
			break;
		case 245:
			return "Lower Jeuno";
			break;
		case 246:
			return "Port Jeuno";
			break;
		case 247:
			return "Rabao";
			break;
		case 248:
			return "Selbina";
			break;
		case 249:
			return "Mhaura";
			break;
		case 250:
			return "Kazham";
			break;
		case 251:
			return "Hall of the Gods";
			break;
		case 252:
			return "Norg";
			break;
		case 280:
			return "Mog Garden";
			break;
		case 294:
			return "Dynamis San d'Oria";
			break;
		case 295:
			return "Dynamis Bastok";
			break;
		case 296:
			return "Dynamis Windurst";
			break;
		case 297:
			return "Dynamis Jeuno";
			break;
		}
	}

	return "ERROR";

}