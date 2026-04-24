---
title: "Mdt 2013 Installing Adk for 8 1"
date: 2018-08-07T20:44:06-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
Once you have all of the <a title="MDT 2013: Setting up MDT 2013 with ADK for Windows 7, 8, &amp; 8.1" href="http://msadministrator.com/2014/03/27/mdt-2013-setting-up-mdt-2013-with-adk-for-windows-7-8-8-1/">necessary files</a> downloaded and saved on your Windows Server 2012 R2 box, then begin by installing the "adksetup.exe".

The first screen that should pop-up is this one:

<a href="http://msadministrator.files.wordpress.com/2014/03/adk_1.png"><img class="alignnone size-full wp-image-254" src="http://msadministrator.files.wordpress.com/2014/03/adk_1.png" alt="ADK_1" width="396" height="298" /></a>

The Following Screenshots are all based on your own needs but these are the options that I have chosen for this setup:

I choose to download the ADK instead of installing it.  The reason I do this is because I like to keep a backup of the original file, just in case the server crashes or something else happens.

Click Next

<a href="http://msadministrator.files.wordpress.com/2014/03/adk_2.png"><img class="alignnone size-full wp-image-255" src="http://msadministrator.files.wordpress.com/2014/03/adk_2.png" alt="ADK_2" width="620" height="454" /></a>

I typically choose to not accept the CEIP, mostly because it adds a little database file in AppData that i've seen become corrupt and cause log in issues. If you choose to, it should be fine.

Click Next

<a href="http://msadministrator.files.wordpress.com/2014/03/adk_3.png"><img class="alignnone size-full wp-image-256" src="http://msadministrator.files.wordpress.com/2014/03/adk_3.png" alt="ADK_3" width="620" height="454" /></a>

Wait until the adksetup has been downloaded then proceed to the location that you save it to.

<a href="http://msadministrator.files.wordpress.com/2014/03/adk_5.png"><img class="alignnone size-full wp-image-258" src="http://msadministrator.files.wordpress.com/2014/03/adk_5.png" alt="ADK_5" width="620" height="453" /></a>

Click Close and then run the downloaded ADK

<a href="http://msadministrator.files.wordpress.com/2014/03/adk_6.png"><img class="alignnone size-full wp-image-259" src="http://msadministrator.files.wordpress.com/2014/03/adk_6.png" alt="ADK_6" width="620" height="455" /></a>

Specify the location that you want to install the ADK files.  I personally like to store them on a separate drive than the OS but it's up to you.

Click Next

<a href="http://msadministrator.files.wordpress.com/2014/03/adk_7.png"><img class="alignnone size-full wp-image-260" src="http://msadministrator.files.wordpress.com/2014/03/adk_7.png" alt="ADK_7" width="620" height="455" /></a>

Click Accept

<a href="http://msadministrator.files.wordpress.com/2014/03/adk_9.png"><img class="alignnone size-full wp-image-262" src="http://msadministrator.files.wordpress.com/2014/03/adk_9.png" alt="ADK_9" width="620" height="455" /></a>


Again, it's up to you but I always select No.

Click Next

<a href="http://msadministrator.files.wordpress.com/2014/03/adk_8.png"><img class="alignnone size-full wp-image-261" src="http://msadministrator.files.wordpress.com/2014/03/adk_8.png" alt="ADK_8" width="620" height="454" /></a>


Below are the features that I install but you could install all of them.  Here is why I choose why I install the following.

Deployment Tools:  You need to install Deployment Tools as this holds DISM and other tools that are needed by MDT

Windows PE: You need to install this for MDT to work

USMT: This is User State Migration Toolkit.  Think of this as a tool to migrate user data (Migwiz)

SQL Server: I mostly install this because you can use it to setup a backed database for MDT, it's not necessary unless you plan on using it.

Click Install

<a href="http://msadministrator.files.wordpress.com/2014/03/adk_10.png"><img class="alignnone size-full wp-image-263" src="http://msadministrator.files.wordpress.com/2014/03/adk_10.png" alt="ADK_10" width="620" height="458" /></a>


Once the installation is complete, click Close

<a href="http://msadministrator.files.wordpress.com/2014/03/adk_11.png"><img class="alignnone size-full wp-image-264" src="http://msadministrator.files.wordpress.com/2014/03/adk_11.png" alt="ADK_11" width="620" height="456" /></a>


Congratulations, you've installed ADK on your Windows Server 2012 R2 box.  Next we will install MDT 2013.

Enjoy!

