---
title: "Scripting Mount Printer at Startup Script"
date: 2018-08-07T20:42:35-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
So I had to come up with a batch script that would allow the user (in a lab) to select the printer that they wanted to use during that login session.  Pretty much this was placed in the startup folder on a few lab machines and every time someone would login (Deep Freeze Machines) it would ask them to select the printer that they wanted to print to.  It worked pretty well, I hope someone makes use of it.


<blockquote><code>REM /in = install network printer
REM /n = printer name
REM /y = sets as default
REM
REM Repeat Add printer commands as needed</code>
</code><code>
@ECHO OFF
CLS
:BEGIN
</code><code>
ECHO.
ECHO 1 = Printer 1 2 = Printer 2
ECHO.
Set /p choice="Choose the number of the default printer you desire"
ECHO.
ECHO.
ECHO.
IF not '%choice%'=='' set choice=%choice:~0,
                    1%
IF '%choice%'=='1' GOTO Printer1
IF '%choice%'=='2' GOTO Printer2
</code><code>
ECHO "%choice%" is not valid please try again
ECHO.
GOTO BEGIN
</code><code>
<code>: Printer1
ECHO Installing [BPrinter1
                    ] on [PrinterServer
                    ]!
RunDll32.EXE printui.dll,PrintUIEntry /in /n \\PrinterServer\Printer1
</code><code>
ECHO Your default printer is [Printer1
                    ] on [PrinterServer
                    ]
REM Set Default Printer
RunDll32.EXE printui.dll,PrintUIEntry /y /n \\PrinterServer\Printer1
GOTO END
</code><code>
: Printer2
ECHO Installing [Printer2
                    ] on [PrinterServer
                    ]!
RunDll32.EXE printui.dll,PrintUIEntry /in /n \\PrinterServer\Printer2
ECHO Your default printer is [Printer2
                    ] on [PrinterServer
                    ]!
REM Set Default Printer
RunDll32.EXE printui.dll,PrintUIEntry /y /n \\PrinterServer\Printer2
GOTO END
</code><code>
:END</code></blockquote>
