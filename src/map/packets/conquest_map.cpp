/*
===========================================================================

  Copyright (c) 2010-2015 Darkstar Dev Teams

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see http://www.gnu.org/licenses/

===========================================================================
*/

#include "../../common/socket.h"

#include <string.h>

#include "../entities/charentity.h"
#include "../conquest_system.h"

#include "../utils/charutils.h"

#include "conquest_map.h"

time_t CConquestPacket::m_CMCacheExpires = 0;
uint8 CConquestPacket::m_SadoriaRegions = 0;
uint8 CConquestPacket::m_BastokRegions = 0;
uint8 CConquestPacket::m_WindurstRegions = 0;
uint8 CConquestPacket::m_SadoriaPrev = 0;
uint8 CConquestPacket::m_BastokPrev = 0;
uint8 CConquestPacket::m_WindurstPrev = 0;
uint8 CConquestPacket::m_Balance = 0;
uint8 CConquestPacket::m_Alliance = 0;
uint8 CConquestPacket::m_NextTally = 0;
uint8 CConquestPacket::m_IsCalculating = 0;
std::vector<std::vector<int64>> CConquestPacket::m_CMCachedData;

CConquestPacket::CConquestPacket(CCharEntity * PChar)
{
	this->type = 0x5E;
	this->size = 0x5A;

    if (time(NULL) > m_CMCacheExpires) {
        const char* Query = "SELECT region_id, region_control, region_control_prev, \
                         sandoria_influence, bastok_influence, windurst_influence, \
                         beastmen_influence FROM conquest_system;";

        int32 ret = Sql_Query(SqlHandle, Query);

        m_SadoriaRegions = 0;
        m_BastokRegions = 0;
        m_WindurstRegions = 0;
        m_SadoriaPrev = 0;
        m_BastokPrev = 0;
        m_WindurstPrev = 0;
        std::vector<int64> regionInfo;

        if (ret != SQL_ERROR && Sql_NumRows(SqlHandle) != 0)
        {
            while (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                regionInfo.clear();

                int regionid = Sql_GetIntData(SqlHandle, 0);
                regionInfo.push_back(regionid); // [0]
                int region_control = Sql_GetIntData(SqlHandle, 1);
                regionInfo.push_back(region_control); // [1]
                int region_control_prev = Sql_GetIntData(SqlHandle, 2);
                regionInfo.push_back(region_control_prev); // [2]

                if (region_control == 0)
                    m_SadoriaRegions++;
                else if (region_control == 1)
                    m_BastokRegions++;
                else if (region_control == 2)
                    m_WindurstRegions++;

                if (region_control_prev == 0)
                    m_SadoriaPrev++;
                else if (region_control_prev == 1)
                    m_BastokPrev++;
                else if (region_control_prev == 2)
                    m_WindurstPrev++;

                int32 SandoriaInf = Sql_GetIntData(SqlHandle, 3);
                regionInfo.push_back(SandoriaInf); // [3]
                int32 BastokInf = Sql_GetIntData(SqlHandle, 4);
                regionInfo.push_back(BastokInf); // [4]
                int32 WindurstInf = Sql_GetIntData(SqlHandle, 5);
                regionInfo.push_back(WindurstInf); // [5]
                int32 BeastmenInf = Sql_GetIntData(SqlHandle, 6);
                regionInfo.push_back(BeastmenInf); // [6]
                int32 all_inf_rank = conquest::GetInfluenceRanking(SandoriaInf, BastokInf, WindurstInf, BeastmenInf);
                regionInfo.push_back(all_inf_rank); // [7]
                int32 nation_inf_rank = conquest::GetInfluenceRanking(SandoriaInf, BastokInf, WindurstInf);
                regionInfo.push_back(nation_inf_rank); // [8]
                int32 all_inf_graph = conquest::GetInfluenceGraphics(SandoriaInf, BastokInf, WindurstInf, BeastmenInf);
                regionInfo.push_back(all_inf_graph); // [9]
                uint8 regcon_off1 = region_control+1;
                regionInfo.push_back(regcon_off1); // [10]

                int64 totalInf = SandoriaInf + BastokInf + WindurstInf;
                regionInfo.push_back(totalInf); // [11]
                int64 totalBeastmenInf = totalInf + BeastmenInf;
                regionInfo.push_back(totalBeastmenInf); // [12]

                m_CMCachedData.push_back(regionInfo);
            }
        }

        m_Balance = conquest::GetBalance(m_SadoriaRegions, m_BastokRegions, m_WindurstRegions, m_SadoriaPrev, m_BastokPrev, m_WindurstPrev);
        m_Alliance = conquest::GetAlliance(m_SadoriaRegions, m_BastokRegions, m_WindurstRegions, m_SadoriaPrev, m_BastokPrev, m_WindurstPrev);

        m_NextTally = conquest::GetNexTally();
        m_IsCalculating = conquest::IsCalculatingTally() ? 1 : 0;

        m_CMCacheExpires = time(NULL) + 60;
    }

    for (int i = 0; i < m_CMCachedData.size(); i++)
    {
        std::vector<int64>& regionInfo = m_CMCachedData[i];
        int regionid = regionInfo[0];
        int region_control = regionInfo[1];
        int region_control_prev = regionInfo[2];

        int32 san_inf = regionInfo[3];
        int32 bas_inf = regionInfo[4];
        int32 win_inf = regionInfo[5];
        int32 bst_inf = regionInfo[6];
        ref<uint8>(0x1A + regionid * 4) = regionInfo[7];
        ref<uint8>(0x1B + regionid * 4) = regionInfo[8];
        ref<uint8>(0x1C + regionid * 4) = regionInfo[9];
        ref<uint8>(0x1D + regionid * 4) = regionInfo[10];

        int64 total = regionInfo[11];
        int64 totalBeastmen = regionInfo[12];

        if (PChar->loc.zone->GetRegionID() == regionid)
        {
            ref<uint8>(0x86) = (uint8)((san_inf * 100) / (totalBeastmen == 0 ? 1 : totalBeastmen));
            ref<uint8>(0x87) = (uint8)((bas_inf * 100) / (totalBeastmen == 0 ? 1 : totalBeastmen));
            ref<uint8>(0x88) = (uint8)((win_inf * 100) / (totalBeastmen == 0 ? 1 : totalBeastmen));
            ref<uint8>(0x89) = (uint8)((san_inf * 100) / (total == 0 ? 1 : total));
            ref<uint8>(0x8A) = (uint8)((bas_inf * 100) / (total == 0 ? 1 : total));
            ref<uint8>(0x8B) = (uint8)((win_inf * 100) / (total == 0 ? 1 : total));
            ref<uint8>(0x94) = (uint8)((bst_inf * 100) / (totalBeastmen == 0 ? 1 : totalBeastmen));
        }
    }

    ref<uint8>(0x04) = m_Balance;
    ref<uint8>(0x05) = m_Alliance;

    ref<uint8>(0x8C) = m_NextTally;
    ref<uint32>(0x90) = charutils::GetPoints(PChar, charutils::GetConquestPointsName(PChar).c_str());
    ref<uint8>(0x98) = m_IsCalculating;
    ref<uint8>(0x9C) = 0x01;

	//uint8 packet[] =
    //{
	//    0x80, 0x78, 0x52, 0x03, 0x1a, 0x46, 0x04, 0x00, 0x42, 0x46, 0x04, 0x00, 0x65, 0x3d, 0x04, 0x00
    //};
	//memcpy(data+(0xA0), &packet, 16);

	ref<uint8>(0xA0) = 16; // Situation: mamool ja niveau -> (1) 16 (2) 32 (3) 48 (4) 64 (5) 80 (6) 96 (7) 112 (8) 128
	ref<uint8>(0xA1) = 17; // Situation: mercenaire trolls niveau -> 1~12 la suite avec un autre
	ref<uint8>(0xA2) = 0; // Situation: mamool ja status du siege -> (0) entrainement > (1) en marche > (2) attaque > (3) retraite | (4) defense (5) preparation
	ref<uint8>(0xA3) = 4; // Situation: undead status du siege ? (3) defense (4) entrainement (5) defense

	ref<uint8>(0xA4) = 0; // mamool ja: (13) preparation (26) attaque (32) entrainement
	ref<uint8>(0xA5) = 0; // mamool ja: forces ennemies (1=32)
	ref<uint8>(0xA6) = 0; // mamool ja: miroir archaique (1=2)
	ref<uint8>(0xA7) = 0;

	ref<uint8>(0xA8) = 0; // trolls: forces ennemies (66=8)
	ref<uint8>(0xA9) = 0; // trolls: (70) attaque
	ref<uint8>(0xAA) = 0; // trolls: miroir archaique (4=8)
	ref<uint8>(0xAB) = 0;
	ref<uint8>(0xAC) = 0; // undead: forces ennemies (101=12)
	ref<uint8>(0xAD) = 0; // undead: (61) preparation
	ref<uint8>(0xAE) = 0; // undead: miroir archaique (4=8)
	ref<uint8>(0xAF) = 0;

	ref<uint32>(0xB0) = charutils::GetPoints(PChar, "imperial_standing");
}

void CConquestPacket::CMFlushCache()
{
    m_CMCacheExpires = 0;
}