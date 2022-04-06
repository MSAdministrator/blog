---
title: "Powershell Qualys Get Asset Group Info Part 2"
date: 2018-08-07T20:44:33-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
Today I decided to write another post regarding PowerShell and Qualys Vulnerability Management API.  This post will focus on gathering information about your enrolled Asset Groups.   You can find the complete script on GitHub: <a href="https://github.com/MSAdministrator/POSH-Guard/blob/master/Get-QualysAssetGroupInformation" target="_blank">https://github.com/MSAdministrator/POSH-Guard/blob/master/Get-QualysAssetGroupInformation</a>

We start of by opening up PowerShell ISE and using our handy "Snippet" shortcut:

<a href="http://msadministrator.com/2016/02/03/powershell-qualys-get-asset-group-info-part-2/powershell_ise_ctrl__j/" rel="attachment wp-att-318"><img class="alignnone size-full wp-image-318" src="https://msadministrator.files.wordpress.com/2016/02/powershell_ise_ctrl__j.png" alt="PowerShell_ISE_CTRL_+_J" width="519" height="618" /></a>

We select the "Cmdlet (Advanced function) - complete" option in the "Snippet" context menu.  Once we have our advanced function template, we then proceed by entering a name for our Qualys Asset Group function.

Since we will be gathering some additional information about our Asset Groups, I am going to name my function: [code
                    ]

function Get-QualysAssetGroupInformation

[/code
                    ]

Next, we will start by filling out our "Help" info.  At this point, a lot of people skip this step; I HIGHLY recommend that you do not.  It will help you and anyone else viewing your code, understand what your intention was when writing this function.

Next, we start by looking at our advanced functions template within the body of this function.  The first thing you will see is some default parameters for [CmdletBinding
                    ].  With my function, I'm going to weed these parameters down a bit, as they are not really needed.  Your function should look something like this when complete: [code
                    ]
function Get-QualysAssetGroupInformation
{
                        [CmdletBinding(SupportsShouldProcess=$true, 
                  HelpUri = 'https: //raw.githubusercontent.com/MSAdministrator/POSH-Guard/master/Get-QualysAssetGroupInformation',
                  ConfirmImpact='Medium')
                        ]
    [Alias()
                        ]
    Param
    (
        # Param1 help description
        [parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   HelpMessage=&quot;Please provide a credential obejct&quot;)
                        ]
                   [ValidateNotNullOrEmpty()
                        ]
                   [System.Management.Automation.CredentialAttribute()
                        ]$credential
        ) 

    Begin
    {}
    Process
    {}
    End
    {}
                    }
[/code
                    ]

After we have the base of this function setup and ready to go, we will start off by adding some code into our Begin block.  Remember, the Begin block will always run once for every call to the function.

[code
                    ]
	$results = @()
	$assetGroupInfo = @()
        [xml
                    ]$assetGroupInfo = Invoke-RestMethod -Uri &quot;https: //qualysapi.qualys.com/msp/asset_group_list.php&quot; -Credential $credential [/code
                    ]

Here I am setting my $assetGroupInfo and a $results variable as empty array's/hash-table's. Next, I'm casting my $assetGroupInfo variable as an XML object. This ensures that we receive XML from Invoke-RestMethod Cmdlet.

If we want to make sure that any errors are caught, we should add a Try/Catch block to our Invoke-RestMethod call. Your code should look like this: [code
                    ]
 Begin
    {
        $results = @()
        $assetGroupInfo = @()

        Try
        {
                            [xml
                            ]$assetGroupInfo = Invoke-RestMethod -Uri &quot;https: //qualysapi.qualys.com/msp/asset_group_list.php&quot; -Credential $credential
                        }
        Catch
        {
            Write-Debug &quot;Error using Invoke-RestMethod: $_&quot;
                        }
                    }
[/code
                    ]

Now we move to the Process block. This is where we will be parsing our data into our objects. As I mentioned above, we are wanting to gather all our Asset Groups Titles, their assigned IP Addresses, their role, and the users login ID. To do this, we must loop through each item, or branch returned by our query above. Each $item can be considered as an Asset Group. Additionally, we need to loop through each of the users assigned to that Asset Group.

Once we have that data, we want to create a Custom PSObject to hold all of this data. Your code should look like this: [code
                    ]
Process
{
	foreach ($item in $assetGroupInfo.SelectNodes(&quot;/ASSET_GROUP_LIST/ASSET_GROUP&quot;))
	{
		for ($u=0; $u -lt $($item.ASSIGNED_USERS.ASSIGNED_USER.LOGIN).count;$u++)
		{
			$tempAssetGroupInfo = @()
		                            
                                $props = @{
				userlogin=$($item.ASSIGNED_USERS.ASSIGNED_USER[$u
                                    ].LOGIN.InnerText)
				userrole=$($item.ASSIGNED_USERS.ASSIGNED_USER[$u
                                    ].ROLE.InnerText)
                                           assetgrouptitle=$($item.TITLE.InnerText)
                                           ip=$($item.SCANIPS.IP)
                                }
		
			$tempAssetGroupInfo = New-Object PSObject -Property $props
		        
                                $results += $tempAssetGroupInfo
                            }
                        }
                    }
[/code
                    ]

Now, we can either simply put the following line in our End block: [code
                    ]
return $results
[/code
                    ]

But, I actually like it to be saved into an XML file. This means that I can use this data with other functions without having to call Qualys again. To be quite frank, as you may know, Qualys is not the fastest website/service out there. Don't get me wrong, the scanning engines are fast, but their database(s) - not so much.

To return both the object and export the results to an XML, we can just add this one line of code: [code
                    ]
Export-Clixml -Path &quot;$env:USERPROFILE\Desktop\QualysData\assetgroupinfo.xml&quot; -InputObject $results
[/code
                    ]

That's it. We now have a function that can return some details about our Asset Groups within Qualys. Next time, I will focus on creating a function that gathers our enrolled IP Addresses, split's them into a single list.

Hint: Qualys loves IP ranges (192.168.0.1-192.168.0.123) and their API calls return it the same way. :)
