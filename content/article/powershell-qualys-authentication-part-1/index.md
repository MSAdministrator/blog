---
title: "Powershell Qualys Authentication Part 1"
date: 2018-08-07T20:44:31-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
I always mean to post more on my blog, but as life gets in the way and work keeps me busy, I always seem to push it to the back-burner. This time, I am hoping to make it stick as a regular routine.

To kick off my new-found motivation to blog more, I am starting a series of posts surrounding PowerShell and Qualys Vulnerability Management API.

To start this off, first I'm going to share some my basic steps with regards to authentication to Qualys VM API v1. This is really basic, but I see a lot of posts around that seem to try to create some "advanced" way of authenticating to Qualys API. You don't need to do anything fancy.

As with all scripts/modules/etc., I suggest that you get into the habit of using PowerShell ISE and it's many great keyboard shortcuts to help you get on the right path.

First, open PowerShell ISE and enter the following keyboard shortcut: [code
                    ]

CRT + J

[/code
                    ]

Once the "Show Snippets" context menu shows up, select "Advanced Function (Complete)". I always recommend that you start with a 'Complete' Advanced FUnction. This makes your script look much better, and it's all around a good idea.

Once you have the Snippet loaded, I would begin by coming up with a name; following Microsoft's approved Verb-Noun naming convention:

Approved Verbs - <a href="https://technet.microsoft.com/en-us/library/ms714428(v=vs.85).aspx">https://technet.microsoft.com/en-us/library/ms714428(v=vs.85).aspx</a>
Get-Verb Documentation: <a href="https://technet.microsoft.com/en-us/library/hh852690.aspx">https://technet.microsoft.com/en-us/library/hh852690.aspx</a>

Next, start adding a "Credential" object parameter to your code. Qualys uses "Basic" authentication, so using Invoke-RestMethod in combination with a "Credential" object is extremely easy.

To capture your credentials into a Credential Object used by Invoke-RestMethod, you simply need the following before you run your function or within your function: [code
                    ]

$cred = Get-Credential

[/code
                    ]


Enter your Qualys API username and password.

*NOTE: Do not try to save this credential object to disk or to a file. It's NOT hard to enter your username and password every time you connect to Qualys API.

Next, you should have the following code in your function: [code
                    ]

[xml
                    ]$hostinfo = Invoke-RestMethod -Uri &quot;https: //qualysapi.qualys.com/msp/get_host_info.php?host_netbios=$netbios&amp;general_info=1&quot;-Credential $credential [/code
                    ]


I recommend that your $credential object should be passed into your function as a parameter. This will help when you move into more advanced interaction and multiple calls to Qualys VM API.

Now that you have your XML (Type cast) $hostinfo variable, you can then parse the data very, very, very easily.

In my next post I will share with you how to do this to gather some very important data for any Qualys Vulnerability Management Administrator.

If you have any questions, then please leave a comment.


[code
                    ]

function Test-QualysAuthentication ()
{
                        [cmdletbinding()
                        ]
param (
[parameter(Mandatory=$true,
ValueFromPipelineByPropertyName=$true,
HelpMessage=&quot;Please provide a credential obejct&quot;)
                        ]
[ValidateNotNullOrEmpty()
                        ]
[System.Management.Automation.CredentialAttribute()
                        ]$credential
)

&lt;# .SYNOPSIS This function tests your Qualys VM API Credentials .PARAMETER Credential Specifices a set of credentials used to query the QualysGuard API .EXAMPLE C:\PS&gt; $cred = Get-Credential
C:\PS&gt; Test-QualysAuthentication -credential $cred

#&gt;

[xml
                        ]$hostinfo = Invoke-RestMethod -Uri &quot;https: //qualysapi.qualys.com/msp/get_host_info.php?host_netbios=$netbios&amp;general_info=1&quot; -Credential $credential

return $hostinfo
                    }

[/code
                    ]

