---
title: "Mdt 2012 Deployment Guide Step by Step 8 of 11"
date: 2018-08-07T20:43:29-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
<h2>Importing a Customer Reference Image</h2>
<ol>
	<li>From the Deployment Workbench, expand the customer Deployment Share and right-click on <b><i>Operating Systems</i></b> and select <b><i>Import Operating System</i></b></li>
	<li>From the Import Operating System Wizard, select <b><i>Custom Image File </i></b>and click <b><i>Next</i></b></li>
	<li>Browse to the path of the WIM file.  For captured images, this would by default be the <b><i>\Captures</i></b> folder in the Deployment Share</li>
	<li>Select “<b><i>Copy Windows Vista, Windows Server 2008, or later setup files from specified path</i></b>” and enter the path to the relevant OS installation media.  (Strictly speaking you shouldn’t need to do this step but it bugs out sometimes in my experience)</li>
</ol>
<p align="center"></p>
<p align="center"><a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-8-of-11/attachment/25/" rel="attachment wp-att-103"><img class="alignnone size-full wp-image-103" alt="25" src="http://msadministrator.files.wordpress.com/2012/12/25.png" width="519" height="425" /></a></p>

<ol>
	<li>Enter an appropriate directory name</li>
</ol>
<p align="center"><a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-8-of-11/attachment/26/" rel="attachment wp-att-104"><img class="alignnone size-full wp-image-104" alt="26" src="http://msadministrator.files.wordpress.com/2012/12/26.png" width="519" height="426" /></a></p>

<ol>
	<li>Ensure the summary is correct and click <b><i>Next</i></b></li>
</ol>
<p align="center"></p>
<p align="center"><a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-8-of-11/attachment/27/" rel="attachment wp-att-105"><img class="alignnone size-full wp-image-105" alt="27" src="http://msadministrator.files.wordpress.com/2012/12/27.png" width="519" height="425" /></a></p>

<ol>
	<li>Wait while the image is imported then check the Confirmation shows no errors.</li>
</ol>
&nbsp;

&nbsp;

You should now have everything you need to deploy your Windows 7 image to any hardware.  The last step is to create a deployment Task Sequence.
