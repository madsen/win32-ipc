// IPC module definition.

#include <stdlib.h>
#include <math.h>	// this to avoid VC-5.0 brainmelt
#include "IPC.hpp"
#define WIN32_LEAN_AND_MEAN
#include <windows.h>

#if defined(__cplusplus)
extern "C" {
#endif

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"


DWORD
WaitForMultiple(AV* hArray,BOOL fWaitAll,DWORD dwTimeOut)
{
    int	iNumberOfElements;
    SV *	svCurrSV;
    IV		tmp;
    Cipc *	CurrObj;
    HANDLE hHandle;
    HANDLE* aHandles;
    int	i=0;
    DWORD bRet;

    iNumberOfElements = av_len( hArray );
    if ( iNumberOfElements == -1 ) {
	warn("WaitforMultipleObjects: no objects to wait for");
	return( WAIT_FAILED );	
    }

    aHandles = new HANDLE[iNumberOfElements];

    // Create the array of handles for the WaitForMultipleObjects call
	
    for (i = 0; i < iNumberOfElements+1; i++) {
	svCurrSV = (SV *)(av_pop( hArray ));

	// Check if the object reference is valid

	if ( sv_isa(svCurrSV,"Win32::Process") ||
	     sv_isa(svCurrSV,"Win32::Mutex") ||
	     sv_isa(svCurrSV,"Win32::Semaphore") ||
	     sv_isa(svCurrSV,"Win32::ChangeNotification"))
	{
	    tmp = SvIV( (SV *)SvRV( svCurrSV));
	    CurrObj = (Cipc *)tmp;
	}
	else {			 
	    warn("WaitForMultipleObjects: Can only wait on Semaphore,mutex,ChangeNotification, or Process Objects");
	    return(WAIT_FAILED);
	}

	// exception handling seems to be the easiest way to check if the
	// object hasn't been trampled on.

	assert( CurrObj != NULL);

	try {
	    hHandle = CurrObj->MyHandle();

	    // Check if the hHandle has been changed.
	    if ( hHandle == 0 ) {
		warn("WaitForMultipleObjects: invalid object passed");
		return(WAIT_FAILED);
	    }
	    aHandles[i]=hHandle;
	}
	catch(...) {
	    warn("WaitForMultipleObjects: corrupt IPC handle");
	    return(WAIT_FAILED);
	}

	// Seems like we made it to here.
	// So lets wait for the objects.

    } // for loop

    bRet = WaitForMultipleObjects(iNumberOfElements + 1,
				  aHandles, fWaitAll, dwTimeOut);
    delete aHandles;
    return(bRet);
}

static double
constant(char* name,int arg)
{
    errno = 0;
    switch (*name) {
    case 'A':
	break;
    case 'B':
	break;
    case 'C':
	break;
    case 'D':
	break;
    case 'E':
	break;
    case 'F':
	break;
    case 'G':
	break;
    case 'H':
	break;
    case 'I':
	if (strEQ(name, "INFINITE"))
#ifdef INFINITE
	    return INFINITE;
#else
	    goto not_there;
#endif
	break;
    case 'J':
	break;
    case 'K':
	break;
    case 'L':
	break;
    case 'M':
	break;
    case 'N':
	break;
    case 'O':
	break;
    case 'P':
	break;
    case 'Q':
	break;
    case 'R':
	break;
    case 'S':
	break;
    case 'T':
	break;
    case 'U':
	break;
    case 'V':
	break;
    case 'W':
	break;
    case 'X':
	break;
    case 'Y':
	break;
    case 'Z':
	break;
    }
    errno = EINVAL;
    return 0;

not_there:
    errno = ENOENT;
    return 0;
}

#if defined(__cplusplus)
}
#endif

MODULE = Win32::IPC		PACKAGE = Win32::IPC

PROTOTYPES: DISABLE

double
constant(name,arg)
    char *name
    int   arg
CODE:
    RETVAL = constant(name, arg);
OUTPUT:
    RETVAL

BOOL
WaitForMultipleObjects(arrayref,waitall,timeout)
    SV *arrayref
    BOOL waitall
    DWORD timeout
CODE:
    DWORD 	ret;
    AV *	av;
    if (!(SvROK(arrayref) && (av = (AV*)SvRV(arrayref))
	  && SvTYPE(av) != SVt_PVAV))
	croak("First arg must be an array reference");

    ret = WaitForMultiple(av, waitall, timeout);
    RETVAL = ( ret != WAIT_FAILED ) && (ret != WAIT_TIMEOUT);
OUTPUT:
    RETVAL

