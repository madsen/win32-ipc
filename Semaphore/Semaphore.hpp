#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include "IPC.hpp"
#include <stdio.h>


class Semaphore: public Cipc
{
    public:
	
	Semaphore( LONG linitialCount,LONG lMaximumCount,LPCTSTR lpName )
	    {
		HANDLE			hSem;
		SECURITY_ATTRIBUTES	sec;

		sec.nLength = sizeof( SECURITY_ATTRIBUTES );
		sec.bInheritHandle = TRUE;   // allow inheritance
		sec.lpSecurityDescriptor = NULL;// caller's security
		try {
		    hSem = CreateSemaphore( &sec,linitialCount,
					    lMaximumCount,lpName);
		}
		catch (...) {
		    fprintf(stderr,
			"Semaphore: internal error, object not created\n");
		}
		SetHandle( hSem );
	    }
	Semaphore( HANDLE hSem )
	    { SetHandle( hSem ); }
	~Semaphore()
	    { CloseHandle( MyHandle() ); }
	BOOL Release( LONG count, LONG* prevcount )
	    { return ReleaseSemaphore(MyHandle(),count,prevcount); }
};



