// ChangeNotify.xs
// XS file for the ChangeNotify IPC module

// ChangeNotify object creation layer.

#define WIN32_LEAN_AND_MEAN
#include <stdlib.h>
#include <math.h>
#include <windows.h>
#include "ChangeNotify.hpp"
#if defined(__cplusplus)
extern "C" {
#endif

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

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
	if (strEQ(name, "FILE_NOTIFY_CHANGE_ATTRIBUTES"))
#ifdef FILE_NOTIFY_CHANGE_ATTRIBUTES
	    return FILE_NOTIFY_CHANGE_ATTRIBUTES;
#else
	    goto not_there;
#endif
	if (strEQ(name, "FILE_NOTIFY_CHANGE_DIR_NAME"))
#ifdef FILE_NOTIFY_CHANGE_DIR_NAME
	    return FILE_NOTIFY_CHANGE_DIR_NAME;
#else
	    goto not_there;
#endif
	if (strEQ(name, "FILE_NOTIFY_CHANGE_FILE_NAME"))
#ifdef FILE_NOTIFY_CHANGE_FILE_NAME
	    return FILE_NOTIFY_CHANGE_FILE_NAME;
#else
	    goto not_there;
#endif
	if (strEQ(name, "FILE_NOTIFY_CHANGE_LAST_WRITE"))
#ifdef FILE_NOTIFY_CHANGE_LAST_WRITE
	    return FILE_NOTIFY_CHANGE_LAST_WRITE;
#else
	    goto not_there;
#endif
	if (strEQ(name, "FILE_NOTIFY_CHANGE_SECURITY"))
#ifdef FILE_NOTIFY_CHANGE_SECURITY
	    return FILE_NOTIFY_CHANGE_SECURITY;
#else
	    goto not_there;
#endif
	if (strEQ(name, "FILE_NOTIFY_CHANGE_SIZE"))
#ifdef FILE_NOTIFY_CHANGE_SIZE
	    return FILE_NOTIFY_CHANGE_SIZE;
#else
	    goto not_there;
#endif
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

BOOL
FindFirst( ChangeNotify* &cMu, LPCTSTR lpPathName, BOOL bWatchSubTree, DWORD dwFilter)
{
    cMu = NULL;
    cMu = (ChangeNotify *) new ChangeNotify( lpPathName, bWatchSubTree, dwFilter );
    if ( !cMu->RetVal ) {
	delete cMu;
	return( FALSE );
    }
    return( TRUE );

}


#if defined(__cplusplus)
}
#endif


MODULE = Win32::ChangeNotify	PACKAGE = Win32::ChangeNotify

PROTOTYPES: DISABLE

double
constant(name,arg)
    char *name
    int  arg
CODE:
    RETVAL = constant(name, arg);
OUTPUT:
    RETVAL


BOOL
FindFirst(cCN,path,watchsubtree,filter)
    ChangeNotify *cCN = NO_INIT
    LPCTSTR path
    BOOL watchsubtree
    DWORD filter
CODE:
    RETVAL = FindFirst(cCN, path, watchsubtree, filter);
OUTPUT:
    cCN
    RETVAL


BOOL
FindNext(cCN)
    ChangeNotify *cCN
CODE:
    RETVAL = cCN->FindNext();
OUTPUT:
    RETVAL


BOOL
Close(cCN)
    ChangeNotify *cCN
CODE:
    RETVAL = cCN->Close();
OUTPUT:
    RETVAL

void
DESTROY(cCN)
    ChangeNotify *cCN
CODE:
    cCN->~ChangeNotify();


BOOL
Wait(cCN,timeout)
    ChangeNotify *cCN
    DWORD timeout
CODE:
    RETVAL = cCN->Wait(timeout);
OUTPUT:
    RETVAL

