﻿/*
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

#include "blue_spell.h"

CBlueSpell::CBlueSpell(SpellID id) : CSpell(id)
{
}

std::unique_ptr<CSpell> CBlueSpell::clone()
{
  return std::unique_ptr<CBlueSpell>(new CBlueSpell(*this));
}

uint16 CBlueSpell::getMonsterSkillId()
{
	return m_monsterSkillId;
}

void CBlueSpell::setMonsterSkillId(uint16 skillid)
{
	m_monsterSkillId = skillid;
}

uint8 CBlueSpell::getSetPoints()
{
	return m_setPoints;
}

void CBlueSpell::setSetPoints(uint8 setpoints)
{
	m_setPoints = setpoints;
}

uint8 CBlueSpell::getEcosystem()
{
	return m_ecosystem;
}

void CBlueSpell::setEcosystem(uint8 ecosystem)
{
	m_ecosystem = ecosystem;
}

uint8 CBlueSpell::getTraitCategory()
{
	return m_traitCategory;
}

void CBlueSpell::setTraitCategory(uint8 category)
{
	m_traitCategory = category;
}

uint8 CBlueSpell::getTraitWeight()
{
	return m_traitWeight;
}

void CBlueSpell::setTraitWeight(uint8 weight)
{
	m_traitWeight = weight;
}

uint8 CBlueSpell::getPrimarySkillchain()
{
    return m_PrimarySkillchain;
}

void CBlueSpell::setPrimarySkillchain(uint8 sc)
{
    m_PrimarySkillchain = sc;
}

uint8 CBlueSpell::getSecondarySkillchain()
{
    return m_SecondarySkillchain;
}

void CBlueSpell::setSecondarySkillchain(uint8 sc)
{
    m_SecondarySkillchain = sc;
}

void CBlueSpell::addModifier(CModifier modifier)
{
    modList.push_back(modifier);
}

void CBlueSpell::setKnockback(uint8 knockback)
{
    m_knockback = knockback;
}

uint8 CBlueSpell::getKnockback()
{
    return m_knockback;
}

void CBlueSpell::setPhysical(uint8 isPhysical)
{
    m_isPhysical = isPhysical;
}

bool CBlueSpell::isPhysical()
{
    return m_isPhysical;
}

bool CBlueSpell::isMagical()
{
    return !m_isPhysical;
}