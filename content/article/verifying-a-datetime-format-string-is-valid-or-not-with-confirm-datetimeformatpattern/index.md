---
title: "Verifying a Datetime Format String Is Valid or Not With Confirm Datetimeformatpattern"
date: 2018-08-07T20:45:28-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
Early this evening I sent <a href="https://twitter.com/MS_dministrator/status/962782272826077184">this</a> tweet out regarding a #PowerShell Function I wrote called <a href="https://gist.github.com/MSAdministrator/b2c3ace163c4fbf76069503528de6cf1">Confirm-DateTimeFormatPattern</a> and <a href="https://twitter.com/dan_franciscus">Dan Franciscus (@dan_franciscus</a>) recommend that I should blog about it, so here it goes!

<a href="http://msadministrator.com/?attachment_id=448" rel="attachment wp-att-448"><img class="alignnone size-full wp-image-448" src="https://msadministrator.files.wordpress.com/2018/02/screen-shot-2018-02-11-at-10-29-57-pm.png" alt="" width="605" height="417" /></a>

To elaborate on that tweet, this Function spawned from a larger initiative that I am working on for a presentation I'm giving at <a href="http://sched.co/Cqc6">PowerShell Summit 2018</a> in April.  That presentation will be about a PowerShell Module I have built called PSLogging, which is a logging framework built using PowerShell Classes.

One of the items on my to-do list, which always seems to grow and not shrink, is to add a configuration component.  This configuration component would allow someone to create a config.json or config.yml file that would be referenced when logging within their application/script/function/etc.  Here is a quick example of what the configuration may (work in-progress) look like:

<a href="http://msadministrator.com/?attachment_id=449" rel="attachment wp-att-449"><img class="alignnone size-full wp-image-449" src="https://msadministrator.files.wordpress.com/2018/02/screen-shot-2018-02-11-at-10-37-02-pm.png" alt="" width="472" height="390" /></a>

Within this configuration file I would allow someone to specify the "log level" and all the available formatting options.  As you can see in the image above, one such configuration option is that ability to specify the <em>datetime</em> format, a <em>filename</em>, <em>encoding</em>, etc.  But the point of this post is specifically about the <em>datetime</em> format option.

I needed (wanted) a way to identify if the provided format string in the <em>datetime</em> configuration option is an actual valid [DATETIME
                                        ] format string value.  If you are not familiar with this concept, then please see the below example when using the <em>Get-Date</em> Cmdlet: [code language="powershell"]
PS /Users/josh.rickard&gt; Get-Date -Format "yyyy-MM-dd HH:mm:ss"
2018-02-11 22: 43: 05
[/code
                                            ]

To further explain, I will show you a snippet of PowerShell code and the corresponding Class that does exactly what I described above and it may shed some light on the "why". Imagine you have a JSON configuration file, but it has multiple options available and only certain options are "mandatory". You would first need to load the content from that JSON file and then convert it using the <code>ConvertFrom-Json</code> Cmdlet. The next step is that you would need to iterate through the configuration and identify (and verify) each piece of configuration before you rely on it, right? Here's an example of just that:

[code language="powershell"]
$JsonConfigurationFile = 'C:\_Github\PSLogging\PSLogging\config\logging.json'
$JsonConfig = Get-Content -Path $JsonConfigurationFile | ConvertFrom-Json
$FormatObject = @()

foreach($output in $JsonConfig.outputs)
{
    if ($output.PSObject.Properties.Name -eq 'console')
    {
        if ([DateTimeValidation
                                                        ]: :validateDateTimePatterns($output.console.datetime))
        {
                                                            [ConsoleConfiguration
                                                            ]: :setConsoleConfiguration($output.console.level, $output.console.datetime)
                                                        }
        else
        {
            Write-Error -Message 'Error!  Could not Validate Date Time Patterns!'
            Throw
                                                        }
                                                    }
                                                }
[/code
                                                ]
As you can see, we loop through the first time and identify if the <code>console</code> setting was set, if it was then we would need to check and see if the passed in [datetime
                                                ] format string is correct, if it is then set our console configuration (if you're following along, let me tell you there are other forms of validation this is just an example). :)

Now, to show you the [DateTimeValidation
                                                ] Class that is doing all the magic. Additionally, I have a ConsoleConfiguration Class and a LogLevel Enum but we won't get into the details of those at this time: [code language="powershell"]
enum LogLevel
{
    INFO
    DEBUG
    SUCCESS
    WARNING
    ERROR
                                                    }

Class DateTimeValidation
{
    static [string
                                                        ] $DateTimePattern

    static [bool
                                                        ] validateDateTimePatterns([string
                                                        ]$Pattern)
    {
        $TimePatterns = [System.Globalization.DateTimeFormatInfo
                                                            ]: :CurrentInfo

        foreach ($item in $TimePatterns.GetAllDateTimePatterns())
        {
            if ($Pattern -eq $item)
            {
                                                                    [DateTimeValidation
                                                                    ]: :DateTimePattern = $Pattern
                return $true
                                                                }
                                                            }
        return $false
                                                        }
                                                    }

# Define a class
class ConsoleConfiguration
{
   static [LogLevel
                                                        ] $LogLevel
   static [DateTimeValidation
                                                        ] $DateTimeFormat

   # Static method
   static [void
                                                        ] setConsoleConfiguration([LogLevel
                                                        ]$Level,
                                                        [string
                                                        ]$DateTimeFormat)
   {
        $DateTimeFormat
        [ConsoleConfiguration
                                                            ]: :LogLevel = $Level
        [ConsoleConfiguration
                                                            ]: :DateTimeFormat = $DateTimeFormat
                                                        }
                                                    }
[/code
                                                    ]
To briefly explain, we call the [DateTimeValidation
                                                    ] Class from within our If statement above. This call then validates that our passed in [string
                                                    ] format is valid (or not) based on the current Culture/Globalization settings. Once the provided string data has been validated, then we can proceed to add it to our [ConsoleConfiguration
                                                    ] Class. The great thing about this class is that I can just reuse it, over and over and over.

Now, let's get back to the actual function and not all this Class non-sense. I ported over the logic from a Class in my PSLogging Module because I thought it would be useful to validate this type of input. In #PowerShell, especially Advanced Functions, we learn/preach/teach that we should always validate our inputs and ensure our outputs are what the user expects - this is crucial in any language. If you are familiar with Parameter Validation on PowerShell Functions then this should come at no surprise to you. <strong>We should ALWAYS validate our data!</strong>

This function is no different. You may not have a use case for it now, and this is NOT revolutionary at all, but there may come a time when you need to validate those pesky string formatting rules and I hope this function helps out.

You can find the GIST here: https: //gist.github.com/MSAdministrator/b2c3ace163c4fbf76069503528de6cf1

And the full code here for the lazy: [code language="powershell"]
.Synopsis
    Confirm if a date time format pattern is valid or not 
.DESCRIPTION
    Confirm if a date time format pattern is valid or not     
    based on the current culture on the machine that this function     
    is being ran on 
.EXAMPLE 1 
    PS C:\&gt; Confirm-DateTimeFormatPattern -Format "yyyy-MM-dd HH:mm:ss"

    Format              Valid
    ------              -----
    yyyy-MM-dd HH:mm:ss  True

.EXAMPLE 2
    PS C:\&gt; Confirm-DateTimeFormatPattern -Format "yyyy-MM-dd HH:mm:ss", "xxx-MM/dd/yy"

    Format              Valid
    ------              -----
    yyyy-MM-dd HH:mm:ss  True
    xxx-MM/dd/yy        False

.EXAMPLE 3
    PS C:\&gt; "yyyy-MM-dd HH:mm:ss", "xxx-MM/dd/yy", "MMMM d", "yyyy'-'MM'-'dd'T'HH':'mm':'ss.fffffffK" | Confirm-DateTimeFormatPattern

    Format                                 Valid
    ------                                 -----
    yyyy-MM-dd HH:mm:ss                     True
    xxx-MM/dd/yy                           False
    MMMM d                                  True
    yyyy'-'MM'-'dd'T'HH':'mm':'ss.fffffffK  True
[/code
                                                        ]
[code language="powershell"]
function Confirm-DateTimeFormatPattern
{
                                                                [CmdletBinding()
                                                                ]
    [Alias()
                                                                ]
    [OutputType([PSCustomObject
                                                                    ])
                                                                ]
    Param
    (
        # Param1 help description
        [Parameter(Mandatory=$true,
                   ValueFromPipeline=$true,
                   ValueFromPipelineByPropertyName=$true,
                   Position=0)
                                                                ]
        [string[]
                                                                ]$Format
    )

    Begin
    {
        $CultureObject = ([System.Globalization.DateTimeFormatInfo
                                                                    ]: :CurrentInfo).GetAllDateTimePatterns()
                                                                }
    Process
    {
        foreach ($item in $Format)
        {
            if ($CultureObject -contains $item)
            {
                $props = [PSCustomObject
                                                                            ]@{
                    'Format' = $item
                    'Valid'  = $true
                                                                            }
                Write-Output $props
                                                                        }
            else
            {
                $props = [PSCustomObject
                                                                            ]@{
                    'Format' = $item
                    'Valid'  = $false
                                                                            }
                Write-Output $props
                                                                        }
                                                                    }
                                                                }
    End
    {
        # Intentionally Left Blank
                                                                }
                                                            }
[/code
                                                            ]
