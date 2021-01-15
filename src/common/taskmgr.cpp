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

#include "../common/showmsg.h"
#include "../common/utils.h"
#include "../common/timer.h"
#include "../common/taskmgr.h"

CTaskMgr* CTaskMgr::_instance = nullptr;

CTaskMgr* CTaskMgr::getInstance()
{
	if( _instance == nullptr )
	{
		_instance = new CTaskMgr();
	}
	return _instance;
}

void CTaskMgr::delInstance()
{
    if(_instance)
    {
        delete _instance;
        _instance = nullptr;
    }
}

CTaskMgr::CTask *CTaskMgr::AddTask(std::string InitName, time_point InitTick, std::any InitData,TASKTYPE InitType,TaskFunc_t InitFunc,duration InitInterval)
{
	return AddTask( new CTask(InitName,InitTick,InitData,InitType,InitFunc,InitInterval) );
}

CTaskMgr::CTask *CTaskMgr::AddTask(CTask *PTask)
{
	m_TaskList.push(PTask);
	return PTask;
}

void CTaskMgr::RemoveTask(std::string TaskName) // this is very resource intensive, but it deletes all instances of the same-named tasks
{
    TaskList_t carbonCopy = m_TaskList;
    std::vector<CTask*> vectorCopy;

    while (!carbonCopy.empty())
    {
        if (carbonCopy.top()->m_name != TaskName)
        {
            vectorCopy.push_back(carbonCopy.top());
            //ShowDebug("Task passed through filter: %s\n", carbonCopy.top()->m_name);
        }
        else
        {
            //ShowDebug("Task blocked by filter: %s\n", carbonCopy.top()->m_name);
        }
        carbonCopy.pop();
    }

    while (!m_TaskList.empty())
        m_TaskList.pop();

    while (!vectorCopy.empty())
    {
        m_TaskList.push(vectorCopy.at(vectorCopy.size() - 1));
        //ShowDebug("Building new tasklist with task: %s\n", vectorCopy.at(vectorCopy.size() - 1)->m_name);
        vectorCopy.pop_back();
    }
}

duration CTaskMgr::DoTimer(time_point tick)
{
	duration diff = 1s;

	while( !m_TaskList.empty() )
	{
		CTask * PTask = m_TaskList.top();
		diff = PTask->m_tick - tick;

		if( diff > 0s ) break; // no more expired timers to process

		m_TaskList.pop();

		if( PTask->m_func )
		{
			PTask->m_func(( diff < -1s ? tick : PTask->m_tick),PTask);
		}

		switch( PTask->m_type )
		{
			case TASK_INTERVAL:
			{
				PTask->m_tick = PTask->m_interval + (diff < - 1s ? tick : PTask->m_tick);
				m_TaskList.push(PTask);
			}
				break;
			case TASK_ONCE:
			case TASK_REMOVE:
			default:
			{
				delete PTask; // suppose that all tasks were allocated by new
			}
				break;
		}
		diff = std::clamp<duration>(diff, 50ms, 1000ms);
	}
	return diff;
}
