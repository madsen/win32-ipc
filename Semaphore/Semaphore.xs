//--------------------------------------------------------------------
// $Id: Semaphore/Semaphore.xs 78 2008-02-04 20:40:50 -0600 dubiously $
//--------------------------------------------------------------------
//
//   Win32::Semaphore
//   Copyright 1998 by Christopher J. Madsen
//
//   XS file for the Win32::Semaphore IPC module
//
//--------------------------------------------------------------------

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#define WIN32_LEAN_AND_MEAN
#include <windows.h>


MODULE = Win32::Semaphore	PACKAGE = Win32::Semaphore

PROTOTYPES: ENABLE

HANDLE
new(className, initial, max, name=NULL)
    char*  className
    LONG   initial
    LONG   max
    LPCSTR name
CODE:
    {
      SECURITY_ATTRIBUTES  sec;
      sec.nLength = sizeof(SECURITY_ATTRIBUTES);
      sec.bInheritHandle = TRUE;	// allow inheritance
      sec.lpSecurityDescriptor = NULL;  // calling processes' security
      RETVAL = CreateSemaphore(&sec, initial, max, name);
    }
    if (RETVAL == INVALID_HANDLE_VALUE)
      XSRETURN_UNDEF;
OUTPUT:
    RETVAL


HANDLE
open(className, name)
    char*  className
    LPCSTR name
CODE:
    RETVAL = OpenSemaphore(SEMAPHORE_ALL_ACCESS, TRUE, name);
    if (RETVAL == INVALID_HANDLE_VALUE)
      XSRETURN_UNDEF;
OUTPUT:
    RETVAL


void
DESTROY(semaphore)
    HANDLE semaphore
CODE:
    if (semaphore != INVALID_HANDLE_VALUE)
      CloseHandle(semaphore);


BOOL
release(semaphore,count=1,...)
    HANDLE semaphore
    LONG   count
PROTOTYPE: $$;$
CODE:
    {
      LONG prevcount;
      RETVAL = ReleaseSemaphore(semaphore, count, &prevcount);
      if (items > 2)
	sv_setiv(ST(2), (IV)prevcount);
    }
OUTPUT:
    RETVAL
