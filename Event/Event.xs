//--------------------------------------------------------------------
// $Id: Event/Event.xs 18 2008-02-04 19:47:59 -0600 dubiously $
//--------------------------------------------------------------------
//
//   Win32::Event
//   Copyright 1998 by Christopher J. Madsen
//
//   XS file for the Win32::Event IPC module
//
//--------------------------------------------------------------------

#if defined(__cplusplus)
extern "C" {
#endif

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#if defined(__cplusplus)
}
#endif

#define WIN32_LEAN_AND_MEAN
#include <windows.h>


MODULE = Win32::Event		PACKAGE = Win32::Event

PROTOTYPES: ENABLE


HANDLE
new(className, manual=FALSE, initial=FALSE, name=NULL)
    char*  className
    BOOL   manual
    BOOL   initial
    LPCSTR name
PREINIT:
    SECURITY_ATTRIBUTES  sec;
CODE:
    sec.nLength = sizeof(SECURITY_ATTRIBUTES);
    sec.bInheritHandle = TRUE;        // allow inheritance
    sec.lpSecurityDescriptor = NULL;  // calling processes' security
    RETVAL = CreateEvent(&sec,manual,initial,name);
    if (RETVAL == INVALID_HANDLE_VALUE)
      XSRETURN_UNDEF;
OUTPUT:
    RETVAL


HANDLE
open(className, name)
    char*  className
    LPCSTR name
CODE:
    RETVAL = OpenEvent(EVENT_ALL_ACCESS, TRUE, name);
    if (RETVAL == INVALID_HANDLE_VALUE)
      XSRETURN_UNDEF;
OUTPUT:
    RETVAL


void
DESTROY(event)
    HANDLE event
CODE:
    if (sv_derived_from(ST(0), "Win32::Event") &&
        (event != INVALID_HANDLE_VALUE))
      CloseHandle(event);


BOOL
pulse(event)
    HANDLE event
CODE:
    RETVAL = PulseEvent(event);
OUTPUT:
    RETVAL


BOOL
reset(event)
    HANDLE event
CODE:
    RETVAL = ResetEvent(event);
OUTPUT:
    RETVAL


BOOL
set(event)
    HANDLE event
CODE:
    RETVAL = SetEvent(event);
OUTPUT:
    RETVAL
