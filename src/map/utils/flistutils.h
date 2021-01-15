/*
===========================================================================

This file is part of Tonberry source code.

===========================================================================
*/



#ifndef _FLISTUTILS_H
#define _FLISTUTILS_H

#define FLNULL "FLnull"

#include "../utils/zoneutils.h"

#include "../../common/kernel.h"
#include "../../common/showmsg.h"
#include "../../common/timer.h"
#include "../../common/utils.h"

#include "../map.h"
//#include "../message.h"
#include "../timetriggers.h"

#include "../entities/charentity.h"
#include "../packets/char.h"
#include "../packets/char_jobs.h"
#include "../packets/char_job_extra.h"
#include "../packets/chat_message.h"
#include "../packets/message_basic.h"
#include "../packets/message_name.h"
#include "../packets/message_special.h"
#include "../packets/message_standard.h"
#include "../packets/message_system.h"
#include "../packets/message_text.h"
#include "../packets/server_ip.h"

#include "../vana_time.h"

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>
//#include <ctime>

#include <algorithm>

bool FLinitialize(CCharEntity *PChar);
int32 FLgetSetting(CCharEntity *PChar, uint8 setting); // 1:callingchar,2:visible,3:notifs,4:channel,5:size,6:lastcall,7:lastonline
int32 FLgetSettingByID(uint32 id, uint8 setting);
int32 FLnotify(CCharEntity *PChar, bool logoff, bool force);
int32 FLnotifyCrossCluster(CCharEntity* PChar, bool logoff, std::string listedcharname, uint32 channel);
int32 FLsetNote(CCharEntity *PChar, uint8 sChannel, std::string listedcharname, std::string note);
int32 FLsetNotifs(CCharEntity *PChar, uint8 sChannel, uint8 notifs);
int32 FLsetSize(CCharEntity *PChar, uint8 sChannel, uint8 size);
int32 FLsetChannel(CCharEntity *PChar, uint8 channel);
int32 FLhide(CCharEntity *PChar, uint8 sChannel, bool hide, bool silent);
int32 FLremove(CCharEntity *PChar, std::string removecharname, uint8 sChannel);
int32 FLadd(CCharEntity *PChar, std::string addcharname, uint8 sChannel, uint8 sVisible);
int32 FLprintList(CCharEntity *PChar, uint8 sChannel, uint8 sSize);
std::string FLgetRace(uint8 raceid);
void FLpopulate(CCharEntity *PChar, uint8 sChannel, uint8 sSize);
uint8 FLnumOnline(CCharEntity *PChar);
uint8 FLnumTotal(CCharEntity *PChar);
std::string FLgetLastOnline(uint32 time);
std::string FLgetJob(uint8 jobid);
std::string FLgetZone(uint16 zoneid, uint8 sSize);

#endif




