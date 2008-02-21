//--------------------------------------------------------------------
// $Id: lib/Win32/Mutex.xs 240 2008-02-21 12:09:49 -0600 cmadsn $
//--------------------------------------------------------------------
//
//   Win32::Mutex
//   Copyright 1998 by Christopher J. Madsen
//
//   XS file for the Win32::Mutex IPC module
//
//--------------------------------------------------------------------

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

/* #include "ppport.h" */

#define WIN32_LEAN_AND_MEAN
#include <windows.h>

typedef bool TRUEFALSE;

MODULE = Win32::Mutex		PACKAGE = Win32::Mutex

PROTOTYPES: ENABLE


HANDLE
new(className, initial=FALSE, name=NULL)
    char*      className
    TRUEFALSE  initial
    LPCSTR     name
PREINIT:
      SECURITY_ATTRIBUTES  sec;
CODE:
    sec.nLength = sizeof(SECURITY_ATTRIBUTES);
    sec.bInheritHandle = TRUE;        // allow inheritance
    sec.lpSecurityDescriptor = NULL;  // calling processes' security
    RETVAL = CreateMutexA(&sec,initial,name);
    if (RETVAL == INVALID_HANDLE_VALUE)
      XSRETURN_UNDEF;
OUTPUT:
    RETVAL


HANDLE
open(className, name)
    char*  className
    LPCSTR name
CODE:
    RETVAL = OpenMutexA(MUTEX_ALL_ACCESS, TRUE, name);
    if (RETVAL == INVALID_HANDLE_VALUE)
      XSRETURN_UNDEF;
OUTPUT:
    RETVAL


void
DESTROY(mutex)
    HANDLE mutex
CODE:
    if (mutex != INVALID_HANDLE_VALUE)
      CloseHandle(mutex);


BOOL
release(mutex)
    HANDLE mutex
CODE:
    RETVAL = ReleaseMutex(mutex);
OUTPUT:
    RETVAL
