---
title: "Scripting Open Excel Sheets in Separate Windows"
date: 2018-08-07T20:42:51-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
If you work in an environment similar to my previous position, then you would know how often you hear certain complaints after upgrading people to new applications or Operating Systems. Well one of those complaints came from individuals that we upgraded to Office 2010. They were use to the option of opening up Excel Spreadsheets in separate windows, but in Office 2010 you can't do this by default you have to make a few tweaks. My fix was to create a little Batch script that would alter the Registry and allow this to be done. I hope you enjoy.....
<blockquote>Open Excel Sheets in Separate Windows
<code>
cd %~dp0
echo off
cls
</code><code>
ECHO ***** This batch script is not working. Please double-click on the REG
ECHO files themselves and answer Yes to pop-ups to manually set the new entries.
ECHO Click the [X
                    ] in the top-right corner to Exit.
</code><code>
pause
</code><code>
ECHO Close Excel if running... NO reboot is required by this script.
ECHO Pressing (Space) or another key will CHANGE Excel 2010 to open
ECHO files in separate windows. If you do NOT want this, click the close
ECHO [X
                    ] in the top-right Corner to close this window now.
ECHO Press [Space
                    } to continue and answer YES to any pop up messages...
</code><code>
Pause
</code><code>
regedit /s "del_HK_classes_root-excelsheet8-shell-open.reg"
regedit /s "hk-classes_root-excelsheet8_shell_open-newwinhack.reg"
regedit /s "del_HK_classes_root-excelsheet12-shell-open.reg"
regedit /s "hk-classes_root-excelsheet12_shell_open-newwinhack.reg"
</code><code>
pause
</code><code>
cls
</code><code>
ECHO Excel 2010 will now open files in separate windows. If this IS what
ECHO you want, click the [X
                    ] in top-right corner to close this window now.
ECHO Pressing (space) or other keys will RESET Excel 2010 to its original
ECHO single-window mode.
ECHO Answer YES to any pop up messages...
</code><code>
Pause
</code><code>
regedit /s "del_HK_classes_root-excelsheet8-shell-open.reg"
regedit /s "hk-classes_root-excelsheet8_shell_open-original.reg"
regedit /s "del_HK_classes_root-excelsheet12-shell-open.reg"
regedit /s "hk-classes_root-excelsheet12_shell_open-original.reg"
</code><code>
exit
</code></blockquote>
<a href="http://msadministrator.files.wordpress.com/2012/10/registry-entries-multi-window-excel-sheet.docx">Registry Entries - Multi Window Excel Sheet</a>
