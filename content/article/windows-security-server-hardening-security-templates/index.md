---
title: "Windows Security Server Hardening Security Templates"
date: 2018-08-07T20:44:16-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
Hardening your systems (Servers, Workstations, Applications, etc.) ensures that every system is secured in accordance to your organizations standards.  Microsoft has a "Solution Accelerator" called Security Compliance Manager that allows System Administrators or IT Pro's to create security templates that help harden their systems in a manageable, repeatable, way.  In addition to SCM, you can build your own by using the standard MMC console and adding the Security Templates Snap-In to the console - this gives you a more refined configuration, but can be cumbersome.
<h2><strong>Microsoft Security Compliance Manager</strong></h2>
With Security Compliance Manager you are able to view Microsoft's (along with experts in the field) recommended security baseline configurations.  With this knowledge you are able to view their recommendations, thus improving your system hardening.  When installing SCM 3.o (http: //technet.microsoft.com/en-us/solutionaccelerators/cc835245.aspx) you will need to have SQL Express installed, which the application takes care if you don't have it currently installed.

Once the application is running you will see three main content windows.  The first is the list of all variations of configurations by Microsoft (note the "Other Baselines" at the bottom).  In the center pane you are greeted by the "Welcome Screen" - the first step I always do when installing SCM is to click on "Download Microsoft baselines automatically".  By doing this, it should download the most recent configuration settings.

Once they are downloaded, you should see more options in the first pane (Microsoft Baselines). Next, select the baseline "root" that you want to examine and then select a specific configuration section within that baseline.  Once doing so, you should see tons of settings that apply to that configuration (this is similar to Group Policy Objects) and if you select one of these "GPOish" settings you will see further detail.

Now, if you've selected an item in the center pane then you should have noticed the far right pane change - this is the action pane.  The action pane is similar to all other Microsoft products and allows you take certain actions as necessary.

For Example:
<ol>
<ol>
	<li>Launch SCM 3.0</li>
	<li>Click on "Download Microsoft baselines automatically"</li>
	<li>Next select Windows 8.1 (expand the arrow)</li>
	<li>You should see something similar to this</li>
</ol>
</ol>
<a href="https://msadministrator.files.wordpress.com/2014/10/2014-10-19-14_20_17-microsoft-security-compliance-manager.png"><img class="alignnone size-full wp-image-287" src="https://msadministrator.files.wordpress.com/2014/10/2014-10-19-14_20_17-microsoft-security-compliance-manager.png" alt="2014-10-19 14_20_17-Microsoft Security Compliance Manager" width="194" height="206" /></a>

&nbsp;
<ol>
	<li>Next, select "Windows 8.1 Computer Security Compliance 1.0"</li>
	<li>You should see tons of options in the center pane - select the very first option (Interactive Logon: Machine account lockout threshold)</li>
	<li>You may notice that everything is grayed out.  To make changes at this point you will need to duplicate this setting.  When doing this, it will add it to your "Other Baselines" option at the bottom of the left-side pane (Don't do this now).</li>
	<li>Do you see the option underneath this setting (when selected) that says "Setting Details" - select this now.</li>
	<li>Within this section you see more detailed information that relates to the:
<ol>
	<li>GPO Path</li>
	<li>Description of this setting</li>
	<li>Additional Details</li>
	<li>Vulnerabilities related to this setting</li>
	<li>Potential Impacts of this setting</li>
	<li>Countermeasures that can be taken</li>
</ol>
</li>
</ol>
The best part of the Security Compliance Manager is that you can import a backup on your Group Policy Objects to identify weaknesses and strengths of your current configurations.  The ability to compare your current Group Policy settings makes SCM the ideal tool to identify security threats to your organization.

Once importing settings into the SCM Console you are able to generate changes and create Group Policy Security Templates that you can then apply to your Domain or Local Group Policy.  It's ideal to base this off of your current configurations, but you could go through all of these settings and create a custom Security Template from scratch if you are so inclined.
<h2><strong>INF Templates with MMC</strong></h2>
Besides using Microsoft Security Compliance Manager, you can also create Security Templates by using the standard Windows MMC (Microsoft Management Console) console.  With this option, you are able to create INF templates which will allow you to configure specific settings for lets say an IIS, Domain Controller, Hyper-V, etc. server.  When you create these Security Templates, then you know that every (IIS, DC, Hyper-V) server has a very specific configuration from the beginning, thus ensuring that all of your configurations are the same across the entire domain/forest/network.
<ul>
	<li>Open MMC.exe</li>
	<li>Go to File -&gt; Add/Remove Snap-In...</li>
	<li>Select "Security Templates"</li>
	<li>Click Add</li>
	<li>Click Ok</li>
	<li>Expand "Security Templates" - you should see a path similar to the following
<ul>
	<li>C:\Users\%USERNAME%\Documents\Security\Templates</li>
</ul>
</li>
	<li>Right click on this path and select -&gt; New Template</li>
	<li>Give the Template a name and a brief description (if needed)</li>
	<li>You should now see your newly created Security Template underneath the path above</li>
</ul>
You have several different options within this "Security Template", and each has a very specific purpose.  For example, the "System Services" section is used to enable or disable specific services that are set automatically by your default image (or Microsoft).  On an IIS server, you DO NOT need most of these services running - this leads to unwanted configurations and possibility of exploitation.  Using "Security Templates" ensures that your systems are properly configured.

Another example of "Security Templates" settings is the "Registry" setting.  The "Registry" setting allows you to configure permissions for certain Registry Hives (i.e. SAM, HARDWARE, SYSTEM, SECURITY, SOFTWARE, Etc.).  To add specific permissions (hardening) to Registry hives/keys, you must right-click the "Registry" setting and select "Add Key".

Using INF Security Templates can greatly reduce unwanted configurations of systems/services/applications, but you must understand and test these configurations before deploying them.  Once you have tested your INF Security Templates you can then deploy them using Group Policy or PowerShell.

Using Security Templates from Microsoft and the Security Compliance Manager allows for a more robust configuration that has been proven to reduce your security risk.  If you're wanting a bit more of a custom approach or wanting to experiment, you can create very precise Security Templates using the built-in MMC console.  Either way, creating a standard "Golden" image with a predefined Security Template will reduce errors by busy SysAdmins as well as ensuring that every system has the appropriate configurations applied without "admin" interaction.

Additional Info:
<ul>
	<li>Look at C:\Windows\Inf for built-in Security Templates to help you on your way</li>
	<li>Checkout the Security Compliance Manager site for more information: http: //technet.microsoft.com/en-us/solutionaccelerators/cc835245.aspx</li>
	<li>Check out this quick write-up: http: //www.techrepublic.com/blog/it-security/use-ms-security-compliance-manager-to-secure-your-windows-environment/ (it's a bit older, but its a good read)</li>
	<li>Check out this video: http: //www.windowsecurity.com/articles-tutorials/windows_os_security/Video-Security-Compliance-Manager-25-Understanding-Baselines.html</li>
</ul>
&nbsp;

&nbsp;

&nbsp;
