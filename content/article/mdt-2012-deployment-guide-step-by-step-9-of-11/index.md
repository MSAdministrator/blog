---
title: "Mdt 2012 Deployment Guide Step by Step 9 of 11"
date: 2018-08-07T20:43:32-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
<h1>Creating a Deployment Task Sequence</h1>
<ol>
	<li>From the Deployment Workbench, expand the customer Deployment Share and right-click on <b><i>Task Sequences</i></b> and select <b><i>New Task Sequence</i></b></li>
	<li>Enter a Task Sequence ID and Name.  Make a note of the ID as you may need it later!</li>
</ol>
<p align="center"></p>
<p align="left"><a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-9-of-11/attachment/28/" rel="attachment wp-att-109"><img class="alignnone size-full wp-image-109" alt="28" src="http://msadministrator.files.wordpress.com/2012/12/28.png" width="519" height="426" /></a></p>

<ol>
	<li>Accept the default <b><i>“Standard Client Task Sequence</i></b>” template</li>
	<li>Select the relevant OS Image to deploy</li>
</ol>
<p align="center"> <a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-9-of-11/attachment/29/" rel="attachment wp-att-110"><img class="alignnone size-full wp-image-110" alt="29" src="http://msadministrator.files.wordpress.com/2012/12/29.png" width="519" height="385" /></a></p>

<ol>
	<li>This option will vary dependent on whether you are going to be using KMS or MAK licenses for their Windows 7 deployment.</li>
</ol>
<b>KMS          -                 </b>Select <b><i>Do not specify a product key at this time</i></b>

<b>MAK         -                 </b>Select <b><i>Specify a multiple activation key (MAK key) for activating this operating system</i></b>

and enter the relevant key

<b><i> </i></b>
<ol>
	<li>Enter the relevant information in the OS Settings page</li>
</ol>
<p align="center"> <a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-9-of-11/attachment/30/" rel="attachment wp-att-111"><img class="alignnone size-full wp-image-111" alt="30" src="http://msadministrator.files.wordpress.com/2012/12/30.png" width="519" height="425" /></a></p>

<ol>
	<li>Enter an Administrator password – this will be the local Admin password for the machines when built (Dilbert)</li>
	<li>Ensure the summary data is correct</li>
	<li>Accept the confirmation screen</li>
</ol>
<p align="left"></p>
<p align="left">The task sequence is now created.  We can customise this to our hearts content but generally we don’t need to make too many changes.</p>
<p align="left"></p>
&nbsp;
<p align="left"><b> </b></p>

<h2>9.1  Task Sequence Properties</h2>
<p align="left">When you edit a Task Sequence, there are multiple areas of configuration.  The properties of a Task Sequence consists of three tabs – General, Task Sequence and OS Info.</p>
<p align="left"></p>

<h3>General Tab</h3>
The General tab contains the summary information about the Task Sequence including the sequence ID, Name and any comments along with the list of client platforms which the sequence is allowed to run on.
<p align="left"></p>
<p align="center"><a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-9-of-11/attachment/31/" rel="attachment wp-att-112"><img class="alignnone size-full wp-image-112" alt="31" src="http://msadministrator.files.wordpress.com/2012/12/31.png" width="519" height="461" /></a></p>

<h3>Task Sequence Tab</h3>
The task sequence example below is based on the “Standard Client Task Sequence” template provided by MDT but the screenshot below includes quite a bit of stuff which wasn’t needed for the environment concerned (sorry).  Both 32 and 64 bit sequences are identical with the exception of the “Install Operating System” step which refers to the appropriate 32 or 64 bit custom OS image.
<p align="center"><a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-9-of-11/attachment/32/" rel="attachment wp-att-113"><img class="alignnone size-full wp-image-113" alt="32" src="http://msadministrator.files.wordpress.com/2012/12/32.png" width="519" height="459" /></a></p>
<b>Set DriverGroup001 Task Sequence Variable Step</b>

This is an additional step we’ve added which sets the “DriverGroup001” variable to “%make%\%model% which will automatically pick up the correct drivers from the repository based on manufacturer and model name.  If we do not do this, MDT will just trawl through the entire Out-of-Box Drivers repository and try to determine the correct drivers based on PnP ID and it sometimes gets it wrong!  This gives us a little more control!  <b>NOTE:</b> DriverGroup001 needs to go immediately before the first “Inject Drivers” step.
<h3>OS Info Tab</h3>
The OS Info Tab’s contents will vary depending on which OS is being installed by the Task Sequence.  For Windows 7, it simply consists of a single button to edit the <i>unattend.xml</i> file which controls the configuration settings of Windows 7 during deployment.  Most elements of unattend.xml are automatically configured on-the-fly by MDT based on information provided during the Deployment Wizard although you can add additional elements manually.  For MIL, we are letting MDT perform all of the configuration of unattend.xml based on settings we have pre-configured in the CustomSettings.ini (see section 4.1)

<b>Copying the Default Profile we Created before we Captured our Image:</b>

<b> </b>

<b>                  </b>While within this task sequence we need to modify our Unattend.xml file so that the image will keep our Default Profile.  To do this, we must enable the CopyProfile setting within the Unattend.xml file but we can only do so from the Deployment Task Sequence, and<strong> NOT FROM THE CAPTURE TASK SEQUENCE.</strong>  View the Images below for more details:

<a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-9-of-11/attachment/33/" rel="attachment wp-att-114"><img class="alignnone size-full wp-image-114" alt="33" src="http://msadministrator.files.wordpress.com/2012/12/33.png" width="519" height="410" /></a>

<a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-9-of-11/attachment/34/" rel="attachment wp-att-115"><img class="alignnone size-full wp-image-115" alt="34" src="http://msadministrator.files.wordpress.com/2012/12/34.png" width="519" height="410" /></a>
