---
title: "Mdt 2012 Deployment Guide Step by Step 2 of 11"
date: 2018-08-07T20:43:01-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
<h1>2.1       Creating an MDT Deployment Share</h1>
An MDT Deployment Share is the specific deployment environment which will be used for OS deployment.  The share contains all elements of the deployment including drivers, applications, OS images etc.
<ol>
	<li>Log on to the MDT server and open the “<b><i>Deployment Workbench</i></b>”</li>
	<li>Right-click on “<b><i>Deployment Shares” </i></b>in the left pane of the workbench and select <b><i>New Deployment Share</i></b></li>
</ol>
<p align="center"><a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-2-of-11/attachment/2/" rel="attachment wp-att-60"><img class="alignnone size-full wp-image-60" alt="2" src="http://msadministrator.files.wordpress.com/2012/12/2.png" width="323" height="294" /></a></p>

<ol>
	<li>In the New Deployment Share Wizard, choose a location for the new share.   Once you’ve selected a folder, click <b>Next</b></li>
</ol>
<a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-2-of-11/attachment/3/" rel="attachment wp-att-61"><img class="alignnone size-full wp-image-61" alt="3" src="http://msadministrator.files.wordpress.com/2012/12/3.png" width="519" height="401" /></a>
<ol>
	<li>Give the share a name – the name used previously should be fine.  Click <b>Next</b></li>
	<li><a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-2-of-11/attachment/4/" rel="attachment wp-att-62"><img class="alignnone size-full wp-image-62" alt="4" src="http://msadministrator.files.wordpress.com/2012/12/4.png" width="519" height="395" /></a></li>
</ol>
<ol>
	<li>Enter a descriptive name for the share (“<i>NewCustomer Deployment Share</i>” for instance) and click <b>Next</b></li>
	<li>Uncheck the next three options - Allow Image Capture, Allow Admin Password and Allow Product Key – click <b>Next</b> after each</li>
</ol>
<a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-2-of-11/attachment/5/" rel="attachment wp-att-63"><img class="alignnone size-full wp-image-63" alt="5" src="http://msadministrator.files.wordpress.com/2012/12/5.png" width="519" height="397" /></a>
<ol>
	<li>The Summary screen should look similar to the one below.  Click <b>Next</b></li>
	<li><a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-2-of-11/attachment/6/" rel="attachment wp-att-64"><img class="alignnone size-full wp-image-64" alt="6" src="http://msadministrator.files.wordpress.com/2012/12/6.png" width="519" height="397" /></a></li>
</ol>
<ol>
	<li>Wait while the deployment share is created.  Once this is done, a Confirmation screen will be shown.  Ensure no errors appear.</li>
</ol>
<a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-2-of-11/attachment/7/" rel="attachment wp-att-65"><img class="alignnone size-full wp-image-65" alt="7" src="http://msadministrator.files.wordpress.com/2012/12/7.png" width="519" height="397" /></a>
<ol>
	<li>Click <b>Finish</b></li>
</ol>
<p align="left"><b> </b></p>

<h2>2.2       Configuring the Deployment Share</h2>
<ol>
	<li>Right-click on the new deployment share and select <b><i>Properties</i></b></li>
	<li><a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-2-of-11/attachment/8/" rel="attachment wp-att-66"><img class="alignnone size-full wp-image-66" alt="8" src="http://msadministrator.files.wordpress.com/2012/12/8.png" width="519" height="426" /></a></li>
</ol>
<ol>
	<li>Select the “<b><i>Rules</i></b>” tab and click the “<b><i>Edit bootstrap.ini</i></b>” button at the bottom</li>
	<li>Add the following 4 lines to the file and save it as shown below, replacing the userID and userdomain with your own settings and replacing the DeployRoot path with your own:</li>
</ol>
<a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-2-of-11/attachment/9/" rel="attachment wp-att-67"><img class="alignnone size-full wp-image-67" alt="9" src="http://msadministrator.files.wordpress.com/2012/12/9.png" width="350" height="213" /></a>

UserDomain=CONFIG

SkipBDDWelcome=YES
<ol>
	<li>Select the “<b><i>Windows PE x86 Settings</i></b>” tab and unselect the “<b><i>Generate a Lite Touch bootable ISO image</i></b>” option unless you want to create a network boot CD.</li>
</ol>
<p align="center"><a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-2-of-11/attachment/10/" rel="attachment wp-att-68"><img class="alignnone size-full wp-image-68" alt="10" src="http://msadministrator.files.wordpress.com/2012/12/10.png" width="519" height="425" /></a></p>

<ol>
	<li>Repeat step 4 on the “<b><i>Windows PE x64 Settings</i></b>” tab then click <b><i>OK</i></b></li>
</ol>
<p align="left"><b> </b></p>
