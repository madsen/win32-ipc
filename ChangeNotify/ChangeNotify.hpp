#define WIN32_LEAN_AND_MEAN
#include <windows.h>
#include "IPC.hpp"
#include <stdio.h>


class ChangeNotify: public Cipc
{
    public:
	
	BOOL RetVal;

	ChangeNotify( LPCTSTR path, BOOL wsubtree, DWORD notifyfilt)
	    {
		HANDLE h;
		try {
		    h = FindFirstChangeNotification(path,wsubtree,notifyfilt);
		}
		catch (...) {
		    fprintf(stderr,
			"ChangeNotify: internal error, object not created\n");
		}
		RetVal = (h != INVALID_HANDLE_VALUE );
		SetHandle(h);
	    }
	ChangeNotify( HANDLE h )
	    { SetHandle( h ); }
	~ChangeNotify()
	    { CloseHandle( MyHandle() ); }
	BOOL Close()
	    { return FindCloseChangeNotification( MyHandle() ); }
	BOOL FindNext()
	    { return FindNextChangeNotification( MyHandle() ); }
};



