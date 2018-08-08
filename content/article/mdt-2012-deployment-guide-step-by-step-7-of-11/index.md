---
title: "Mdt 2012 Deployment Guide Step by Step 7 of 11"
date: 2018-08-07T20:43:27-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
<h1>            Capturing a Windows 7 Image from a reference PC</h1>
The reference computer should be connected to the same network as the MDT Deployment server and should be set to get an IP address via DHCP.

&nbsp;

<b>THE REFERENCE COMPUTER MUST NOT BE JOINED TO ANY DOMAIN!</b>

&nbsp;
<ol>
	<li>Boot the reference computer and ensure network connectivity</li>
	<li>Make any last-minute modifications (additional software, Windows Updates, etc.)</li>
	<li>Click <b><i>Start</i></b> and type <b><i>\\&lt;MDTSERVER&gt;\share$\scripts\litetouch.vbs </i></b>and press Enter
<ol>
	<li>If prompted for credentials, enter a domain account with access to that share:</li>
	<li>If prompted with a Security Warning like the one below, click <b><i>Open</i></b></li>
	<li><a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-7-of-11/attachment/21/" rel="attachment wp-att-96"><img class="alignnone size-full wp-image-96" alt="21" src="http://msadministrator.files.wordpress.com/2012/12/21.png" width="409" height="290" /></a></li>
</ol>
</li>
</ol>
<ol>
	<li>Select <b><i>Sysprep &amp; Capture Win7 Reference Image </i></b>from the Task Sequence selection screen</li>
	<li><a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-7-of-11/attachment/22/" rel="attachment wp-att-97"><img class="alignnone size-full wp-image-97" alt="22" src="http://msadministrator.files.wordpress.com/2012/12/22.png" width="456" height="325" /></a></li>
</ol>
<ol>
	<li>Select <b><i>Capture an image of this reference computer </i></b>from the Capture an Image selection screen and enter an appropriate file name.</li>
	<li><a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-7-of-11/attachment/23/" rel="attachment wp-att-98"><img class="alignnone size-full wp-image-98" alt="23" src="http://msadministrator.files.wordpress.com/2012/12/23.png" width="519" height="370" /></a></li>
</ol>
<ol>
	<li>Wait while the Windows PE environment is copied to the reference computer and SYSPREP is run</li>
</ol>
<p align="left"> <a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-7-of-11/attachment/24/" rel="attachment wp-att-99"><img class="alignnone size-full wp-image-99" alt="24" src="http://msadministrator.files.wordpress.com/2012/12/24.png" width="519" height="389" /></a></p>

<ol>
	<li>Once SYSPREP has completed, the computer will automatically reboot into a Windows PE environment and the image will be captured to the server.  This capture process may take some time depending on the size of the image.</li>
</ol>
<p align="left"></p>
