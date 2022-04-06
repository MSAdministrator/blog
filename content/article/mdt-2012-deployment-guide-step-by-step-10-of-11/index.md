---
title: "Mdt 2012 Deployment Guide Step by Step 10 of 11"
date: 2018-08-07T20:43:34-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
<h1>Automating the Deployment Process</h1>
<ol>
	<li>Right-click on the deployment share and select <b><i>Properties</i></b></li>
</ol>
<p align="center"> <a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-10-of-11/attachment/36/" rel="attachment wp-att-122"><img class="alignnone size-full wp-image-122" alt="36" src="http://msadministrator.files.wordpress.com/2012/12/36.png" width="307" height="294" /></a></p>

<ol>
	<li>Select the “<b><i>Rules</i></b>” tab</li>
	<li>In the main window, edit the settings as required.  A sample CUSTOMSETTINGS.INI is below but feel free to change it as needed…</li>
	<li><a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-10-of-11/attachment/35/" rel="attachment wp-att-121"><img class="alignnone size-full wp-image-121" alt="35" src="http://msadministrator.files.wordpress.com/2012/12/351.png" width="519" height="431" /></a></li>
</ol>
<table cellspacing="0" cellpadding="0" align="left">
<tbody>
<tr>
<td width="54" height="0"></td>
</tr>
<tr>
<td></td>
<td></td>
</tr>
</tbody>
</table>
<b>CUSTOMSETTINGS.INI</b>
<table width="476" border="1" cellspacing="0" cellpadding="0">
<tbody>
<tr>
<td valign="top" width="203">[Settings]

Priority=Default

[Default
                    ]

_SMSTSORGNAME=Customer

SkipBDDWelcome=YES

SkipProductKey=YES

ProductKey= XXXX-XXXX-XXXXX-XXXXX

OverrideProductKey=XXXX-XXXX-XXXXX-XXXXX

SkipDeploymentType=YES

DeploymentType=NEWCOMPUTER

SkipDomainMembership=NO

JoinDomain=domain.com

DomainAdminDomain=domain.com

DomainAdmin=MDTAddComputer

DomainAdminPassword=Pa55w0rd

MachineObjectOU=ou=example,dc=domain,dc=com

OrgName=Customer

SkipUserData=YES

SkipTaskSequence=NO

TaskSequenceID=TASKSEQID

SkipPackageDisplay=YES

SkipLocaleSelection=NO

UILanguage=en-US

UserLocale=en-GB

KeyboardLocale=0809: 00000809

SystemLocale=en-US

SkipTimeZone=NO

TimeZoneName=GMT Standard Time

TimeZone=085

SkipBitLocker=YES

SkipSummary=YES

SkipCapture=YES

SkipAdminPassword=YES

SkipApplications=NO

SkipFinalSummary=NO

WsusServer=http: //wsus.domain.com

Home_page=http: //intranet.domain.com

FinishAction=SHUTDOWN</td>
<td valign="top" width="272">Sets the Company Name during the deployment

Skips unneeded wizard pages

Skips unneeded wizard pages

The Windows product key to use (only required if using MAK keys)

Sets the deployment type

Skip the domain membership screen

\

Credentials to use to join computers to the domain

/

Do not perform a user state migration

Do not ask which task sequence to run

Defautl to the task sequenceID you created earlier

Don’t display a list of possible OS packages to install Ask which regional settings to configure

Set the default UI language to English

Set the default user locale to GB English

Set the default keyboard to UK

Ask which time zone the computer is in

Set the default time zone to GMT

Set the default time zone to GMT (legacy support)

Skip the installation of BitLocker

Skip the Summary screen before deployment starts

Skip the “Build and Capture” options during deployment

Don’t ask for a local admin password for new PCs

Do not request local admin password during OS deployment

Pre-sets the admin password to the value specified

Allows you to set the local WSUS server for updates

Sets the default IE homepage for all users of new computers

Tells the computer to shut down once task sequence is completed</td>
</tr>
</tbody>
</table>
<b> </b>
<p align="left">If you want to specify the Timezone, Locale or other settings during the deployment, simply change the YES to a NO for the relevant option and you’ll be prompted during deployment.  These settings are injected automatically during deployment into the unattend.xml so you don’t have to worry about messing around with it usually.</p>
