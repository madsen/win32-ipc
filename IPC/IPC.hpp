
// IPC class for interprocess communications.

#define WIN32_LEAN_AND_MEAN
#include <windows.h>

class Cipc
{
    private:

	HANDLE	hHandle;

    public:
	
	Cipc()
	    { hHandle = 0; }
	void SetHandle( HANDLE hH )
	    { hHandle = hH; }
	HANDLE MyHandle()
	    { return hHandle; }
	DWORD Wait( DWORD TimeOut )
	    { return WaitForSingleObject(hHandle,TimeOut); }

};
