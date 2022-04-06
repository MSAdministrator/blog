---
title: "Scripting Clean Java Temporary Install Files From User Profiles Win 7 Xp"
date: 2018-08-07T20:42:48-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
So I had an issue awhile back that need to be rectified and the fix was to clean out temporary install files from the Sun/Java folder in User profiles.  This had to be done on about 700 machines, so I created this little script that cleans out these files and pushed it out to via AD.  I hope you enjoy.....



<blockquote><strong>Win 7 - Clean Java Temp Files</strong>
<code>
CD C:\
</code><code>
CLS
</code><code>
ECHO</code>
<code>
REM *** This DELETES temporary install files from the
REM *** SUN/JAVA folder in User Profiles.
REM *** Run this if you get a Pop-Up warning about your
REM *** User Profile being too large.
REM *** Click the corner [X
                    ] to exit without running.
REM *** Otherwise press the [Spacebar
                    ] to continue.
</code><code>
PAUSE
</code><code>
DEL "%USERPROFILE%\AppData\LocalLow\Sun\Java\*.*" /S /F /Q
</code><code>
RD "%USERPROFILE%\AppData\LocalLow\Sun\Java\" /S /Q
</code><code>
DEL "%USERPROFILE%\AppData\Local\Temp\*.*" /S /F /Q
</code><code>
RD "%USERPROFILE%\AppData\Local\Temp\" /S /Q
</code><code>
CLS
</code><code>
REM *** Folders are cleaned!
</code><code>
PAUSE
</code><code>
EXIT
</code></blockquote>



<blockquote><strong>Win XP - Clean Java Temp Files</strong>

<code>
CD C:\
</code><code>
CLS
</code><code>
ECHO
</code><code>
REM *** This script is for Windows XP only it will NOT work on Vista or 7
REM *** This DELETES temporary install files from the
REM *** SUN\JAVA and Local Settings\Temp folders in User Profiles.
REM *** Run this if you get a Pop-Up warning about your
REM *** User Profile being too large.
REM *** Click the corner [X
                    ] to exit without running.
REM *** Otherwise press the [Spacebar
                    ] to continue.
</code><code>
PAUSE
</code><code>
DEL "%SYSTEMDRIVE%\Documents and Settings\%USERNAME%\Application Data\Sun\Java\*.*" /S /F /Q
</code><code>
RD "%SYSTEMDRIVE%\Documents and Settings\%USERNAME%\Application Data\Sun\Java\" /S /Q
</code><code>
DEL "%SYSTEMDRIVE%\Documents and Settings\%USERNAME%\Local Settings\Temp\*.*" /S /F /Q
</code><code>
RMDIR "%SYSTEMDRIVE%\Documents and Settings\%USERNAME%\Local Settings\Temp\" /S /Q
</code><code>
CLS
</code><code>
REM *** Folders are cleaned!
</code><code>
PAUSE
</code><code>
EXIT
</code></blockquote>


