#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include "IPC.hpp"
#include <stdio.h>


class Mutex: public Cipc
{

    public:
	
	Mutex(BOOL initial, LPCTSTR name)
	    {
		HANDLE hMut;
		SECURITY_ATTRIBUTES		sec;
	
		sec.nLength = sizeof( SECURITY_ATTRIBUTES );
		sec.bInheritHandle = TRUE;	// allow inheritance
		sec.lpSecurityDescriptor = NULL;// calling processes' security
		try {
		    hMut = CreateMutex( &sec,initial,name);
		}
		catch (...) {
		    fprintf(stderr,
			"Mutex: internal error, object not created\n");
		}
		SetHandle( hMut );
	    }
	Mutex( HANDLE hMut )
	    { SetHandle( hMut ); }
	~Mutex()
	    { CloseHandle( MyHandle() ); }
	BOOL Release()
	    { return ReleaseMutex( MyHandle() ); }
};



