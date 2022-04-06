---
title: "Script Removing Proxy From Firefox User Prefs Js"
date: 2018-08-07T20:43:54-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
So, I was tasked with removing proxy settings from Firefox because of Webroot Desktop Proxy.  Removing them from the %Programfiles% directory was easy, the hard part was the user prefs.js.  Anyways, here's a little script I created to remove Proxy settings and set them to No Proxy.

cd /D "%APPDATA%\Mozilla\Firefox\Profiles\"
cd *.default
set ffile=%cd%
type "%ffile%\prefs.js" | findstr /v "user_pref("network.proxy.type", 2);"&gt;"%ffile%\prefs_.js"
type "%ffile%\prefs.js" | findstr /v "user_pref("network.proxy.type", 0);"&gt;"%ffile%\prefs_.js"
ren "prefs.js" "prefs_.js"
del "%ffile%\prefs.js"
ren "prefs_.js" "prefs.js"
del "%ffile%\prefs_.js"
echo user_pref("network.proxy.type", 0);&gt;&gt;"%ffile%\prefs.js"
set ffile=
cd %windir%
