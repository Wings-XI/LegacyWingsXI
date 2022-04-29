/**
 *	@file LoginServer.h
 *	Easy threading interface
 *	@author Twilight
 *	@copyright 2020, all rights reserved. Licensed under GPLv3
 */

#ifndef FFXI_COMMON_THREAD_H
#define FFXI_COMMON_THREAD_H

#include <memory>
#include <thread>

/**
 *  Abstrace thread interface. Dervice a class from this
 *  interface to implement thread objects.
 */
class Thread
{
public:

    /**
     *  Constructor
     */
    Thread();

    /**
     *  Destructor
     */
    virtual ~Thread();

    /**
     *	Run the thread and suntil Shutdown() is called. Can be called directly
     *  if there's a need to run the function without a separate thread.
     *  The function should be listening to the mbShutdown flag and set the
     *  mbRunning flag in order for Shutdown() to work.
     */
    virtual void Run() = 0;

    /**
     *  Returns whether the thread is currently running.
     *  @return True if currently running, false otherwise.
     */
    virtual bool IsRunning() const;

    /**
     *  Returns whether the thread has finished execution.
     *  @return True if thread routine has ended.
     */
    virtual bool IsFinished() const;

    /**
     *  Start the thread. You should generally call this
     *  instead of run.
     */
    virtual void StartThread();

    /**
     *	Shut down the thread.
     */
    virtual void Shutdown(bool bJoin = true);

protected:

    /// Shutdown flag
    bool mbShutdown;
    /// Whether server is currently running
    bool mbRunning;
    /// Whether the thread has finished execution
    bool mbFinished;
    /// Associated thread object
    std::shared_ptr<std::thread> mpThreadObj;

    /**
     *  Static wrapper to Run, in order to allow it to run from std::thread
     *  @param thisobj Needs to point to an already initializaed instance of this class.
     */
    static void stRun(Thread* thisobj);
};

#endif
