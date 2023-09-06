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

#include <string.h>

#include "map.h"
#include "merit.h"
#include "entities/charentity.h"
#include "utils/charutils.h"
#include "packets/char_spells.h"

/************************************************************************
*                                                                       *
*  Две версии значений - до abyssea и после                             *
*                                                                       *
************************************************************************/

// массив больше на одно значение, заполняемое нулем

static uint8 upgrade[10][16] =
{
    {1,2,3,4,5,5,5,5,5,7,7,7,9,9,9},             // HP-MP
    {3,6,9,9,9,12,12,12,12,15,15,15,15,19,18},   // Attributes
    {1,2,3,3,3,3,3,3},                           // Combat Skills
    {1,2,3,3,3,3,3,3},                           // Defensive Skills
    {1,2,3,3,3,3,3,3},                           // Magic Skills
    {1,2,3,4,5},                                 // Others
    {1,2,3,4,5},                                 // Job Group 1
    {3,4,5,5,5},                                 // Job Group 2
    {20,22,24,27,30},                            // Weapon Skills
    {1,3,5,7,9,12,15,18,21,24,27,30,33,36,39}    // Max merits
};
#define MAX_LIMIT_POINTS  10000         // количество опыта для получения одного merit

// TODO: скорее всего придется все это перенести в базу

/************************************************************************
*                                                                       *
*  Ограничение количества усилений metir                                *
*                                                                       *
************************************************************************/

static uint8 cap[100] =
{
    0,0,0,0,0,0,0,0,0,0,    // 0-9   0
    1,1,1,1,1,1,1,1,1,1,    // 10-19 1
    2,2,2,2,2,2,2,2,2,2,    // 20-29 2
    3,3,3,3,3,3,3,3,3,3,    // 30-39 3
    4,4,4,4,4,4,4,4,4,4,    // 40-49 4
    5,5,5,5,5,              // 50-54 5
    6,6,6,6,6,              // 55-59 6
    7,7,7,7,7,              // 60-64 7
    8,8,8,8,8,              // 65-69 8
    9,9,9,9,9,              // 70-74 9
    10,10,10,10,10,         // 75-79 10
    15,15,15,15,15,15,15,15,15,15,    // 80-89 15
    15,15,15,15,15,15,15,15,15,15,    // 90-99 15
};

/************************************************************************
*                                                                       *
*  Количество элементов в каждой из категорий                           *
*                                                                       *
************************************************************************/

struct MeritCategoryInfo_t
{
    int8 MeritsInCat;  // количество элементов в группе
    uint8 MaxPoints;    // максимальное количество points, которые можно вложить в группу
    uint8 UpgradeID;    // индекс группы в массиве upgrade
};

static const MeritCategoryInfo_t meritCatInfo[] =
{
    {3,45,0},  //MCATEGORY_HP_MP
    {7,105,1},  //MCATEGORY_ATTRIBUTES
    {19,152,2}, //MCATEGORY_COMBAT
    {14,112,4}, //MCATEGORY_MAGIC
    {5,10,5},  //MCATEGORY_OTHERS

    {5,10,6},  //MCATEGORY_WAR_1
    {5,10,6},  //MCATEGORY_MNK_1
    {5,10,6},  //MCATEGORY_WHM_1
    {7,10,6},  //MCATEGORY_BLM_1
    {7,10,6},  //MCATEGORY_RDM_1
    {5,10,6},  //MCATEGORY_THF_1
    {5,10,6},  //MCATEGORY_PLD_1
    {5,10,6},  //MCATEGORY_DRK_1
    {5,10,6},  //MCATEGORY_BST_1
    {5,10,6},  //MCATEGORY_BRD_1
    {5,10,6},  //MCATEGORY_RNG_1
    {5,10,6},  //MCATEGORY_SAM_1
    {7,10,6},  //MCATEGORY_NIN_1
    {5,10,6},  //MCATEGORY_DRG_1
    {5,10,6},  //MCATEGORY_SMN_1
    {5,10,6},  //MCATEGORY_BLU_1
    {5,10,6},  //MCATEGORY_COR_1
    {5,10,6},  //MCATEGORY_PUP_1
    {4,10,6},  //MCATEGORY_DNC_1
    {4,10,6},  //MCATEGORY_SCH_1

    {14,15,8}, //MCATEGORY_WS

	{0,0,8},   //MCATEGORY_UNK_0	26
    {0,0,8},   //MCATEGORY_UNK_1
    {0,0,8},   //MCATEGORY_UNK_2
    {0,0,8},   //MCATEGORY_UNK_3
    {0,0,8},   //MCATEGORY_UNK_4	30

    {4,10,7},  //MCATEGORY_WAR_2
    {4,10,7},  //MCATEGORY_MNK_2
    {6,10,7},  //MCATEGORY_WHM_2
    {12,10,7},  //MCATEGORY_BLM_2
    {12,10,7},  //MCATEGORY_RDM_2
    {4,10,7},  //MCATEGORY_THF_2
    {4,10,7},  //MCATEGORY_PLD_2
    {4,10,7},  //MCATEGORY_DRK_2
    {4,10,7},  //MCATEGORY_BST_2
    {6,10,7},  //MCATEGORY_BRD_2
    {4,10,7},  //MCATEGORY_RNG_2
    {4,10,7},  //MCATEGORY_SAM_2
    {12,10,7},  //MCATEGORY_NIN_2
    {4,10,7},  //MCATEGORY_DRG_2
    {6,10,7},  //MCATEGORY_SMN_2
    {4,10,7},  //MCATEGORY_BLU_2
    {4,10,7},  //MCATEGORY_COR_2
    {4,10,7},  //MCATEGORY_PUP_2
    {4,10,7},  //MCATEGORY_DNC_2
    {6,10,7},  //MCATEGORY_SHC_2
};

#define GetMeritCategory(merit) ((merit >> 6) - 1)      // получаем категорию из merit
#define GetMeritID(merit)       ((merit & 0x3F) >> 1)   // получаем смещение в категории из merit

/************************************************************************
*                                                                       *
*                                                                       *
*                                                                       *
************************************************************************/

CMeritPoints::CMeritPoints(CCharEntity* PChar)
{
	/*
	TPZ_DEBUG_BREAK_IF(sizeof(merits) != sizeof(merits::GMeritsTemplate));

    memcpy(merits, merits::GMeritsTemplate, sizeof(merits));

    for (uint8 m = 0, i = 0; i < sizeof(Categories)/sizeof(Merit_t*); ++i)
    {
        Categories[i] = &merits[m];

        for (uint8 t = 0; t < count[i].MaxMerits; ++t)
        {
            merits[m].next = upgrade[count[i].UpgradeID][0];
            merits[m++].id = ((i + 1) << 6) + (t << 1);
		}
    }
	*/

	TPZ_DEBUG_BREAK_IF(sizeof(merits) != sizeof(meritNameSpace::GMeritsTemplate));

    memcpy(merits, meritNameSpace::GMeritsTemplate, sizeof(merits));


    m_PChar = PChar;
	LoadMeritPoints(PChar->id);

    m_LimitPoints = 0;
    m_MeritPoints = 0;
}

/************************************************************************
*                                                                       *
*  Load character merits                                                *
*                                                                       *
************************************************************************/

void CMeritPoints::LoadMeritPoints(uint32 charid)
{
    uint8 catNumber = 0;

    for (uint16 i = 0; i < MERITS_COUNT; ++i)
    {
        if ((catNumber < 51 && i == meritNameSpace::groupOffset[catNumber]) || (catNumber > 25 && catNumber < 31))
        {

            if (catNumber > 25 && catNumber < 31) // point these to valid merits to prevent crash
                Categories[catNumber] = &merits[163];
            else
                Categories[catNumber] = &merits[i];

            catNumber++;
        }

        merits[i].count = 0;
        merits[i].next = upgrade[merits[i].upgradeid][merits[i].count];
    }

    if (Sql_Query(SqlHandle, "SELECT meritid, upgrades FROM char_merit WHERE charid = %u", charid) != SQL_ERROR)
    {
        for (uint16 j = 0; j < Sql_NumRows(SqlHandle); j++)
        {
            if (Sql_NextRow(SqlHandle) == SQL_SUCCESS)
            {
                uint32 meritID = Sql_GetUIntData(SqlHandle, 0);
                uint32 upgrades = Sql_GetUIntData(SqlHandle, 1);
                for (uint16 i = 0; i < MERITS_COUNT; i++)
                {
                    if (merits[i].id == meritID)
                    {
                        merits[i].count = upgrades;
                        merits[i].next = upgrade[merits[i].upgradeid][merits[i].count];
                    }
                }
            }
        }
    }
}

/************************************************************************
*                                                                       *
*  Save character merits                                                *
*                                                                       *
************************************************************************/

void CMeritPoints::SaveMeritPoints(uint32 charid)
{
    for (uint16 i = 0; i < MERITS_COUNT; ++i)
        if (merits[i].count > 0)
            Sql_Query(SqlHandle, "INSERT INTO char_merit (charid, meritid, upgrades) VALUES(%u, %u, %u) ON DUPLICATE KEY UPDATE upgrades = %u", charid, merits[i].id, merits[i].count, merits[i].count);
        else
            Sql_Query(SqlHandle, "DELETE FROM char_merit WHERE charid = %u AND meritid = %u", charid, merits[i].id);
}

/************************************************************************
*                                                                       *
*  Получаем текущие limit points                                        *
*                                                                       *
************************************************************************/

uint16 CMeritPoints::GetLimitPoints()
{
    return m_LimitPoints;
}

/************************************************************************
*                                                                       *
*  Получаем текущие merit points                                        *
*                                                                       *
************************************************************************/

uint8 CMeritPoints::GetMeritPoints()
{
    return m_MeritPoints;
}


/************************************************************************
*                                                                       *
*  Добавляем персонажу limit points                                     *
*                                                                       *
************************************************************************/

// true - если merit был добавлен

bool CMeritPoints::AddLimitPoints(uint16 points)
{
    m_LimitPoints += points;

    if (m_LimitPoints >= MAX_LIMIT_POINTS)
    {
		//check if player has reached cap
		if (m_MeritPoints == map_config.max_merit_points + GetMeritValue(MERIT_MAX_MERIT, m_PChar))
		{
			m_LimitPoints = MAX_LIMIT_POINTS -1;
			return false;
		}

        uint8 MeritPoints = std::min(m_MeritPoints + m_LimitPoints / MAX_LIMIT_POINTS, map_config.max_merit_points + GetMeritValue(MERIT_MAX_MERIT, m_PChar));

        m_LimitPoints = m_LimitPoints % MAX_LIMIT_POINTS;

        if (m_MeritPoints != MeritPoints)
        {
            m_MeritPoints = MeritPoints;
            return true;
        }
    }
    return false;
}

/************************************************************************
*                                                                       *
*  set limit points				                                        *
*                                                                       *
************************************************************************/

void CMeritPoints::SetLimitPoints(uint16 points)
{
    m_LimitPoints = std::min<uint16>(points, MAX_LIMIT_POINTS - 1);
}

/************************************************************************
*                                                                       *
*  set merit points				                                        *
*                                                                       *
************************************************************************/

void CMeritPoints::SetMeritPoints(uint16 points)
{
    m_MeritPoints = std::min<uint8>((uint8)points, map_config.max_merit_points + GetMeritValue(MERIT_MAX_MERIT, m_PChar));
}

/************************************************************************
*                                                                       *
*  Проверяем наличие merit. Необходимо использовать лишь в случае       *
*  получения meritid от персонажа                                       *
*                                                                       *
************************************************************************/

bool CMeritPoints::IsMeritExist(MERIT_TYPE merit)
{
    if ((int16)merit <  MCATEGORY_START) return false;
    if ((int16)merit >= MCATEGORY_COUNT) return false;

    if ((GetMeritID(merit)) >= meritCatInfo[GetMeritCategory(merit)].MeritsInCat) return false;

    return true;
}

/************************************************************************
*                                                                       *
*  Получаем указатель на искомый const merit                            *
*                                                                       *
************************************************************************/

const Merit_t* CMeritPoints::GetMerit(MERIT_TYPE merit)
{
    return GetMeritPointer(merit);
}

/************************************************************************
*                                                                       *
*  Получаем указатель на искомый const merit по индексу                 *
*                                                                       *
************************************************************************/

const Merit_t* CMeritPoints::GetMeritByIndex(uint16 index)
{
    TPZ_DEBUG_BREAK_IF(index >= MERITS_COUNT);

	return  &merits[index];
}

/************************************************************************
*                                                                       *
*  Получаем указатель на искомый merit                                  *
*                                                                       *
************************************************************************/

Merit_t* CMeritPoints::GetMeritPointer(MERIT_TYPE merit)
{
    if (IsMeritExist(merit))
    {
        return &Categories[GetMeritCategory(merit)][GetMeritID(merit)];
    }
    return nullptr;
}

uint8 CMeritPoints::GetMeritMaxUpgrades(uint8 catid)
{// WINGSCUSTOM
    if (catid == 0) // hp/mp
        return 10;
    if (catid == 1) // attributes
        return 5;
    if (catid == 2) // combat skills
        return 8;
    if (catid == 3) // magic skills
        return 8;
    if (catid == 4) // others (crit rate, enmity, spell interruption)
        return 5;
    if (catid >= 5 && catid <= 24) // job-specific group1
        return 5;
    if (catid == 25) // weapon skills (OOE)
        return 0;
    if (catid >= 31 && catid <= 50) // job-specific group2
        return 5;

    return 0;
}

uint8 CMeritPoints::GetMeritCategoryMaxUpgrades(uint8 catid)
{// WINGSCUSTOM
    if (catid == 0) // hp/mp
        return 20;
    if (catid == 1) // attributes
        return 25;
    if (catid == 2) // combat skills
        return 60;
    if (catid == 3) // magic skills
        return 56;
    if (catid == 4) // others (crit rate, enmity, spell interruption)
        return 15;
    if (catid >= 5 && catid <= 24) // job-specific group1
        return 10;
    if (catid == 25) // weapon skills (OOE)
        return 0;
    if (catid >= 31 && catid <= 50) // job-specific group2
        return 10;

    return 0;
}

uint8 CMeritPoints::GetCategoryUpgrades(CCharEntity* PChar, uint8 catid)
{
    uint8 ret = 0;
    switch (catid)
    {
    case 0:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_MAX_HP, PChar) / GetMeritPointer(MERIT_MAX_HP)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_MAX_MP, PChar) / GetMeritPointer(MERIT_MAX_MP)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_MAX_MERIT, PChar) / GetMeritPointer(MERIT_MAX_MERIT)->value;
        break;
    case 1:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_STR, PChar) / GetMeritPointer(MERIT_STR)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_DEX, PChar) / GetMeritPointer(MERIT_DEX)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_VIT, PChar) / GetMeritPointer(MERIT_VIT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_AGI, PChar) / GetMeritPointer(MERIT_AGI)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_INT, PChar) / GetMeritPointer(MERIT_INT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_MND, PChar) / GetMeritPointer(MERIT_MND)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_CHR, PChar) / GetMeritPointer(MERIT_CHR)->value;
        break;
    case 2:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_H2H, PChar) / GetMeritPointer(MERIT_H2H)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_DAGGER, PChar) / GetMeritPointer(MERIT_DAGGER)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SWORD, PChar) / GetMeritPointer(MERIT_SWORD)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_GSWORD, PChar) / GetMeritPointer(MERIT_GSWORD)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_AXE, PChar) / GetMeritPointer(MERIT_AXE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_GAXE, PChar) / GetMeritPointer(MERIT_GAXE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SCYTHE, PChar) / GetMeritPointer(MERIT_SCYTHE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_POLEARM, PChar) / GetMeritPointer(MERIT_POLEARM)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_KATANA, PChar) / GetMeritPointer(MERIT_KATANA)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_GKATANA, PChar) / GetMeritPointer(MERIT_GKATANA)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_CLUB, PChar) / GetMeritPointer(MERIT_CLUB)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_STAFF, PChar) / GetMeritPointer(MERIT_STAFF)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ARCHERY, PChar) / GetMeritPointer(MERIT_ARCHERY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_MARKSMANSHIP, PChar) / GetMeritPointer(MERIT_MARKSMANSHIP)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_THROWING, PChar) / GetMeritPointer(MERIT_THROWING)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_GUARDING, PChar) / GetMeritPointer(MERIT_GUARDING)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_EVASION, PChar) / GetMeritPointer(MERIT_EVASION)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SHIELD, PChar) / GetMeritPointer(MERIT_SHIELD)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_PARRYING, PChar) / GetMeritPointer(MERIT_PARRYING)->value;
        break;
    case 3:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_DIVINE, PChar) / GetMeritPointer(MERIT_DIVINE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_HEALING, PChar) / GetMeritPointer(MERIT_HEALING)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ENHANCING, PChar) / GetMeritPointer(MERIT_ENHANCING)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ENFEEBLING, PChar) / GetMeritPointer(MERIT_ENFEEBLING)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ELEMENTAL, PChar) / GetMeritPointer(MERIT_ELEMENTAL)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_DARK, PChar) / GetMeritPointer(MERIT_DARK)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SUMMONING, PChar) / GetMeritPointer(MERIT_SUMMONING)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_NINJITSU, PChar) / GetMeritPointer(MERIT_NINJITSU)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SINGING, PChar) / GetMeritPointer(MERIT_SINGING)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_STRING, PChar) / GetMeritPointer(MERIT_STRING)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_WIND, PChar) / GetMeritPointer(MERIT_WIND)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_BLUE, PChar) / GetMeritPointer(MERIT_BLUE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_GEO, PChar) / GetMeritPointer(MERIT_GEO)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_HANDBELL, PChar) / GetMeritPointer(MERIT_HANDBELL)->value;
        break;
    case 4:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ENMITY_INCREASE, PChar) / GetMeritPointer(MERIT_ENMITY_INCREASE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ENMITY_DECREASE, PChar) / GetMeritPointer(MERIT_ENMITY_DECREASE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_CRIT_HIT_RATE, PChar) / GetMeritPointer(MERIT_CRIT_HIT_RATE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ENEMY_CRIT_RATE, PChar) / GetMeritPointer(MERIT_ENEMY_CRIT_RATE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SPELL_INTERUPTION_RATE, PChar) / GetMeritPointer(MERIT_SPELL_INTERUPTION_RATE)->value;
        break;
    case 5:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_BERSERK_RECAST, PChar) / GetMeritPointer(MERIT_BERSERK_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_DEFENDER_RECAST, PChar) / GetMeritPointer(MERIT_DEFENDER_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_WARCRY_RECAST, PChar) / GetMeritPointer(MERIT_WARCRY_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_AGGRESSOR_RECAST, PChar) / GetMeritPointer(MERIT_AGGRESSOR_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_DOUBLE_ATTACK_RATE, PChar) / GetMeritPointer(MERIT_DOUBLE_ATTACK_RATE)->value;
        break;
    case 6:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_FOCUS_RECAST, PChar) / GetMeritPointer(MERIT_FOCUS_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_DODGE_RECAST, PChar) / GetMeritPointer(MERIT_DODGE_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_CHAKRA_RECAST, PChar) / GetMeritPointer(MERIT_CHAKRA_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_COUNTER_RATE, PChar) / GetMeritPointer(MERIT_COUNTER_RATE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_KICK_ATTACK_RATE, PChar) / GetMeritPointer(MERIT_KICK_ATTACK_RATE)->value;
        break;
    case 7:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_DIVINE_SEAL_RECAST, PChar) / GetMeritPointer(MERIT_DIVINE_SEAL_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_CURE_CAST_TIME, PChar) / GetMeritPointer(MERIT_CURE_CAST_TIME)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_BAR_SPELL_EFFECT, PChar) / GetMeritPointer(MERIT_BAR_SPELL_EFFECT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_BANISH_EFFECT, PChar) / GetMeritPointer(MERIT_BANISH_EFFECT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_REGEN_EFFECT, PChar) / GetMeritPointer(MERIT_REGEN_EFFECT)->value;
        break;
    case 8:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ELEMENTAL_SEAL_RECAST, PChar) / GetMeritPointer(MERIT_ELEMENTAL_SEAL_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_FIRE_MAGIC_POTENCY, PChar) / GetMeritPointer(MERIT_FIRE_MAGIC_POTENCY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ICE_MAGIC_POTENCY, PChar) / GetMeritPointer(MERIT_ICE_MAGIC_POTENCY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_WIND_MAGIC_POTENCY, PChar) / GetMeritPointer(MERIT_WIND_MAGIC_POTENCY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_EARTH_MAGIC_POTENCY, PChar) / GetMeritPointer(MERIT_EARTH_MAGIC_POTENCY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_LIGHTNING_MAGIC_POTENCY, PChar) / GetMeritPointer(MERIT_LIGHTNING_MAGIC_POTENCY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_WATER_MAGIC_POTENCY, PChar) / GetMeritPointer(MERIT_WATER_MAGIC_POTENCY)->value;
        break;
    case 9:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_CONVERT_RECAST, PChar) / GetMeritPointer(MERIT_CONVERT_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_FIRE_MAGIC_ACCURACY, PChar) / GetMeritPointer(MERIT_FIRE_MAGIC_ACCURACY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ICE_MAGIC_ACCURACY, PChar) / GetMeritPointer(MERIT_ICE_MAGIC_ACCURACY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_WIND_MAGIC_ACCURACY, PChar) / GetMeritPointer(MERIT_WIND_MAGIC_ACCURACY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_EARTH_MAGIC_ACCURACY, PChar) / GetMeritPointer(MERIT_EARTH_MAGIC_ACCURACY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_LIGHTNING_MAGIC_ACCURACY, PChar) / GetMeritPointer(MERIT_LIGHTNING_MAGIC_ACCURACY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_WATER_MAGIC_ACCURACY, PChar) / GetMeritPointer(MERIT_WATER_MAGIC_ACCURACY)->value;
        break;
    case 10:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_FLEE_RECAST, PChar) / GetMeritPointer(MERIT_FLEE_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_HIDE_RECAST, PChar) / GetMeritPointer(MERIT_HIDE_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SNEAK_ATTACK_RECAST, PChar) / GetMeritPointer(MERIT_SNEAK_ATTACK_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_TRICK_ATTACK_RECAST, PChar) / GetMeritPointer(MERIT_TRICK_ATTACK_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_TRIPLE_ATTACK_RATE, PChar) / GetMeritPointer(MERIT_TRIPLE_ATTACK_RATE)->value;
        break;
    case 11:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SHIELD_BASH_RECAST, PChar) / GetMeritPointer(MERIT_SHIELD_BASH_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_HOLY_CIRCLE_RECAST, PChar) / GetMeritPointer(MERIT_HOLY_CIRCLE_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SENTINEL_RECAST, PChar) / GetMeritPointer(MERIT_SENTINEL_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_COVER_EFFECT_LENGTH, PChar) / GetMeritPointer(MERIT_COVER_EFFECT_LENGTH)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_RAMPART_RECAST, PChar) / GetMeritPointer(MERIT_RAMPART_RECAST)->value;
        break;
    case 12:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SOULEATER_RECAST, PChar) / GetMeritPointer(MERIT_SOULEATER_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ARCANE_CIRCLE_RECAST, PChar) / GetMeritPointer(MERIT_ARCANE_CIRCLE_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_LAST_RESORT_RECAST, PChar) / GetMeritPointer(MERIT_LAST_RESORT_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_LAST_RESORT_EFFECT, PChar) / GetMeritPointer(MERIT_LAST_RESORT_EFFECT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_WEAPON_BASH_EFFECT, PChar) / GetMeritPointer(MERIT_WEAPON_BASH_EFFECT)->value;
        break;
    case 13:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_KILLER_EFFECTS, PChar) / GetMeritPointer(MERIT_KILLER_EFFECTS)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_REWARD_RECAST, PChar) / GetMeritPointer(MERIT_REWARD_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_CALL_BEAST_RECAST, PChar) / GetMeritPointer(MERIT_CALL_BEAST_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SIC_RECAST, PChar) / GetMeritPointer(MERIT_SIC_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_TAME_RECAST, PChar) / GetMeritPointer(MERIT_TAME_RECAST)->value;
        break;
    case 14:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_LULLABY_RECAST, PChar) / GetMeritPointer(MERIT_LULLABY_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_FINALE_RECAST, PChar) / GetMeritPointer(MERIT_FINALE_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_MINNE_EFFECT, PChar) / GetMeritPointer(MERIT_MINNE_EFFECT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_MINUET_EFFECT, PChar) / GetMeritPointer(MERIT_MINUET_EFFECT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_MADRIGAL_EFFECT, PChar) / GetMeritPointer(MERIT_MADRIGAL_EFFECT)->value;
        break;
    case 15:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SCAVENGE_EFFECT, PChar) / GetMeritPointer(MERIT_SCAVENGE_EFFECT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_CAMOUFLAGE_RECAST, PChar) / GetMeritPointer(MERIT_CAMOUFLAGE_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SHARPSHOT_RECAST, PChar) / GetMeritPointer(MERIT_SHARPSHOT_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_UNLIMITED_SHOT_RECAST, PChar) / GetMeritPointer(MERIT_UNLIMITED_SHOT_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_RAPID_SHOT_RATE, PChar) / GetMeritPointer(MERIT_RAPID_SHOT_RATE)->value;
        break;
    case 16:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_THIRD_EYE_RECAST, PChar) / GetMeritPointer(MERIT_THIRD_EYE_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_WARDING_CIRCLE_RECAST, PChar) / GetMeritPointer(MERIT_WARDING_CIRCLE_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_STORE_TP_EFFECT, PChar) / GetMeritPointer(MERIT_STORE_TP_EFFECT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_MEDITATE_RECAST, PChar) / GetMeritPointer(MERIT_MEDITATE_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ZANSHIN_ATTACK_RATE, PChar) / GetMeritPointer(MERIT_ZANSHIN_ATTACK_RATE)->value;
        break;
    case 17:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SUBTLE_BLOW_EFFECT, PChar) / GetMeritPointer(MERIT_SUBTLE_BLOW_EFFECT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_KATON_EFFECT, PChar) / GetMeritPointer(MERIT_KATON_EFFECT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_HYOTON_EFFECT, PChar) / GetMeritPointer(MERIT_HYOTON_EFFECT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_HUTON_EFFECT, PChar) / GetMeritPointer(MERIT_HUTON_EFFECT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_DOTON_EFFECT, PChar) / GetMeritPointer(MERIT_DOTON_EFFECT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_RAITON_EFFECT, PChar) / GetMeritPointer(MERIT_RAITON_EFFECT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SUITON_EFFECT, PChar) / GetMeritPointer(MERIT_SUITON_EFFECT)->value;
        break;
    case 18:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ANCIENT_CIRCLE_RECAST, PChar) / GetMeritPointer(MERIT_ANCIENT_CIRCLE_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_JUMP_RECAST, PChar) / GetMeritPointer(MERIT_JUMP_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_HIGH_JUMP_RECAST, PChar) / GetMeritPointer(MERIT_HIGH_JUMP_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SUPER_JUMP_RECAST, PChar) / GetMeritPointer(MERIT_SUPER_JUMP_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SPIRIT_LINK_RECAST, PChar) / GetMeritPointer(MERIT_SPIRIT_LINK_RECAST)->value;
        break;
    case 19:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_PHYSICAL_ACCURACY, PChar) / GetMeritPointer(MERIT_AVATAR_PHYSICAL_ACCURACY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_PHYSICAL_ATTACK, PChar) / GetMeritPointer(MERIT_AVATAR_PHYSICAL_ATTACK)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_MAGICAL_ACCURACY, PChar) / GetMeritPointer(MERIT_AVATAR_MAGICAL_ACCURACY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_AVATAR_MAGICAL_ATTACK, PChar) / GetMeritPointer(MERIT_AVATAR_MAGICAL_ATTACK)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SUMMONING_MAGIC_CAST_TIME, PChar) / GetMeritPointer(MERIT_SUMMONING_MAGIC_CAST_TIME)->value;
        break;
    case 20:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_CHAIN_AFFINITY_RECAST, PChar) / GetMeritPointer(MERIT_CHAIN_AFFINITY_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_BURST_AFFINITY_RECAST, PChar) / GetMeritPointer(MERIT_BURST_AFFINITY_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_MONSTER_CORRELATION, PChar) / GetMeritPointer(MERIT_MONSTER_CORRELATION)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_PHYSICAL_POTENCY, PChar) / GetMeritPointer(MERIT_PHYSICAL_POTENCY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_MAGICAL_ACCURACY, PChar) / GetMeritPointer(MERIT_MAGICAL_ACCURACY)->value;
        break;
    case 21:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_PHANTOM_ROLL_RECAST, PChar) / GetMeritPointer(MERIT_PHANTOM_ROLL_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_QUICK_DRAW_RECAST, PChar) / GetMeritPointer(MERIT_QUICK_DRAW_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_QUICK_DRAW_ACCURACY, PChar) / GetMeritPointer(MERIT_QUICK_DRAW_ACCURACY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_RANDOM_DEAL_RECAST, PChar) / GetMeritPointer(MERIT_RANDOM_DEAL_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_BUST_DURATION, PChar) / GetMeritPointer(MERIT_BUST_DURATION)->value;
        break;
    case 22:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_AUTOMATON_MELEE, PChar) / GetMeritPointer(MERIT_AUTOMATON_MELEE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_AUTOMATON_RANGED, PChar) / GetMeritPointer(MERIT_AUTOMATON_RANGED)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_AUTOMATON_MAGIC, PChar) / GetMeritPointer(MERIT_AUTOMATON_MAGIC)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ACTIVATE_RECAST, PChar) / GetMeritPointer(MERIT_ACTIVATE_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_REPAIR_RECAST, PChar) / GetMeritPointer(MERIT_REPAIR_RECAST)->value;
        break;
    case 23:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_STEP_ACCURACY, PChar) / GetMeritPointer(MERIT_STEP_ACCURACY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_HASTE_SAMBA_EFFECT, PChar) / GetMeritPointer(MERIT_HASTE_SAMBA_EFFECT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_REVERSE_FLOURISH_EFFECT, PChar) / GetMeritPointer(MERIT_REVERSE_FLOURISH_EFFECT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_BUILDING_FLOURISH_EFFECT, PChar) / GetMeritPointer(MERIT_BUILDING_FLOURISH_EFFECT)->value;
        break;
    case 24:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_GRIMOIRE_RECAST, PChar) / GetMeritPointer(MERIT_GRIMOIRE_RECAST)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_MODUS_VERITAS_DURATION, PChar) / GetMeritPointer(MERIT_MODUS_VERITAS_DURATION)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_HELIX_MAGIC_ACC_ATT, PChar) / GetMeritPointer(MERIT_HELIX_MAGIC_ACC_ATT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_MAX_SUBLIMATION, PChar) / GetMeritPointer(MERIT_MAX_SUBLIMATION)->value;
        break;
    case 25:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SHIJIN_SPIRAL, PChar) / GetMeritPointer(MERIT_SHIJIN_SPIRAL)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_EXENTERATOR, PChar) / GetMeritPointer(MERIT_EXENTERATOR)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_REQUIESCAT, PChar) / GetMeritPointer(MERIT_REQUIESCAT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_RESOLUTION, PChar) / GetMeritPointer(MERIT_RESOLUTION)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_RUINATOR, PChar) / GetMeritPointer(MERIT_RUINATOR)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_UPHEAVAL, PChar) / GetMeritPointer(MERIT_UPHEAVAL)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ENTROPY, PChar) / GetMeritPointer(MERIT_ENTROPY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_STARDIVER, PChar) / GetMeritPointer(MERIT_STARDIVER)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_BLADE_SHUN, PChar) / GetMeritPointer(MERIT_BLADE_SHUN)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_TACHI_SHOHA, PChar) / GetMeritPointer(MERIT_TACHI_SHOHA)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_REALMRAZER, PChar) / GetMeritPointer(MERIT_REALMRAZER)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SHATTERSOUL, PChar) / GetMeritPointer(MERIT_SHATTERSOUL)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_APEX_ARROW, PChar) / GetMeritPointer(MERIT_APEX_ARROW)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_LAST_STAND, PChar) / GetMeritPointer(MERIT_LAST_STAND)->value;
        break;
    case 26:
    case 27:
    case 28:
    case 29:
    case 30:
        break;
    case 31:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_WARRIORS_CHARGE, PChar) / GetMeritPointer(MERIT_WARRIORS_CHARGE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_TOMAHAWK, PChar) / GetMeritPointer(MERIT_TOMAHAWK)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SAVAGERY, PChar) / GetMeritPointer(MERIT_SAVAGERY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_AGGRESSIVE_AIM, PChar) / GetMeritPointer(MERIT_AGGRESSIVE_AIM)->value;
        break;
    case 32:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_MANTRA, PChar) / GetMeritPointer(MERIT_MANTRA)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_FORMLESS_STRIKES, PChar) / GetMeritPointer(MERIT_FORMLESS_STRIKES)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_INVIGORATE, PChar) / GetMeritPointer(MERIT_INVIGORATE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_PENANCE, PChar) / GetMeritPointer(MERIT_PENANCE)->value;
        break;
    case 33:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_MARTYR, PChar) / GetMeritPointer(MERIT_MARTYR)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_DEVOTION, PChar) / GetMeritPointer(MERIT_DEVOTION)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_PROTECTRA_V, PChar) / GetMeritPointer(MERIT_PROTECTRA_V)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SHELLRA_V, PChar) / GetMeritPointer(MERIT_SHELLRA_V)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ANIMUS_SOLACE, PChar) / GetMeritPointer(MERIT_ANIMUS_SOLACE)->value; // not in Kupo client
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ANIMUS_MISERY, PChar) / GetMeritPointer(MERIT_ANIMUS_MISERY)->value; // not in Kupo client
        break;
    case 34:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_FLARE_II, PChar) / GetMeritPointer(MERIT_FLARE_II)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_FREEZE_II, PChar) / GetMeritPointer(MERIT_FREEZE_II)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_TORNADO_II, PChar) / GetMeritPointer(MERIT_TORNADO_II)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_QUAKE_II, PChar) / GetMeritPointer(MERIT_QUAKE_II)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_BURST_II, PChar) / GetMeritPointer(MERIT_BURST_II)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_FLOOD_II, PChar) / GetMeritPointer(MERIT_FLOOD_II)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ANCIENT_MAGIC_ATK_BONUS, PChar) / GetMeritPointer(MERIT_ANCIENT_MAGIC_ATK_BONUS)->value; // not in Kupo client
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ANCIENT_MAGIC_BURST_DMG, PChar) / GetMeritPointer(MERIT_ANCIENT_MAGIC_BURST_DMG)->value; // not in Kupo client
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ELEMENTAL_MAGIC_ACCURACY, PChar) / GetMeritPointer(MERIT_ELEMENTAL_MAGIC_ACCURACY)->value; // not in Kupo client
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ELEMENTAL_DEBUFF_DURATION, PChar) / GetMeritPointer(MERIT_ELEMENTAL_DEBUFF_DURATION)->value; // not in Kupo client
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ELEMENTAL_DEBUFF_EFFECT, PChar) / GetMeritPointer(MERIT_ELEMENTAL_DEBUFF_EFFECT)->value; // not in Kupo client
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ASPIR_ABSORPTION_AMOUNT, PChar) / GetMeritPointer(MERIT_ASPIR_ABSORPTION_AMOUNT)->value; // not in Kupo client
        break;
    case 35:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_DIA_III, PChar) / GetMeritPointer(MERIT_DIA_III)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SLOW_II, PChar) / GetMeritPointer(MERIT_SLOW_II)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_PARALYZE_II, PChar) / GetMeritPointer(MERIT_PARALYZE_II)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_PHALANX_II, PChar) / GetMeritPointer(MERIT_PHALANX_II)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_BIO_III, PChar) / GetMeritPointer(MERIT_BIO_III)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_BLIND_II, PChar) / GetMeritPointer(MERIT_BLIND_II)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ENFEEBLING_MAGIC_DURATION, PChar) / GetMeritPointer(MERIT_ENFEEBLING_MAGIC_DURATION)->value; // not in Kupo client
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_MAGIC_ACCURACY, PChar) / GetMeritPointer(MERIT_MAGIC_ACCURACY)->value; // not in Kupo client
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ENHANCING_MAGIC_DURATION, PChar) / GetMeritPointer(MERIT_ENHANCING_MAGIC_DURATION)->value; // not in Kupo client
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_IMMUNOBREAK_CHANCE, PChar) / GetMeritPointer(MERIT_IMMUNOBREAK_CHANCE)->value; // not in Kupo client
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ENSPELL_DAMAGE, PChar) / GetMeritPointer(MERIT_ENSPELL_DAMAGE)->value; // not in Kupo client
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ACCURACY, PChar) / GetMeritPointer(MERIT_ACCURACY)->value; // not in Kupo client
        break;
    case 36:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ASSASSINS_CHARGE, PChar) / GetMeritPointer(MERIT_ASSASSINS_CHARGE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_FEINT, PChar) / GetMeritPointer(MERIT_FEINT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_AURA_STEAL, PChar) / GetMeritPointer(MERIT_AURA_STEAL)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_AMBUSH, PChar) / GetMeritPointer(MERIT_AMBUSH)->value;
        break;
    case 37:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_FEALTY, PChar) / GetMeritPointer(MERIT_FEALTY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_CHIVALRY, PChar) / GetMeritPointer(MERIT_CHIVALRY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_IRON_WILL, PChar) / GetMeritPointer(MERIT_IRON_WILL)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_GUARDIAN, PChar) / GetMeritPointer(MERIT_GUARDIAN)->value;
        break;
    case 38:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_DARK_SEAL, PChar) / GetMeritPointer(MERIT_DARK_SEAL)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_DIABOLIC_EYE, PChar) / GetMeritPointer(MERIT_DIABOLIC_EYE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_MUTED_SOUL, PChar) / GetMeritPointer(MERIT_MUTED_SOUL)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_DESPERATE_BLOWS, PChar) / GetMeritPointer(MERIT_DESPERATE_BLOWS)->value;
        break;
    case 39:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_FERAL_HOWL, PChar) / GetMeritPointer(MERIT_FERAL_HOWL)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_KILLER_INSTINCT, PChar) / GetMeritPointer(MERIT_KILLER_INSTINCT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_BEAST_AFFINITY, PChar) / GetMeritPointer(MERIT_BEAST_AFFINITY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_BEAST_HEALER, PChar) / GetMeritPointer(MERIT_BEAST_HEALER)->value;
        break;
    case 40:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_NIGHTINGALE, PChar) / GetMeritPointer(MERIT_NIGHTINGALE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_TROUBADOUR, PChar) / GetMeritPointer(MERIT_TROUBADOUR)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_FOE_SIRVENTE, PChar) / GetMeritPointer(MERIT_FOE_SIRVENTE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ADVENTURERS_DIRGE, PChar) / GetMeritPointer(MERIT_ADVENTURERS_DIRGE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_CON_ANIMA, PChar) / GetMeritPointer(MERIT_CON_ANIMA)->value; // not in Kupo client
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_CON_BRIO, PChar) / GetMeritPointer(MERIT_CON_BRIO)->value; // not in Kupo client
        break;
    case 41:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_STEALTH_SHOT, PChar) / GetMeritPointer(MERIT_STEALTH_SHOT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_FLASHY_SHOT, PChar) / GetMeritPointer(MERIT_FLASHY_SHOT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SNAPSHOT, PChar) / GetMeritPointer(MERIT_SNAPSHOT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_RECYCLE, PChar) / GetMeritPointer(MERIT_RECYCLE)->value;
        break;
    case 42:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SHIKIKOYO, PChar) / GetMeritPointer(MERIT_SHIKIKOYO)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_BLADE_BASH, PChar) / GetMeritPointer(MERIT_BLADE_BASH)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_IKISHOTEN, PChar) / GetMeritPointer(MERIT_IKISHOTEN)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_OVERWHELM, PChar) / GetMeritPointer(MERIT_OVERWHELM)->value;
        break;
    case 43:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SANGE, PChar) / GetMeritPointer(MERIT_SANGE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_NINJA_TOOL_EXPERTISE, PChar) / GetMeritPointer(MERIT_NINJA_TOOL_EXPERTISE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_KATON_SAN, PChar) / GetMeritPointer(MERIT_KATON_SAN)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_HYOTON_SAN, PChar) / GetMeritPointer(MERIT_HYOTON_SAN)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_HUTON_SAN, PChar) / GetMeritPointer(MERIT_HUTON_SAN)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_DOTON_SAN, PChar) / GetMeritPointer(MERIT_DOTON_SAN)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_RAITON_SAN, PChar) / GetMeritPointer(MERIT_RAITON_SAN)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SUITON_SAN, PChar) / GetMeritPointer(MERIT_SUITON_SAN)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_YONIN_EFFECT, PChar) / GetMeritPointer(MERIT_YONIN_EFFECT)->value; // not in Kupo client
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_INNIN_EFFECT, PChar) / GetMeritPointer(MERIT_INNIN_EFFECT)->value; // not in Kupo client
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_NIN_MAGIC_ACCURACY, PChar) / GetMeritPointer(MERIT_NIN_MAGIC_ACCURACY)->value; // not in Kupo client
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_NIN_MAGIC_BONUS, PChar) / GetMeritPointer(MERIT_NIN_MAGIC_BONUS)->value; // not in Kupo client
        break;
    case 44:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_DEEP_BREATHING, PChar) / GetMeritPointer(MERIT_DEEP_BREATHING)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ANGON, PChar) / GetMeritPointer(MERIT_ANGON)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_EMPATHY, PChar) / GetMeritPointer(MERIT_EMPATHY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_STRAFE, PChar) / GetMeritPointer(MERIT_STRAFE)->value;
        break;
    case 45:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_METEOR_STRIKE, PChar) / GetMeritPointer(MERIT_METEOR_STRIKE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_HEAVENLY_STRIKE, PChar) / GetMeritPointer(MERIT_HEAVENLY_STRIKE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_WIND_BLADE, PChar) / GetMeritPointer(MERIT_WIND_BLADE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_GEOCRUSH, PChar) / GetMeritPointer(MERIT_GEOCRUSH)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_THUNDERSTORM, PChar) / GetMeritPointer(MERIT_THUNDERSTORM)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_GRANDFALL, PChar) / GetMeritPointer(MERIT_GRANDFALL)->value;
        break;
    case 46:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_CONVERGENCE, PChar) / GetMeritPointer(MERIT_CONVERGENCE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_DIFFUSION, PChar) / GetMeritPointer(MERIT_DIFFUSION)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ENCHAINMENT, PChar) / GetMeritPointer(MERIT_ENCHAINMENT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ASSIMILATION, PChar) / GetMeritPointer(MERIT_ASSIMILATION)->value;
        break;
    case 47:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SNAKE_EYE, PChar) / GetMeritPointer(MERIT_SNAKE_EYE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_FOLD, PChar) / GetMeritPointer(MERIT_FOLD)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_WINNING_STREAK, PChar) / GetMeritPointer(MERIT_WINNING_STREAK)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_LOADED_DECK, PChar) / GetMeritPointer(MERIT_LOADED_DECK)->value;
        break;
    case 48:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ROLE_REVERSAL, PChar) / GetMeritPointer(MERIT_ROLE_REVERSAL)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_VENTRILOQUY, PChar) / GetMeritPointer(MERIT_VENTRILOQUY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_FINE_TUNING, PChar) / GetMeritPointer(MERIT_FINE_TUNING)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_OPTIMIZATION, PChar) / GetMeritPointer(MERIT_OPTIMIZATION)->value;
        break;
    case 49:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_SABER_DANCE, PChar) / GetMeritPointer(MERIT_SABER_DANCE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_FAN_DANCE, PChar) / GetMeritPointer(MERIT_FAN_DANCE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_NO_FOOT_RISE, PChar) / GetMeritPointer(MERIT_NO_FOOT_RISE)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_CLOSED_POSITION, PChar) / GetMeritPointer(MERIT_CLOSED_POSITION)->value;
        break;
    case 50:
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ALTRUISM, PChar) / GetMeritPointer(MERIT_ALTRUISM)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_FOCALIZATION, PChar) / GetMeritPointer(MERIT_FOCALIZATION)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_TRANQUILITY, PChar) / GetMeritPointer(MERIT_TRANQUILITY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_EQUANIMITY, PChar) / GetMeritPointer(MERIT_EQUANIMITY)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_ENLIGHTENMENT, PChar) / GetMeritPointer(MERIT_ENLIGHTENMENT)->value;
        ret += PChar->PMeritPoints->GetMeritValue(MERIT_STORMSURGE, PChar) / GetMeritPointer(MERIT_STORMSURGE)->value; // i realized a bit laet that PMerit->count is a thing. woops.
        break;
    }
    //ShowDebug("ret is %u\n",ret);
    return ret;
}

/************************************************************************
*                                                                       *
*  Add upgrade, also removes merit point                                *
*                                                                       *
************************************************************************/

bool CMeritPoints::RaiseMerit(CCharEntity* PChar, MERIT_TYPE merit)
{
    if (merit == (MERIT_TYPE)2184 || merit == (MERIT_TYPE)2186 || merit == (MERIT_TYPE)2252 || merit == (MERIT_TYPE)2254 || merit == (MERIT_TYPE)2256 || merit == (MERIT_TYPE)2258 ||
        merit == (MERIT_TYPE)2260 || merit == (MERIT_TYPE)2262 || merit == (MERIT_TYPE)2316 || merit == (MERIT_TYPE)2318 || merit == (MERIT_TYPE)2320 || merit == (MERIT_TYPE)2322 ||
        merit == (MERIT_TYPE)2324 || merit == (MERIT_TYPE)2326 || merit == (MERIT_TYPE)2632 || merit == (MERIT_TYPE)2634 || merit == (MERIT_TYPE)2832 || merit == (MERIT_TYPE)2834 ||
        merit == (MERIT_TYPE)2836 || merit == (MERIT_TYPE)2338) // out of era merits that were added in 2018/2019/2020. dont spend the players merits and waste them.
        return false;

    Merit_t* PMerit = GetMeritPointer(merit);
    uint32 jobbit = 1 << (uint8)(PChar->GetMJob());

    uint8 currentUpgrades = PChar->PMeritPoints->GetMeritValue(merit, PChar) / PMerit->value;
    uint8 maxUpgrades = GetMeritMaxUpgrades(PMerit->catid);
    uint8 catCurrentUpgrades = GetCategoryUpgrades(PChar, PMerit->catid);
    uint8 maxCatUpgrades = GetMeritCategoryMaxUpgrades(PMerit->catid);

    //ShowDebug("merit upgrade, pre-check on category is is %u upgrades of %u max\n", catCurrentUpgrades, maxCatUpgrades);
    
    if ((jobbit |= PMerit->jobs) && (m_MeritPoints >= PMerit->next) && (currentUpgrades < maxUpgrades) && (catCurrentUpgrades < maxCatUpgrades))
    {
        m_MeritPoints -= PMerit->next;

		PMerit->next = upgrade[PMerit->upgradeid][PMerit->count+1];
        if (PMerit->spellid != 0)
        {
            if (charutils::addSpell(m_PChar, PMerit->spellid))
            {
                charutils::SaveSpell(m_PChar, PMerit->spellid);
                m_PChar->pushPacket(new CCharSpellsPacket(m_PChar));
            }
        }
		PMerit->count++;

        // Reset traits
        charutils::BuildingCharTraitsTable(m_PChar);
        return true;
    }
    return false;
}

/************************************************************************
*                                                                       *
*  Remove upgrade                                                       *
*                                                                       *
************************************************************************/

bool CMeritPoints::LowerMerit(MERIT_TYPE merit)
{
    Merit_t* PMerit = GetMeritPointer(merit);

    if (PMerit->count == 0)
        return false;

    PMerit->next = upgrade[meritCatInfo[GetMeritCategory(merit)].UpgradeID][--PMerit->count];
    if (PMerit->spellid != 0 && PMerit->count == 0)
    {
        if (charutils::delSpell(m_PChar, PMerit->spellid))
        {
            charutils::DeleteSpell(m_PChar, PMerit->spellid);
            m_PChar->pushPacket(new CCharSpellsPacket(m_PChar));

            // Reset traits
            charutils::BuildingCharTraitsTable(m_PChar);
        }
    }
    return true;
}

/************************************************************************
*                                                                       *
*  get next merit upgrade					                            *
*                                                                       *
************************************************************************/

//uint16 CMeritPoints::GetNextMeritUpgrade(uint16 catId, uint16 MeritCount)
//{
//	return upgrade[count[catId].UpgradeID][MeritCount];
//}

/************************************************************************
*                                                                       *
*  Получаем текущее значение указанного merit                           *
*                                                                       *
************************************************************************/

int32 CMeritPoints::GetMeritValue(MERIT_TYPE merit, CCharEntity* PChar)
{
    Merit_t* PMerit = GetMeritPointer(merit);
	uint16 meritValue = 0;

    if (PMerit)
    {
        if (PMerit->catid < 5 || (PMerit->jobs & (1 << (PChar->GetMJob() - 1)) && PChar->GetMLevel() >= 75))
            meritValue = std::min(PMerit->count, cap[PChar->GetMLevel()]);

        if (PMerit->catid == 25 && PChar->GetMLevel() < 96) // categoryID 25 is for merit weaponskills, which only apply if the player is lv 96+
            meritValue = 0;

        meritValue *= PMerit->value;
    }

	return meritValue;
}


/************************************************************************
*                                                                       *
*  Реализация namespase для работы с Linkshells                         *
*                                                                       *
************************************************************************/


namespace meritNameSpace
{
	Merit_t GMeritsTemplate[MERITS_COUNT] = {0};		// global list of merits and their properties
	int16 groupOffset[MCATEGORY_COUNT/64-1] = {0};		// the first merit offset of each catagory

    /************************************************************************
    *                                                                       *
    *  Загружаем шаблон массива merits  /   Load pattern array merits       *
    *                                                                       *
    ************************************************************************/

    void LoadMeritsList()
    {

        int32 ret = Sql_Query(SqlHandle, "SELECT m.meritid, m.value, m.jobs, m.upgrade, m.upgradeid, m.catagoryid, sl.spellid FROM merits m LEFT JOIN \
            spell_list sl ON m.name = sl.name ORDER BY m.meritid ASC LIMIT %u", MERITS_COUNT);

	    if( ret != SQL_ERROR && Sql_NumRows(SqlHandle) != MERITS_COUNT )
	    {

			// issue with unknown catagories causing massive confusion

            uint16 index = 0;			// global merit template count (to 255)
			uint8 catIndex = 0;			// global merit catagory count (to 51)
			int8 previousCatIndex = 0;  // will be set on every loop, used for detecting a catagory change
			int8 catMeritIndex = 0;		// counts number of merits in a catagory


		    while( Sql_NextRow(SqlHandle) == SQL_SUCCESS )
		    {
                Merit_t Merit = {0};								// creat a new merit template.

				Merit.id		= Sql_GetUIntData(SqlHandle,0);		// set data from db.
                Merit.value		= Sql_GetUIntData(SqlHandle,1);
                Merit.jobs		= Sql_GetUIntData(SqlHandle,2);
                Merit.upgrade	= Sql_GetUIntData(SqlHandle,3);
				Merit.upgradeid = Sql_GetUIntData(SqlHandle,4);
				Merit.catid		= Sql_GetUIntData(SqlHandle,5);
				Merit.next      = upgrade[Merit.upgradeid][0];
                Merit.spellid   = Sql_GetUIntData(SqlHandle, 6);

				GMeritsTemplate[index] = Merit;						// add the merit to the array


				previousCatIndex = Merit.catid;						// previousCatIndex is set on everyloop to detect a catogory change.

				if (previousCatIndex != catIndex)					// check for catagory change.
				{
					groupOffset[catIndex] = index - catMeritIndex;	// set index offset, first merit of each group.
					catIndex++;										// now on next catagory.
					catMeritIndex = 0;								// reset the merit catagory count to 0.

					if (previousCatIndex != catIndex)				// this deals with the problem with unknown catagories.
						catIndex = previousCatIndex;
				}

				catMeritIndex++;									// next index within catagory.
				index++;											// next global template index.
		    }

			groupOffset[catIndex] = index - catMeritIndex;			// add the last offset manually since loop finishes before hand.

           /* ret = Sql_Query(SqlHandle, "SELECT meritid, spellid FROM merits INNER JOIN spell_list ON merits.name = spell_list.name");

            if (ret != SQL_ERROR)
            {
		        while( Sql_NextRow(SqlHandle) == SQL_SUCCESS )
		        {
                    GMeritsTemplate
		        }
            }*/

	    }
        else
        {
            ShowError(CL_RED"The merits table is damaged\n" CL_RESET);
        }
    }

};
