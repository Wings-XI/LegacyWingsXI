/*
===========================================================================

  Copyright (c) 2021 Wings Open Source Project

  Use of this file is under GPLv3, see LICENSE file.

  Author: Velyn

===========================================================================
*/

#include <string.h>

#include "chatfilter.h"
#include "../../common/mmo.h"

#include "../entities/charentity.h"
#include "../packets/caught_fish.h"
#include "../packets/chat_message.h"

// Which messages should NOT bypass the filters for senders?
// e.g. Users can filter out their own jobemotes, but
// should still be able to see their own fishing results.
static const uint64 SenderFilterMask = ~(CHATFILTER_SYNTHESIS|CHATFILTER_LOT_RESULTS);

// Which messages should NOT bypass the filters for GMs?
static const uint64 GMFilterMask = 0;

static const uint64 DefaultFilterMask = ~0;

CChatFilter::CChatFilter(const CBaseEntity* const _sender, CBasicPacket* packet)
    : sender(_sender),
    filterMask(0)
{
    if (packet == NULL)
    {
        return;
    }

    // CChatMessagePacket
    bool isChatMessagePacket = packet->id() == 0x17;
    bool isSay = isChatMessagePacket && packet->ref<uint8>(0x04) == MESSAGE_SAY;
    bool isShout = isChatMessagePacket && packet->ref<uint8>(0x04) == MESSAGE_SHOUT;
    bool isEmote = isChatMessagePacket && packet->ref<uint8>(0x04) == MESSAGE_EMOTION;

    // bool isYell = isChatMessagePacket && packet->ref<uint8>(0x04) == MESSAGE_YELL;
    // bool isTellSpam = false;
    // bool isYellSpam = false;
    //
    // // todo - yells don't use CChatFilter (yet?); sender info isn't available after the broadcast.
    // // spam tests should happen in SmallPacket0x0B5, before any fan-out.
    // if (isShout || isYell)
    // {
    // }

    // CCharEmotionPacket
    bool isEmotePacket = packet->id() == 0x5A;
    bool isJobEmote = isEmotePacket && (packet->ref<uint8>(0x10) >= 74);

    // CSynthResultMessagePacket
    bool isSynth = packet->id() == 0x70;

    // CMessageNamePacket
    bool isMessageNamePacket = packet->id() == 0x27;

    // CCaughtFishPacket (does not inherit from CMessageNamePacket but shares same id)
    bool isFish = isMessageNamePacket && typeid(*packet) == typeid(CCaughtFishPacket);

    if (isSay)
    {
        filterMask |= CHATFILTER_SAY;
    }

    if (isShout)
    {
        filterMask |= CHATFILTER_SHOUT;
    }

    if (isEmote)
    {
        filterMask |= CHATFILTER_EMOTES;
    }

    // if (isYell)
    // {
    //     filterMask |= CHATFILTER_YELL;
    // }
    //
    // if (isTellSpam)
    // {
    //     filterMask |= CHATFILTER_TELL_SPAM;
    // }
    //
    // if (isYellSpam)
    // {
    //     filterMask |= CHATFILTER_YELL_SPAM;
    // }

    if (isJobEmote)
    {
        filterMask |= CHATFILTER_JOBEMOTE;
    }

    if (isSynth || isFish)
    {
        filterMask |= CHATFILTER_SYNTHESIS;
    }
}

bool CChatFilter::isFiltered(const CCharEntity* const entity) const
{
    const CCharEntity* const cSender = ((sender != nullptr) && (sender->objtype == TYPE_PC)) ? dynamic_cast<const CCharEntity*>(sender) : nullptr;
    uint64 senderMask = ((cSender != nullptr) && (cSender->id == entity->id)) ? SenderFilterMask : DefaultFilterMask;
    uint64 gmMask = ((cSender != nullptr) && (cSender->nameflags.flags & FLAG_GM)) ? GMFilterMask : DefaultFilterMask;

    return (filterMask & senderMask & gmMask & entity->chatFilterFlags) != 0;
}
