Win32-IPC
=========

The Win32-IPC Perl modules provide access to the Win32 synchronization
objects, which are (currently) documented at
<http://msdn.microsoft.com/en-us/library/ms686364(VS.85).aspx>.

The supported synchronization objects and associated modules are:

* Event     - [Win32::Event](https://metacpan.org/pod/Win32::Event)
* Mutex     - [Win32::Mutex](https://metacpan.org/pod/Win32::Mutex)
* Semaphore - [Win32::Semaphore](https://metacpan.org/pod/Win32::Semaphore)

In addition, the
[Win32::ChangeNotify](https://metacpan.org/pod/Win32::ChangeNotify)
module provides access to directory change notifications, which let
you monitor a specified directory tree for file modifications.  While
not strictly a synchronization object, change notifications are often
used in similar ways.

This is a Git repository where development of Win32-IPC
takes place.  For more information, visit
[Win32-IPC on CPAN](https://metacpan.org/release/Win32-IPC).



Copyright and License
=====================

Copyright 1998&ndash;2008 Christopher J. Madsen

&nbsp;&nbsp;&nbsp;Created: 3 Feb 1998 from the ActiveWare version<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(c) 1995 Microsoft Corporation.
All rights reserved.<br>
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Developed
by ActiveWare Internet Corp., <http://www.ActiveState.com>

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;Other modifications
(c) 1997 by Gurusamy Sarathy <<gsar@cpan.org>>

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
