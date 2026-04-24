---
title: "Questions About Mdt 2012 Driver Setup"
date: 2018-08-07T20:43:41-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
So I've had a lot of questions about my MDT 2012 Driver setup and hopefully this post will explain a little bit about it.  Let me know if you have any questions

Personally I have a folder on my server called _Source_Drivers.  I keep all my drivers here and import them into MDT but keep the original.  Here is what my file structure of this folder looks like.

<a href="http://msadministrator.files.wordpress.com/2013/04/mdt-source-drivers-structure.png"><img class="alignnone size-full wp-image-150" alt="MDT Source Drivers Structure" src="http://msadministrator.files.wordpress.com/2013/04/mdt-source-drivers-structure.png" width="299" height="532" /></a>

Once I have my structure setup I then begin to setup the structure on my MDT Deployment Share.  Here is how I currently have it setup as.

<a href="http://msadministrator.files.wordpress.com/2013/04/mdt-deployment-share-structure.png"><img class="alignnone size-full wp-image-151" alt="MDT Deployment Share Structure" src="http://msadministrator.files.wordpress.com/2013/04/mdt-deployment-share-structure.png" width="345" height="226" /></a>

I import the drivers into the specific folders by right clicking the folder in the Deployment Share and import drivers.  I select the folder for that model and import all but select copy the drivers.

Here is what one of the driver sub folders look like in my deployment share

<a href="http://msadministrator.files.wordpress.com/2013/04/mdt-driver-import-screenshot.png"><img class="alignnone size-full wp-image-152" alt="MDT Driver Import Screenshot" src="http://msadministrator.files.wordpress.com/2013/04/mdt-driver-import-screenshot.png" width="519" height="356" /></a>

&nbsp;

Don't forget to add your DriverGroup001 variable set with %make%\%model% right before the Inject Drivers sequence in your Deployment Task Sequence

<a href="http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-9-of-11/">http://msadministrator.wordpress.com/2012/12/21/mdt-2012-deployment-guide-step-by-step-9-of-11/</a>

&nbsp;
