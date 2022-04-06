---
title: "Mdt 2012 Deployment Guide Step by Step 6 of 11"
date: 2018-08-07T20:43:24-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
<h1>Completing the Deployment Share Configuration</h1>
Now you have imported an OS (from source media) and some WinPE drivers, we can go ahead and complete the configuration of the Deployment Share.
<h2>6.1       Advanced Configuration</h2>
The Advanced Configuration section of MDT consists of four separate areas although, we only use the Selection Profiles section for now.  The rest are advanced topics which you can explore later!
<h3>Advanced Configuration – Selection Profiles</h3>
Created a single additional selection profile – “WinPE Drivers” and configured it to contain only the drivers which Windows PE will use.  We’ll use this profile in a moment to configure the Windows PE environment.  The next three photo's are in order by actions:

<a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-6-of-11/attachment/15/" rel="attachment wp-att-87"><img class="alignnone size-full wp-image-87" alt="15" src="http://msadministrator.files.wordpress.com/2012/12/15.png" width="519" height="398" /></a>

<a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-6-of-11/attachment/16/" rel="attachment wp-att-88"><img class="alignnone size-full wp-image-88" alt="16" src="http://msadministrator.files.wordpress.com/2012/12/16.png" width="519" height="186" /></a>

<a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-6-of-11/17-2/" rel="attachment wp-att-89"><img class="alignnone size-full wp-image-89" alt="17" src="http://msadministrator.files.wordpress.com/2012/12/17.png" width="519" height="459" /></a>

<strong> 6.2       More Deployment Share Properties</strong>

Now we return to the Properties page for the deployment share.  We need to open the <b>Windows PE x86 Components</b> tab (and/or the <b>Windows PE x64 Components</b> one)

In the Selection Profile drop down, select the WinPE Drivers profile we just created and then click OK.

<a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-6-of-11/attachment/18/" rel="attachment wp-att-90"><img class="alignnone size-full wp-image-90" alt="18" src="http://msadministrator.files.wordpress.com/2012/12/18.png" width="519" height="363" /></a>
<table cellspacing="0" cellpadding="0" align="left">
<tbody>
<tr>
<td width="22" height="0"></td>
</tr>
<tr>
<td></td>
<td></td>
</tr>
</tbody>
</table>
&nbsp;

&nbsp;

<strong>6.3       Build the WinPE Boot Media</strong>

Once everything is completed, you can update the deployment share.  This will generate (or regenerate) the PXE boot images including loading the relevant drivers to allow the Windows PE environment to talk to the network to enable the deployment.
<ol>
	<li>From the Deployment Workbench, right-click  the customer Deployment Share and select <b><i>Update Deployment Share</i></b></li>
	<li><a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-6-of-11/attachment/19/" rel="attachment wp-att-91"><img class="alignnone size-full wp-image-91" alt="19" src="http://msadministrator.files.wordpress.com/2012/12/19.png" width="519" height="335" /></a></li>
</ol>
<ol>
	<li>Select <b><i>Optimize the boot image updating process</i></b></li>
	<li><a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-6-of-11/attachment/20/" rel="attachment wp-att-92"><img class="alignnone size-full wp-image-92" alt="20" src="http://msadministrator.files.wordpress.com/2012/12/20.png" width="519" height="426" /></a></li>
</ol>
<ol>
	<li>Click <b><i>Next</i></b>.</li>
</ol>
<p align="left"></p>

<div>
<p align="left"><b>NOTE:</b>                       This process may take in excess of 30 minutes!  Be patient!</p>

</div>
<p align="left"></p>

<ol>
	<li>Click <b><i>Finish</i></b></li>
</ol>
We can now capture our reference Windows 7 image.  I am assuming that this has already been created on a reference PC (or VM).
