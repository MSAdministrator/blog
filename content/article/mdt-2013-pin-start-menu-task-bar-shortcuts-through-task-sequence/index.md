---
title: "Mdt 2013 Pin Start Menu Task Bar Shortcuts Through Task Sequence"
date: 2018-08-07T20:44:00-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
Below is how we stopped modifying the Start Menu &amp; Task Bar shortcuts on our Default Image (GOLD IMAGE) using MDT 2013 Task Sequence.  This applies to Windows 7 and I'm sure it could be modified to work with Windows 8.1.  Check it out below and let me know if you have any questions.

To do this, you are going to need the following scripts in a folder on your MDT 2013 Server.

Copy_To_Default_User_Startup.cmd

[code
                    ]
copy &quot;\\mdtserver01\DeploymentShare$\Applications\Set_TaskBar_&amp;amp;_StartMenu_Shortcuts\RunDefaultUserStartupScripts.vbs&quot; &quot;C:\Users\Default\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Startup&quot; /Y
copy &quot;\\mdtserver01\DeploymentShare$\Applications\Set_TaskBar_&amp;amp;_StartMenu_Shortcuts\SetTaskBar.vbs&quot; &quot;C:\Users\Public\Downloads&quot; /Y
copy &quot;\\mdtserver01\DeploymentShare$\Applications\Set_TaskBar_&amp;amp;_StartMenu_Shortcuts\PinStartMenuShortcuts.bat&quot; &quot;C:\Users\Public\Downloads&quot; /Y
copy &quot;\\mdtserver01\DeploymentShare$\Applications\Set_TaskBar_&amp;amp;_StartMenu_Shortcuts\PinItem.vbs&quot; &quot;C:\Users\Public\Downloads&quot; /Y
[/code
                    ]

RunDefaultUserStartupScript.vbs

[code
                    ]
'HideCMDWindow Script
CreateObject(&quot;Wscript.Shell&quot;).Run &quot;C:\Users\Public\Downloads\SetTaskBar.vbs&quot;,
                    0, True
CreateObject(&quot;Wscript.Shell&quot;).Run &quot;C:\Users\Public\Downloads\PinStartMenuShortcuts.bat&quot;,
                    0,
                    true
[/code
                    ]

SetTaskBar.vbs (I got this from somewhere online and modified it a bit, sorry I can't give credit where credit is due)

[code
                    ]
Option Explicit

Const CSIDL_COMMON_PROGRAMS = &amp;H17
Const CSIDL_PROGRAMS = &amp;H2
Const CSIDL_STARTMENU = &amp;HB

Dim objShell, objFSO
Dim objCurrentUserStartFolder
Dim strCurrentUserStartFolderPath
Dim objAllUsersProgramsFolder
Dim strAllUsersProgramsPath
Dim objFolder
Dim objFolderItem
Dim colVerbs
Dim objVerb

Set objShell = CreateObject(&quot;Shell.Application&quot;)
Set objFSO = CreateObject(&quot;Scripting.FileSystemObject&quot;)
Set objCurrentUserStartFolder = objShell.NameSpace (CSIDL_STARTMENU)
strCurrentUserStartFolderPath = objCurrentUserStartFolder.Self.Path
Set objAllUsersProgramsFolder = objShell.NameSpace(CSIDL_COMMON_PROGRAMS)
strAllUsersProgramsPath = objAllUsersProgramsFolder.Self.Path

' - Remove pinned items -

'Internet Explorer
If objFSO.FileExists(strCurrentUserStartFolderPath &amp; &quot;\Programs\Internet Explorer.lnk&quot;) Then
    Set objFolder = objShell.Namespace(strCurrentUserStartFolderPath &amp; &quot;\Programs&quot;)
    Set objFolderItem = objFolder.ParseName(&quot;Internet Explorer.lnk&quot;)
    Set colVerbs = objFolderItem.Verbs
    For Each objVerb in colVerbs
        If Replace(objVerb.name, &quot;&amp;&quot;, &quot;&quot;) = &quot;Unpin from Taskbar&quot; Then objVerb.DoIt
    Next
End If

'Windows Explorer
If objFSO.FileExists(strCurrentUserStartFolderPath &amp; &quot;\Programs\Accessories\Windows Explorer.lnk&quot;) Then
    Set objFolder = objShell.Namespace(strCurrentUserStartFolderPath &amp; &quot;\Programs\Accessories&quot;)
    Set objFolderItem = objFolder.ParseName(&quot;Windows Explorer.lnk&quot;)
    Set colVerbs = objFolderItem.Verbs
    For Each objVerb in colVerbs
        If Replace(objVerb.name, &quot;&amp;&quot;, &quot;&quot;) = &quot;Unpin from Taskbar&quot; Then objVerb.DoIt
    Next
End If
'Windows Media Player
If objFSO.FileExists(strAllUsersProgramsPath &amp; &quot;\Windows Media Player.lnk&quot;) Then
    Set objFolder = objShell.Namespace(strAllUsersProgramsPath)
    Set objFolderItem = objFolder.ParseName(&quot;Windows Media Player.lnk&quot;)
    Set colVerbs = objFolderItem.Verbs
    For Each objVerb in colVerbs
        If Replace(objVerb.name, &quot;&amp;&quot;, &quot;&quot;) = &quot;Unpin from Taskbar&quot; Then objVerb.DoIt
    Next
End If

' - Pin to Taskbar -

'Google Chrome C:\ProgramData\Microsoft\Windows\Start Menu\Programs\Google Chrome
If objFSO.FileExists(strAllUsersProgramsPath &amp; &quot;\Google Chrome\Google Chrome.lnk&quot;) Then
	Set objFolder = objShell.Namespace(strAllUsersProgramsPath &amp; &quot;\Google Chrome&quot;)
	Set objFolderItem = objFolder.ParseName(&quot;Google Chrome.lnk&quot;)
	Set colVerbs = objFolderItem.Verbs
	For Each objVerb in colVerbs
		If Replace(objVerb.name, &quot;&amp;&quot;, &quot;&quot;) = &quot;Pin to Taskbar&quot; Then objVerb.DoIt
	Next
End If

'Mozilla Firefox
If objFSO.FileExists(strAllUsersProgramsPath &amp; &quot;\Mozilla Firefox.lnk&quot;) Then
	Set objFolder = objShell.Namespace(strAllUsersProgramsPath)
	Set objFolderItem = objFolder.ParseName(&quot;Mozilla Firefox.lnk&quot;)
	Set colVerbs = objFolderItem.Verbs
	For Each objVerb in colVerbs
		If Replace(objVerb.name, &quot;&amp;&quot;, &quot;&quot;) = &quot;Pin to Taskbar&quot; Then objVerb.DoIt
	Next
End If

'Internet Explorer
If objFSO.FileExists(strCurrentUserStartFolderPath &amp; &quot;\Programs\Internet Explorer.lnk&quot;) Then
    Set objFolder = objShell.Namespace(strCurrentUserStartFolderPath &amp; &quot;\Programs&quot;)
    Set objFolderItem = objFolder.ParseName(&quot;Internet Explorer.lnk&quot;)
    Set colVerbs = objFolderItem.Verbs
    For Each objVerb in colVerbs
        If Replace(objVerb.name, &quot;&amp;&quot;, &quot;&quot;) = &quot;Pin to Taskbar&quot; Then objVerb.DoIt
    Next
End If

'Microsoft Outlook 2013
If objFSO.FileExists(strAllUsersProgramsPath &amp; &quot;\Microsoft Office 2013\Outlook 2013.lnk&quot;) Then
	Set objFolder = objShell.Namespace(strAllUsersProgramsPath &amp; &quot;\Microsoft Office 2013&quot;)
	Set objFolderItem = objFolder.ParseName(&quot;Outlook 2013.lnk&quot;)
	Set colVerbs = objFolderItem.Verbs
	For Each objVerb in colVerbs
		If Replace(objVerb.name, &quot;&amp;&quot;, &quot;&quot;) = &quot;Pin to Taskbar&quot; Then objVerb.DoIt
	Next
End If

'Microsoft Word 2013
If objFSO.FileExists(strAllUsersProgramsPath &amp; &quot;\Microsoft Office 2013\Word 2013.lnk&quot;) Then
	Set objFolder = objShell.Namespace(strAllUsersProgramsPath &amp; &quot;\Microsoft Office 2013&quot;)
	Set objFolderItem = objFolder.ParseName(&quot;Word 2013.lnk&quot;)
	Set colVerbs = objFolderItem.Verbs
	For Each objVerb in colVerbs
		If Replace(objVerb.name, &quot;&amp;&quot;, &quot;&quot;) = &quot;Pin to Taskbar&quot; Then objVerb.DoIt
	Next
End If

'Microsoft Excel 2013
If objFSO.FileExists(strAllUsersProgramsPath &amp; &quot;\Microsoft Office 2013\Excel 2013.lnk&quot;) Then
	Set objFolder = objShell.Namespace(strAllUsersProgramsPath &amp; &quot;\Microsoft Office 2013&quot;)
	Set objFolderItem = objFolder.ParseName(&quot;Excel 2013.lnk&quot;)
	Set colVerbs = objFolderItem.Verbs
	For Each objVerb in colVerbs
		If Replace(objVerb.name, &quot;&amp;&quot;, &quot;&quot;) = &quot;Pin to Taskbar&quot; Then objVerb.DoIt
	Next
End If

'Microsoft PowerPoint 2013
If objFSO.FileExists(strAllUsersProgramsPath &amp; &quot;\Microsoft Office 2013\PowerPoint 2013.lnk&quot;) Then
	Set objFolder = objShell.Namespace(strAllUsersProgramsPath &amp; &quot;\Microsoft Office 2013&quot;)
	Set objFolderItem = objFolder.ParseName(&quot;PowerPoint 2013.lnk&quot;)
	Set colVerbs = objFolderItem.Verbs
	For Each objVerb in colVerbs
		If Replace(objVerb.name, &quot;&amp;&quot;, &quot;&quot;) = &quot;Pin to Taskbar&quot; Then objVerb.DoIt
	Next
End If



'Delete the script
DeleteSelf

Sub DeleteSelf()       
        
End Sub
[/code
                    ]

PinStartMenuShortcuts.bat

[code
                    ]cscript C:\Users\Public\Downloads\PinItem.vbs /item:&quot;C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Outlook 2013.lnk&quot;
cscript C:\Users\Public\Downloads\PinItem.vbs /item:&quot;C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Mozilla Firefox.lnk&quot;
cscript C:\Users\Public\Downloads\PinItem.vbs /item:&quot;C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Excel 2013.lnk&quot;
cscript C:\Users\Public\Downloads\PinItem.vbs /item:&quot;C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\PowerPoint 2013.lnk&quot;
cscript C:\Users\Public\Downloads\PinItem.vbs /item:&quot;C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Word 2013.lnk&quot;
cscript C:\Users\Public\Downloads\PinItem.vbs /item:&quot;C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\Publisher 2013.lnk&quot;
cscript C:\Users\Public\Downloads\PinItem.vbs /item:&quot;C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Internet Explorer\Quick Launch\User Pinned\TaskBar\iTunes.lnk&quot;
[/code
                    ]

PinItem.vbs (same with this one, I can't remember where I found it but who ever they are, they are awesome!)

[code
                    ]' Windows Script Host Sample Script
'
' ------------------------------------------------------------------------
'               Copyright (C) 2009 Microsoft Corporation
'
' You have a royalty-free right to use, modify, reproduce and distribute
' the Sample Application Files (and/or any modified version) in any way
' you find useful, provided that you agree that Microsoft and the author
' have no warranty, obligations or liability for any Sample Application Files.
' ------------------------------------------------------------------------

'********************************************************************
'*
'* File:           PinItem.vbs
'* Date: 03/04/2009
'* Version: 1.0.2
'*
'* Main Function:  VBScipt to pin an item to the Start Menu or Taskbar
'*
'* Usage:  cscript PinItem.vbs /item:&lt;path to exe&gt;
'*                 [/taskbar
                    ] [/?
                    ]
'*
'* Copyright (C) 2009 Microsoft Corporation
'*
'* Revisions:
'*
'* 1.0.0 - 04/03/2008 - Created.
'* 1.0.1 - 03/02/2009 - Used Replace in PinItem function to remove &quot;&amp;&quot; 
'*                      from verb.
'* 1.0.2 - 03/04/2009 - Script name was PinToStartMenu.vbs.  Added 
'*                      /taskbar switch to pin items to taskbar on
'*                      Win7.
'*
'********************************************************************


'*****************************************************************************
'* Declare Variables
'*****************************************************************************

Option Explicit
'On Error Resume Next

Dim blnPinned
Dim blnTaskbar

Dim i
Dim intOpMode

Dim objWshShell
Dim objFSO
Dim objShell

Dim strPath
Dim strArguments
Dim strOptionsMessage

' Define constants
Const CONST_ERROR               = 0
Const CONST_WSCRIPT             = 1
Const CONST_CSCRIPT             = 2
Const CONST_SHOW_USAGE          = 3
Const CONST_PROCEED             = 4
Const CONST_STRING_NOT_FOUND    = -1
Const CONST_FOR_READING         = 1
Const CONST_FOR_WRITING         = 2
Const CONST_FOR_APPENDING       = 8
Const CONST_Success             = 0
Const CONST_Failure             = 1

Const TRISTATE_USE_DEFAULT      = -2
Const TRISTATE_TRUE             = -1  'Open the file as Unicode. 
Const TRISTATE_FALSE            = 0   'Open the file as ASCII. 

blnTaskbar = False

'*****************************************************************************
'* Create Objects
'*****************************************************************************

Set objWshShell = CreateObject(&quot;Wscript.Shell&quot;)
Set objFSO = CreateObject(&quot;Scripting.FileSystemObject&quot;)
Set objShell = CreateObject(&quot;Shell.Application&quot;)


'********************************************************************
'* Check script host exe and parse command line
'********************************************************************

'Get the command line arguments
For i = 0 to Wscript.arguments.count - 1
    ReDim Preserve arrArguments(i)
    arrArguments(i) = Wscript.arguments.item(i)
Next

'Check whether the script is run using CScript
Select Case intChkProgram()
    Case CONST_CSCRIPT
        'Do Nothing
    Case CONST_WSCRIPT
        WScript.Echo &quot;Please run this script using CScript.&quot; &amp; vbCRLF &amp; _
            &quot;This can be achieved by&quot; &amp; vbCRLF &amp; _
            &quot;1. Using &quot;&quot;CScript MODIFYUSERS.vbs arguments&quot;&quot; for Windows 95/98 or&quot; &amp; VbCrLf &amp; _
            &quot;2. Changing the default Windows Scripting Host setting to CScript&quot; &amp; vbCRLF &amp; _
            &quot;    using &quot;&quot;CScript //H:CScript //S&quot;&quot; and running the script using&quot; &amp; vbCRLF &amp; _
            &quot;    &quot;&quot;MODIFYUSERS.vbs arguments&quot;&quot; for Windows NT.&quot;
        WScript.Quit
    Case Else
        WScript.Quit
End Select

'Parse the command line
Err.Clear()
intOpMode = intParseCmdLine(arrArguments, strPath, blnTaskbar, strOptionsMessage)

If Err.Number Then
    Wscript.Echo &quot;Error 0X&quot; &amp; CStr(Hex(Err.Number)) &amp; &quot; occurred in parsing the command line.&quot;
    If Err.Description &lt;&gt; &quot;&quot; Then
        Wscript.Echo &quot;Error description: &quot; &amp; Err.Description &amp; &quot;.&quot;
    End If
    'WScript.quit
End If

Select Case intOpMode
    Case CONST_SHOW_USAGE
        Call ShowUsage()
        WScript.quit
    Case CONST_PROCEED
        'Do nothing.
    Case CONST_ERROR
        WScript.quit
    Case Else
        Wscript.Echo &quot;Error occurred in passing parameters.&quot;
End Select


'********************************************************************
'* Main Script
'********************************************************************

WScript.Echo strOptionsMessage

blnPinned = PinItem(strPath, blnTaskbar)
WScript.Echo &quot;Item pinned: &quot; &amp; CStr(blnPinned)

If blnPinned Then
    WScript.Quit(0)
Else
    WScript.Quit(1)
End If


'********************************************************************
'*
'* Function intChkProgram()
'*
'* Purpose:  Determines which program is used to run this script.
'*
'* Input:    None
'*
'* Returns:  intChkProgram is set to one of CONST_ERROR, CONST_WSCRIPT,
'*           and CONST_CSCRIPT.
'*
'********************************************************************
Private Function intChkProgram()

    ON ERROR RESUME NEXT

    Dim i
    Dim j
    Dim strFullName
    Dim strCommand

    'strFullName should be something like C:\WINDOWS\COMMAND\CSCRIPT.EXE
    strFullName = WScript.FullName
    If Err.Number then
        Wscript.Echo &quot;Error 0x&quot; &amp; CStr(Hex(Err.Number)) &amp; &quot; occurred.&quot;
        If Err.Description &lt;&gt; &quot;&quot; Then
            Wscript.Echo &quot;Error description: &quot; &amp; Err.Description &amp; &quot;.&quot;
        End If
        intChkProgram =  CONST_ERROR
        Exit Function
    End If

    i = InStr(1, strFullName, &quot;.exe&quot;,
                    1)
    If i = 0 Then
        intChkProgram =  CONST_ERROR
        Exit Function
    Else
        j = InStrRev(strFullName, &quot;\&quot;, i,
                    1)
        If j = 0 Then
            intChkProgram =  CONST_ERROR
            Exit Function
        Else
            strCommand = Mid(strFullName, j+1, i-j-1)
            Select Case LCase(strCommand)
                Case &quot;cscript&quot;
                    intChkProgram = CONST_CSCRIPT
                Case &quot;wscript&quot;
                    intChkProgram = CONST_WSCRIPT
                Case Else       'should never happen
                    Wscript.Echo &quot;An unexpected program is used to run this script.&quot;
                    Wscript.Echo &quot;Only CScript.Exe or WScript.Exe can be used to run this script.&quot;
                    intChkProgram = CONST_ERROR
            End Select
        End If
    End If

End Function


'********************************************************************
'*
'* Function intParseCmdLine()
'*
'* Purpose:  Parses the command line.
'*
'* Input:    arrArguments              An array containing input from the command line
'*
'* Input:    strPath                   Path of exe to pin
'*           strOptionsMessage         String containing options selected
'*
'* Returns:  intParseCmdLine is set to one of CONST_ERROR, CONST_SHOW_USAGE,
'*           and CONST_PROCEED.
'*
'********************************************************************
Private Function intParseCmdLine(arrArguments, strPath, blnTaskbar, strOptionsMessage)

    ON ERROR RESUME NEXT

    Dim i
    Dim strFlag
    Dim strSwitchValue
    
    strFlag = arrArguments(0)
    Err.Clear()

    'Help is needed
    If (strFlag = &quot;&quot;) OR (strFlag=&quot;help&quot;) OR (strFlag=&quot;/h&quot;) OR (strFlag=&quot;\h&quot;) OR (strFlag=&quot;-h&quot;) _
        OR (strFlag = &quot;\?&quot;) OR (strFlag = &quot;/?&quot;) OR (strFlag = &quot;?&quot;) OR (strFlag=&quot;h&quot;) Then
        intParseCmdLine = CONST_SHOW_USAGE
        Exit Function
    End If

    strOptionsMessage = strOptionsMessage &amp; &quot;&quot;  &amp; VbCrLf
    strOptionsMessage = strOptionsMessage &amp; WScript.ScriptName  &amp; VbCrLf
    strOptionsMessage = strOptionsMessage &amp; &quot;&quot;  &amp; VbCrLf
    strOptionsMessage = strOptionsMessage &amp; &quot;Command Line Options:&quot;  &amp; vbCrLf
    strOptionsMessage = strOptionsMessage &amp; &quot;=======================================&quot;  &amp; VbCrLf

    For i = 0 to UBound(arrArguments)
        strFlag = Left(arrArguments(i), InStr(1, arrArguments(i), &quot;:&quot;)-1)
        If Err.Number Then            'An error occurs if there is no : in the string
            Err.Clear
            Select Case LCase(arrArguments(i))
                Case &quot;/q&quot;
                    blnQuiet = True
                    strOptionsMessage = strOptionsMessage &amp; &quot;Supress Console Output: &quot; &amp; blnQuiet &amp; VbCrLf
                Case &quot;/taskbar&quot;
                    blnTaskbar = True
                    strOptionsMessage = strOptionsMessage &amp; &quot;Pin to Taskbar instead of Start Menu: &quot; &amp; blnTaskbar &amp; VbCrLf
                Case Else
                    Wscript.Echo arrArguments(i) &amp; &quot; is not recognized as a valid input.&quot;
                    intParseCmdLine = CONST_ERROR
                    Exit Function
            End Select
        Else
            strSwitchValue = Right(arrArguments(i), Len(arrArguments(i))-(Len(strFlag)+1))
            Select Case LCase(strFlag)
                Case &quot;/item&quot;
                    strPath = strSwitchValue
                    strOptionsMessage = strOptionsMessage &amp; &quot;Item to pin to Start Menu or Taskbar: &quot; &amp; strPath &amp; VbCrLf
                Case else
                    Wscript.Echo &quot;Invalid flag &quot; &amp; strFlag &amp; &quot;.&quot;
                    Wscript.Echo &quot;Please check the input and try again.&quot;
                    intParseCmdLine = CONST_ERROR
                    Exit Function
            End Select
        End If
    Next

    If (strPath = &quot;&quot;) Then
        Wscript.Echo &quot;The /item switch is required&quot;
        Wscript.Echo &quot;Please check the input and try again.&quot;
        intParseCmdLine = CONST_ERROR
        Exit Function
    End If

    intParseCmdLine = CONST_PROCEED

End Function


'********************************************************************
'*
'* Function PinItem()
'*
'* Purpose:  Pin item to the Start Menu.
'*
'* Input:          strlPath          Path of exe to pin
'*                 blnTaskbar        Pin item to Taskbar instead of Start Menu if true
'*
'* Dependencies:   objShell          Shell.Application object
'*                 objFSO            File System object
'*
'* Returns:        True if the shortcut is created, else false
'*
'********************************************************************
Function PinItem(strlPath, blnTaskbar)
    On Error Resume Next

    Dim colVerbs
    Dim itemverb
    
    Dim objFolder
    Dim objFolderItem

    Dim strFolder
    Dim strFile

    If objFSO.FileExists(strlPath) Then
        '***** Do nothing, folder exists
    Else
        '***** Folder does not exist
        PinItem = False
        WScript.Echo &quot;File to pin does not exist.&quot;
        WScript.Echo &quot;Please check the input and try again.&quot;
        Exit Function
    End If

    strFolder = objFSO.GetParentFolderName(strlPath)
    strFile = objFSO.GetFileName(strlPath)

    WScript.Echo &quot;Folder: &quot; &amp; strFolder
    WScript.Echo &quot;File: &quot; &amp; strFile

    Err.Clear
    Set objFolder = objShell.Namespace(strFolder)
    Set objFolderItem = objFolder.ParseName(strFile)

    ' ***** InvokeVerb for this does not work on Vista/WS2008
    'objFolderItem.InvokeVerb(&quot;P&amp;in to Start Menu&quot;)

    ' ***** This code works on Vista/WS2008
    Set colVerbs = objFolderItem.Verbs

    If blnTaskbar Then
        For each itemverb in objFolderItem.verbs
            If Replace(itemverb.name, &quot;&amp;&quot;, &quot;&quot;) = &quot;Pin to Taskbar&quot; Then itemverb.DoIt
        Next 
    Else
        For each itemverb in objFolderItem.verbs
            If Replace(itemverb.name, &quot;&amp;&quot;, &quot;&quot;) = &quot;Pin to Start Menu&quot; Then itemverb.DoIt
        Next 
    End If

    If Err.Number = 0 Then
        PinItem = True
    Else
        PinItem = False
    End If
End Function


'********************************************************************
'*
'* Sub ShowUsage()
'*
'* Purpose:   Shows the correct usage to the user.
'*
'* Input:     None
'*
'* Output:    Help messages are displayed on screen.
'*
'********************************************************************
Sub ShowUsage()
    WScript.Echo &quot;This script is used to Pin items to the Start Menu or Taskbar.&quot;
    WScript.Echo &quot;&quot;
    WScript.Echo &quot;Usage: cscript &quot; &amp; WScript.ScriptName &amp; &quot; [options
                    ]&quot;
    WScript.Echo &quot;&quot;
    WScript.Echo &quot;Options:&quot;
    WScript.Echo &quot;&quot;
    WScript.Echo &quot; /item:&lt;PathName&gt;       Path of item to pin.&quot;
    WScript.Echo &quot;&quot;
    WScript.Echo &quot; /taskbar               (Optional) Pin to Taskbar instead of Start Menu.&quot;
    WScript.Echo &quot;&quot;
    WScript.Echo &quot; /?                     (Optional) Displays this help text.&quot;
    WScript.Echo &quot;&quot;
    WScript.Echo &quot;&quot;
    WScript.Echo &quot;&quot;
End Sub
[/code
                    ]

&nbsp;

MDT 2013:

On your MDT 2013 DeploymentShare$, add an application by right clicking the "Applications" node and selecting "New Application"

<a href="http://msadministrator.files.wordpress.com/2014/03/mdt2013_new_application_1.png"><img id="i-191" class="size-full wp-image" src="http://msadministrator.files.wordpress.com/2014/03/mdt2013_new_application_1.png?w=250" alt="Image" /></a>

In the new dialogue box, select "Application without source files or elsewhere on the network" radius button.

<a href="http://msadministrator.files.wordpress.com/2014/03/mdt2013_new_application_2.png"><img id="i-195" class="size-full wp-image" src="http://msadministrator.files.wordpress.com/2014/03/mdt2013_new_application_2.png?w=650" alt="Image" /></a>

Select Next and fill out the information as you would like it to appear (I choose to name my Application as <strong>"Set_TaskBar_&amp;_StartMenu_Shortcuts"</strong> but it's up to you.  If you use something else, then change the first script above accordingly)

Select Next, then in the Command Line field type "Copy_To_Default_User_Startup.cmd"

In the "Working directory" field, type: ".\Applications\Set_TaskBar_&amp;_StartMenu_Shortcuts"

<a href="http://msadministrator.files.wordpress.com/2014/03/mdt2013_new_application_3.png"><img id="i-214" class="size-full wp-image" src="http://msadministrator.files.wordpress.com/2014/03/mdt2013_new_application_3.png?w=560" alt="Image" /></a>

Select Next, then Finish.

Now, right click your newly created application and select properties

Select the check box on the bottom left hand corner of the "General" tab that says "Hide this application in the Deployment Wizard"

Next, add all the scripts above to your %DeployRoot%\Applications\Set_TaskBar_&amp;_StartMenu_Shortcuts folder.

After adding the scripts to this folder, go back to the Deployment Workbench and right click your Task Sequence for Windows 7 and select Properties

Under the State Restore section of the Task Sequence, add a "Custom Task" after your "Install Applications" item in the Task Sequence.

You can add the "Custom Task" in many different ways but I like to create a "New Group" after either my "Install Applications" or "Windows Update (Post-Application Installation)":  Please see below:

<a href="http://msadministrator.files.wordpress.com/2014/03/mdt2013_new_application_4.png"><img id="i-225" class="size-full wp-image" src="http://msadministrator.files.wordpress.com/2014/03/mdt2013_new_application_4.png?w=227" alt="Image" /></a>

After creating the "New Group" you can name it anything but I choose to name mine as "Custom Task".

Next, you need to add the application to your Task Sequence by selecting the "New Group" and clicking on Add-&gt;General-&gt;Install Application.

Configure your new Application as the screenshot

<a href="http://msadministrator.files.wordpress.com/2014/03/mdt2013_new_application_5.png"><img class="alignnone size-full wp-image-230" src="http://msadministrator.files.wordpress.com/2014/03/mdt2013_new_application_5.png" alt="MDT2013_New_Application_5" width="405" height="516" /></a>

Press Apply, then Ok.

When ever I make changes to my DeploymentShare I always update my Deployment Share for safe measures.  It's also because I never want to forgot to do it when I really need too.

You should now have a new application that will set the Task Bar and your Start Menu Shortcuts without having to set them in your base image.

&nbsp;

Enjoy!

p.s. I know there is probably a better way of organizing these scripts but in a pinch they worked and I haven't gone back to look at other ways of doing it.
