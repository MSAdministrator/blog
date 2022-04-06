---
title: "Script Adding Exchange Resource Accounts to Your Outlook"
date: 2018-08-07T20:43:57-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
I work for a large public University and we have many Resource Accounts.  We needed a way to move from Public Folders but we wanted it to be seemless as possible.  To do this, I created this VBS script that allows anyone to add Resource Accounts to their Outlook 2013/2010 calendar as a shared calendar.  The user in question will have to run this script while Outlook is open and it will pull the Resource Account (add the Resource Account name in the RESOURCEACCOUNTNAME variable below) from the GAL and add it to the users calendar.  I hope this helps anyone interested in doing the same.

[code
                    ]

'**************************************************************************
' Script Name: ADDCALENDAR.vbs
' Version: 1.0
' Author: Josh Rickard
'Last Updated: 4.Nov.2013
' Purpose: This program is used to add Room Resource Calendars to
' someones Microsoft Office 2013 Shared Calendars group.
' Outlook 2013 has to be open for this script to continue.
' This script was originally created for the Trulaske
' University of REDACTED Technology Services Department.
' Legal: Script provided &quot;AS IS&quot; without warranties or guarantees
' of any kind. USE AT YOUR OWN RISK. Public domain.
'**************************************************************************
 Dim objApp
 Dim objNS
 Dim objFolder
 Dim strName(3)
 Dim objDummy
 Dim objRecip
 Dim calendar
 strName(0) = &quot;RESOURCEACCOUNTNAME&quot;
 strName(1) = &quot;RESOURCEACCOUNTNAME&quot;
 strName(2) = &quot;RESOURCEACCOUNTNAME&quot;
 strName(3) = &quot;RESOURCEACCOUNTNAME&quot;

Const olMailItem = 0
 Const olFolderCalendar = 9

&amp;nbsp;

' This section checks to see if Outlook 2013 is open. If it is not
' It will return &quot;Please Open Outlook and run this program again&quot;

'Change &quot;Outlook.Application.15&quot; to &quot;Outlook.Application.14&quot; for Outlook 2010
On Error Resume Next
Dim Outlook: Set Outlook = GetObject(, &quot;Outlook.Application.15&quot;)

If Err.Number = 0 Then
 MsgBox &quot;This program will add Room Calendars to your mailbox.&quot;
Else
 MsgBox &quot;Please Open Outlook and run this program again.&quot;
 Err.Clear
End If

&amp;nbsp;
' For Each Next Loop while adds each calendar from strName(array) to the users Shared Calendars

For Each calendar In strName

Set objApp = CreateObject(&quot;Outlook.Application.15&quot;)
 Set objNS = objApp.GetNamespace(&quot;MAPI&quot;)
 Set objFolder = Nothing

 Set objDummy = objApp.CreateItem(olMailItem)
 Set objRecip = objDummy.Recipients.Add(calendar)
 objRecip.Resolve
 If objRecip.Resolved = True Then
 On Error Resume Next
 Set objFolder = objNS.GetSharedDefaultFolder(objRecip, olFolderCalendar)
 On Error GoTo 0
 Else
 MsgBox &quot;Could not find &quot;,
                    , _
 &quot;User not found&quot;
 End If

 Next

 Set GetOtherUserCalendar = objFolder
 Set objApp = Nothing
 Set objNS = Nothing
 Set objFolder = Nothing

[/code
                    ]
