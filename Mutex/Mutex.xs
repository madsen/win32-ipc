// Mutex.xs
// XS file for the Mutex IPC module extension

// Mutex object creation layer.

#define WIN32_LEAN_AND_MEAN
#include <math.h>		// avoid VC-5.0 brainmelt
#include <windows.h>
#include "Mutex.hpp"

#if defined(__cplusplus)
extern "C" {
#endif

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"


BOOL
Create( Mutex* &cMu, BOOL bInitial, LPCTSTR lpName)
{
	cMu =(Mutex *) new Mutex( bInitial, lpName );
	return( cMu != NULL );

}

BOOL
Open( Mutex* &cMu,LPCSTR lpName )
{
	HANDLE hMutex;

	cMu = NULL;

	// note: the mutex is inheritable.

	hMutex = OpenMutex( MUTEX_ALL_ACCESS, TRUE,lpName);

	
	if( hMutex != NULL)	
		cMu = (Mutex *)new Mutex(hMutex); 

	return( cMu != NULL );
}
 
#if defined(__cplusplus)
}
#endif

MODULE = Win32::Mutex		PACKAGE = Win32::Mutex

PROTOTYPES: DISABLE


BOOL
Create(cMu, initial, name)
    Mutex *cMu = NO_INIT
    BOOL initial
    LPCTSTR name
CODE:
    RETVAL = Create(cMu, initial, name);
OUTPUT:
    cMu
    RETVAL


BOOL
Open(cMu, name)
    Mutex *cMu = NO_INIT
    LPCSTR name
CODE:
    RETVAL = Open(cMu, name);
OUTPUT:
    cMu
    RETVAL


BOOL
Release(cMu)
    Mutex *cMu
CODE:
    RETVAL = cMu->Release();
OUTPUT:
    RETVAL


void
DESTROY(cMu)
    Mutex *cMu
CODE:
   cMu->~Mutex();


BOOL
Wait(cMu,timeout)
    Mutex *cMu
    DWORD timeout
CODE:
    RETVAL = cMu->Wait(timeout);
OUTPUT:
    RETVAL

