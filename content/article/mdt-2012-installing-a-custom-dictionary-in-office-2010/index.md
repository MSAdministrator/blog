---
title: "Mdt 2012 Installing a Custom Dictionary in Office 2010"
date: 2018-08-07T20:43:39-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
So, some might not need this but thought I would share anyways.  I have created my new MDT 2012 Deployment Share and want to add Microsoft Office 2010 as an application, but I also need to customize that deployment of Office 2010 when I'm deploying my new OS.  Here are the steps on how to do this, but also how to create a custom Office 2010 Install.
<ol>
	<li>Once you've setup everything for you OS, go to the Applications folder on your Deployment Share and right click&gt;New Application</li>
	<li>Once there, put in the relavent information including where your resource CD is located.</li>
	<li>THen once you have done this, you will notice that there is an extra tab compared to other applications.  This is because Microsoft Deployment Toolkit recognizes that it's Office 2010 and gives you a few more options.</li>
	<li><a href="http://msadministrator.wordpress.com/2012/12/23/mdt-2012-installing-a-custom-dictionary-in-office-2010/attachment/50/" rel="attachment wp-att-140"><img class="alignnone size-full wp-image-140" alt="50" src="http://msadministrator.files.wordpress.com/2012/12/50.png" width="519" height="404" /></a></li>
	<li>Click on the Office Products Tab and you should now see this screen:</li>
	<li><a href="http://msadministrator.wordpress.com/2012/12/23/mdt-2012-installing-a-custom-dictionary-in-office-2010/attachment/51/" rel="attachment wp-att-141"><img class="alignnone size-full wp-image-141" alt="51" src="http://msadministrator.files.wordpress.com/2012/12/51.png" width="519" height="427" /></a></li>
	<li>Now click on the Office Customization Tool</li>
	<li>You will be prompted with a warning box, please read and understand this.  Any Customizations you make are saved in a customization file and need to be moved to the appropriate folder within your Office 2010 source file.</li>
	<li><a href="http://msadministrator.wordpress.com/2012/12/23/mdt-2012-installing-a-custom-dictionary-in-office-2010/attachment/52/" rel="attachment wp-att-142"><img class="alignnone size-full wp-image-142" alt="52" src="http://msadministrator.files.wordpress.com/2012/12/52.png" width="393" height="153" /></a></li>
	<li>Then the Office Customization Tool dialog box shows up.  You can do ton's of customizations but for this post it's all about adding a Custom Dictionary to Office 2010.</li>
	<li><a href="http://msadministrator.wordpress.com/2012/12/23/mdt-2012-installing-a-custom-dictionary-in-office-2010/attachment/54/" rel="attachment wp-att-143"><img class="alignnone size-full wp-image-143" alt="54" src="http://msadministrator.files.wordpress.com/2012/12/54.png" width="519" height="292" /></a></li>
	<li>Once there select Add Files and go to where your .Dic file is at and make sure you select INSTALLLOCATION as the option.</li>
	<li>Then click on Add Registry Entires</li>
	<li><a href="http://msadministrator.wordpress.com/2012/12/23/mdt-2012-installing-a-custom-dictionary-in-office-2010/attachment/55/" rel="attachment wp-att-144"><img class="alignnone size-full wp-image-144" alt="55" src="http://msadministrator.files.wordpress.com/2012/12/55.png" width="519" height="294" /></a></li>
	<li>Add the Registry settings that you see in the image above</li>
	<li>Here is a more detailed view of what you should see when you select Add... in the bottom corner:</li>
	<li><a href="http://msadministrator.wordpress.com/2012/12/23/mdt-2012-installing-a-custom-dictionary-in-office-2010/attachment/57/" rel="attachment wp-att-146"><img class="alignnone size-full wp-image-146" alt="57" src="http://msadministrator.files.wordpress.com/2012/12/57.png" width="519" height="281" /></a></li>
	<li>Then select Remove Registry Entries, this is needed to remove any previous settings when Office 2010 Installs originally.</li>
	<li><a href="http://msadministrator.wordpress.com/2012/12/23/mdt-2012-installing-a-custom-dictionary-in-office-2010/attachment/56/" rel="attachment wp-att-145"><img class="alignnone size-full wp-image-145" alt="56" src="http://msadministrator.files.wordpress.com/2012/12/56.png" width="519" height="291" /></a></li>
	<li>That's it, now save your MSP File in the appropriate location and you should be good to go.</li>
</ol>
