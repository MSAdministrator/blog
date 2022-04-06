---
title: "Mdt 2012 Deployment Guide Step by Step 1 of 11"
date: 2018-08-07T20:42:57-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
<h1>1.0    Deployment Infrastructure Overview</h1>
The new OS Deployment Infrastructure for the Configuration Centre is based around Microsoft Deployment Toolkit 2010 with Update 1.  MDT relies on a number of underlying software components and is able to deploy a number of different Operating Systems including Windows XP, Windows Vista and Windows 7 on the client side and Windows Server 2003,
                    2008 and 2008 R2 on the server side.  This document is focused on deployment of Windows 7 clients.

&nbsp;

The new Deployment Server should have the following software installed:

&nbsp;
<ul>
	<li>Microsoft Deployment Toolkit 2012 Update 1</li>
	<li>Windows Server 2008 SP2 with the following Roles and Features (Optional):
<ul>
	<li>Windows Deployment Services</li>
	<li>SQLServer 2008 Express Edition (Optional)</li>
	<li>Microsoft Windows 7 Automated Installation Kit (WAIK)
<ul>
	<li><a href="http://www.microsoft.com/download/en/details.aspx?id=5753">http://www.microsoft.com/download/en/details.aspx?id=5753</a></li>
</ul>
</li>
</ul>
</li>
</ul>
&nbsp;

This deployment server should be configured as part of an Active Directory domain.  A standard domain user account should be created and this will be used by the automated processes to access the shares on the MDT server.  The examples in this document use the domain contoso.local and any account that is able to join machines to the domain.  This is <b><i>not</i></b> best practice but the screenshots were taken from a standalone deployment environment.

&nbsp;

Since the introduction of Windows Vista (and continuing with Windows 7 and Server 2008 and 2008 R2), Windows operating systems have utilised a new imaging format known as Windows IMaging (WIM) which is deployed using Microsoft’s ImageX tool.  This WIM format is similar in some respects to the way Symantec Ghost’s GHO image files work.  The major difference is that a Windows OS Image utilising the WIM format is hardware-independent – meaning that a single image can be used for any hardware type (desktop, laptop or even server).

&nbsp;
<h2> 1.1       The Microsoft Deployment Toolkit Workbench</h2>
The core of the deployment solution is the MDT Deployment Workbench.  The following screenshot shows the main areas of the deployment workbench.

<a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-1-of-11/main/" rel="attachment wp-att-55"><img class="alignnone size-full wp-image-55" alt="main" src="http://msadministrator.files.wordpress.com/2012/12/main.png" width="519" height="312" /></a>

&nbsp;

&nbsp;

The main MDT screen is split into three main sections (labelled A, B and C above).  Section A shows a tree structure containing the various components of MDT, section B shows the main window and section C shows a list of context-sensitive tasks which can be performed depending on what is selected in the main window.

&nbsp;

As you will see in the screenshot above, there is a single “Deployment Share” which has been circled in red.

&nbsp;

The next section of this document will drill down into both the configuration and the common administrative tasks which may need to perform on an on-going basis.

&nbsp;

<b><br /> </b>
