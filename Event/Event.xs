//--------------------------------------------------------------------
// $Id: Event/Event.xs 119 2008-02-05 03:46:28 -0600 dubiously $
//--------------------------------------------------------------------
//
//   Win32::Event
//   Copyright 1998 by Christopher J. Madsen
//
//   XS file for the Win32::Event IPC module
//
//--------------------------------------------------------------------

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#include "../ppport.h"

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
    if (name && USING_WIDE()) {
	WCHAR wbuffer[MAX_PATH+1];
	A2WHELPER(name, wbuffer, sizeof(wbuffer));
	RETVAL = CreateEventW(&sec,manual,initial,wbuffer);
    }
    else {
	RETVAL = CreateEventA(&sec,manual,initial,name);
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
    if (USING_WIDE()) {
	WCHAR wbuffer[MAX_PATH+1];
	A2WHELPER(name, wbuffer, sizeof(wbuffer));
	RETVAL = OpenEventW(EVENT_ALL_ACCESS, TRUE, wbuffer);
    }
    else {
	RETVAL = OpenEventA(EVENT_ALL_ACCESS, TRUE, name);
    }
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
