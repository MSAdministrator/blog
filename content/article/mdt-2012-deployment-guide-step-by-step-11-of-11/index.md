---
title: "Mdt 2012 Deployment Guide Step by Step 11 of 11"
date: 2018-08-07T20:43:36-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
<h1>Preparing WDS to enable PXE Boot (optional but very useful)</h1>
<ol>
	<li>Minimize the Deployment Workbench application</li>
	<li>Open “<b><i>Windows Deployment Services</i></b>” from Start/Admin Tools</li>
	<li>Expand Servers / CONFIG-DEPLOY.config.local and right-click on <b><i>Boot Images</i></b> and select <b><i>Add Boot Image.</i></b> If the boot image already exists, right click on it and select <b><i>Replace Boot Image</i></b> to replace it with a newer version</li>
</ol>
<p align="center"><a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-11-of-11/attachment/37/" rel="attachment wp-att-126"><img class="alignnone size-full wp-image-126" alt="37" src="http://msadministrator.files.wordpress.com/2012/12/37.png" width="519" height="253" /></a></p>

<ol>
	<li>Browse to the Deployment Share location (e.g. E:\DeploymentShares\Customername) and open the Boot folder</li>
	<li>Select the <b><i>LiteTouchPE_x86.wim</i></b> file and click <b><i>Open</i></b></li>
</ol>
<p align="center"> <a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-11-of-11/attachment/38/" rel="attachment wp-att-127"><img class="alignnone size-full wp-image-127" alt="38" src="http://msadministrator.files.wordpress.com/2012/12/38.png" width="519" height="370" /></a></p>

<ol>
	<li>Click <b><i>Next</i></b></li>
</ol>
<ol>
	<li>Enter an Image Name and Description</li>
</ol>
<p align="center"> <a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-11-of-11/attachment/39/" rel="attachment wp-att-128"><img class="alignnone size-full wp-image-128" alt="39" src="http://msadministrator.files.wordpress.com/2012/12/39.png" width="513" height="439" /></a></p>

<ol>
	<li>Click Next until the wizard completes.  Adding the image may take a couple of minutes.</li>
</ol>
<p align="center"> <a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-11-of-11/attachment/40/" rel="attachment wp-att-129"><img class="alignnone size-full wp-image-129" alt="40" src="http://msadministrator.files.wordpress.com/2012/12/40.png" width="495" height="424" /></a></p>

<ol>
	<li>Once completed, the image will be listed as shown below</li>
</ol>
<p align="left"> <a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-11-of-11/attachment/41/" rel="attachment wp-att-130"><img class="alignnone size-full wp-image-130" alt="41" src="http://msadministrator.files.wordpress.com/2012/12/41.png" width="519" height="166" /></a></p>
