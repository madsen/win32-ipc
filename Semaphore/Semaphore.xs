// Semaphore.xs
// XS file for the Semaphore IPC module extension Dec 1995

// Semaphore object creation layer.

#define WIN32_LEAN_AND_MEAN
#include <math.h>		// avoid VC-5.0 brainmelt
#include <windows.h>
#include "Semaphore.hpp"

#if defined(__cplusplus)
extern "C" {
#endif

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"


BOOL
Create( Semaphore* &cSm, LONG lInitial, LONG lMax, LPCSTR lpName )
{
    cSm =(Semaphore *) new Semaphore( lInitial, lMax, lpName );
    return( cSm != NULL );
}

BOOL
Open( Semaphore* &cSm,LPCSTR lpName )
{
    HANDLE hSemaphore;

    cSm = NULL;
    hSemaphore = OpenSemaphore( SEMAPHORE_ALL_ACCESS, TRUE,lpName);
    if ( hSemaphore != NULL)	
	cSm = (Semaphore *)new Semaphore(hSemaphore); 

    return( cSm != NULL );
}

#if defined(__cplusplus)
}
#endif

MODULE = Win32::Semaphore	PACKAGE = Win32::Semaphore

PROTOTYPES: DISABLE

BOOL
Create(cSm,initial,max,name)
    Semaphore *cSm = NO_INIT
    LONG initial
    LONG max
    LPCSTR name
CODE:
    RETVAL = Create(cSm, initial, max, name);
OUTPUT:
    cSm
    RETVAL

BOOL
Open(cSm,name)
    Semaphore *cSm = NO_INIT
    LPCSTR name
CODE:
    RETVAL = Open(cSm, name);
OUTPUT:
    cSm
    RETVAL


BOOL
Release(cSm,count,prevcount)
    Semaphore *cSm
    DWORD count
    DWORD prevcount = NO_INIT
CODE:
    RETVAL = cSm->Release(count, (long *)&prevcount);
OUTPUT:
    prevcount
    RETVAL


void
DESTROY(cSm)
    Semaphore *cSm
CODE:
    cSm->~Semaphore();


BOOL
Wait(cSm,timeout)
    Semaphore *cSm
    DWORD timeout
CODE:
    RETVAL = cSm->Wait(timeout);
OUTPUT:
    RETVAL

