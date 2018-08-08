---
title: "Ipad Lockdown Mobileconfig"
date: 2018-08-07T20:43:44-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
It is possible to put an iPad or iPhone into 'Store Demo' mode so that the home button and swipe to home gesture is disabled. If you have seen the iPads in the Apple Store running the smart sign apps then you will know what I mean.

It is actually pretty trivial to make this work, all you need to do is install a correctly formatted mobile config plist over the air from a web server.

To deliver your config from the web all you have to do is direct the iPhone to a url containing the profile. Just open the link to your .mobileconfig file in safari. If you don't have web space you can just use dropbox public folder URLs or switch on your mac webserver.

This config file will not load in the iPhone Configuration Utility as it uses keys that IPCU doesn't know about. You can combine this with whatever other enterprise configuration profiles you have in play.

IPCU is not required to remove the profile. However note that to get your device back to normal you would need to do the following:
<ol start="1">
	<li>Reboot</li>
	<li>Open the settings app FIRST - don't open anything else or you will need to reboot again</li>
	<li>Settings-&gt;General-&gt;Profiles-&gt;[your profile
                    ] remove it.</li>
	<li>Reboot</li>
</ol>
you should be back to normal.

I have included an example plist that will disable the home button and lock your device into the app.

<b>BEWARE</b>

<i>Once this profile is installed the first app that is launched when the device is rebooted will be the only app that will run until you reboot the device again.</i> This completely disables the ability to return to the home screen (unless your app crashes) including accessibility assistive touch.

Note that after installing the profile you must reboot the device (power off, power on) for it to take effect. To remove the profile plug the device into IPCU and delete it then reboot the device. Everything will be back to normal.

&lt;?xml version="1.0" encoding="UTF-8"?&gt;
&lt;!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd"&gt;
&lt;plist version="1.0"&gt;
&lt;dict&gt;
&lt;key&gt;PayloadContent&lt;/key&gt;
&lt;array&gt;
&lt;dict&gt;
&lt;key&gt;PayloadDescription&lt;/key&gt;
&lt;string&gt;Disables home&lt;/string&gt;
&lt;key&gt;PayloadDisplayName&lt;/key&gt;
&lt;string&gt;Home Button Lock&lt;/string&gt;
&lt;key&gt;PayloadIdentifier&lt;/key&gt;
&lt;string&gt;com.hbkill.kiosk&lt;/string&gt;
&lt;key&gt;PayloadOrganization&lt;/key&gt;
&lt;string&gt;My Org&lt;/string&gt;
&lt;key&gt;PayloadType&lt;/key&gt;
&lt;string&gt;com.apple.defaults.managed&lt;/string&gt;
&lt;key&gt;PayloadUUID&lt;/key&gt;
&lt;string&gt;B2D02E2D-BAC5-431B-8A29-4B91F71C9FC1&lt;/string&gt;
&lt;key&gt;PayloadVersion&lt;/key&gt;
&lt;integer&gt;1&lt;/integer&gt;
&lt;key&gt;PayloadContent&lt;/key&gt;
&lt;array&gt;
&lt;dict&gt;
&lt;key&gt;DefaultsDomainName&lt;/key&gt;
&lt;string&gt;com.apple.springboard&lt;/string&gt;
&lt;key&gt;DefaultsData&lt;/key&gt;
&lt;dict&gt;
&lt;key&gt;SBStoreDemoAppLock&lt;/key&gt;
&lt;true/&gt;
&lt;/dict&gt;
&lt;/dict&gt;
&lt;/array&gt;
&lt;/dict&gt;
&lt;/array&gt;
&lt;key&gt;PayloadDescription&lt;/key&gt;
&lt;string&gt;Disables Home Button&lt;/string&gt;
&lt;key&gt;PayloadDisplayName&lt;/key&gt;
&lt;string&gt;Home Button Lock&lt;/string&gt;
&lt;key&gt;PayloadIdentifier&lt;/key&gt;
&lt;string&gt;com.hbkill&lt;/string&gt;
&lt;key&gt;PayloadOrganization&lt;/key&gt;
&lt;string&gt;My Org&lt;/string&gt;
&lt;key&gt;PayloadType&lt;/key&gt;
&lt;string&gt;Configuration&lt;/string&gt;
&lt;key&gt;PayloadUUID&lt;/key&gt;
&lt;string&gt;614D1FE3-F80D-4643-AF6B-D10C4CC8737A&lt;/string&gt;
&lt;key&gt;PayloadVersion&lt;/key&gt;
&lt;integer&gt;1&lt;/integer&gt;
&lt;/dict&gt;
&lt;/plist&gt;
