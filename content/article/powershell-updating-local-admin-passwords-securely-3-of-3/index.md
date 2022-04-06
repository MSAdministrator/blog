---
title: "Powershell Updating Local Admin Passwords Securely 3 of 3"
date: 2018-08-07T20:43:52-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
Below is an example of how to remotely (using PowerShell) update and change the Local Administrator password securely.  This is not my script, I received this script along with many others from the SANS SEC 505 course.  I have not altered it in any way.
<div>

Updating the Passwords of the Local Administrator on remote mahcines (You must have a Certificate either from your CA or another Certificate Authority):

This script will remove older local administrator passwords that you have created with the first part (1 of 3) which is decrypted by your Private Key Certificate in (2 of 3).

Copy this text into a PowerShell Script called CleanUp_PasswordArchive.ps1

[code
                    ]

####################################################################################
#.Synopsis
# Carefully delete only the correct password archive files previously
# created with the companion script named Update-PasswordArchive.ps1.
#
#.Description
# Deletes older password archive files while retaining a chosen number
# (default = 5) of prior successful and failed archive files for each
# unique combination of computer and user (total of 10 files by default
# for each unique combination). Scheduling this script will help to
# maintain a reasonable number of password archive files.
#
#.Parameter PasswordArchivePath
# The local or UNC path to where the encrypted password files are kept.
#
#.Parameter ComputerName
# Name of the computer with the local account whose password was reset
# and whose password was encrypted and saved to a file. The computer
# name will match the names of files in the PasswordArchivePath. This
# parameter can accept a computer name with a wildcard in it. When
# specified, only the archives for that computer (or for those matching
# computers with a wildcard) will be cleaned up instead of the default,
# which is to clean up archive files for all computers.
#
#.Parameter ArchivesToKeep
# The number of current and prior password archive files to keep for
# each combination of computer name and user name. A single computer
# might have multiple local user accounts whose passwords are managed
# by these scripts, so the clean up must handle this gracefully. The
# default is 5 (5 successful files + 5 failures files = 10 files).
#
#.Parameter VerboseReporting
# Switch to show verbose information.
#
#.Parameter DoNotDelete
# Switch to do a -WhatIf dry run that will not actually delete any
# files. Use this switch along with -VerboseReporting for testing.
#
#.Parameter DeleteAllPasswordArchives
# Switch to delete all password archive files without exception.
#
#.Example
# .\CleanUp-PasswordArchive.ps1 -PasswordArchivePath \\server\share
#
# Deletes all but the last 5 password archive files for each computer
# and user combination. Also, deletes all but the last 5 failure-type
# files for each combination. Hence, if the last successful reset was
# six months ago, followed by many failures, the last 5 successful
# reset archive files will *not* be deleted.
#
#.Example
# .\CleanUp-PasswordArchive.ps1 -PasswordArchivePath \\server\share -ComputerName WKS*
#
# Only cleans up the archive files for computers which match the &quot;WKS*&quot; file
# pattern. A full computer name can be specified, wildcards are not required.
# Regular expressions are not supported.
#
#.Example
# .\CleanUp-PasswordArchive.ps1 -PasswordArchivePath \\server\share -DoNotDelete -VerboseReporting
#
# No files will be deleted, but a verbose report of files discovered will be shown.
#
#
#Requires -Version 2.0
#
#.Notes
# Author: Jason Fossen, Enclave Consulting (http: //www.sans.org/windows-security/)
# Version: 1.0
# Updated: 11.Nov.2012
# LEGAL: PUBLIC DOMAIN. SCRIPT PROVIDED &quot;AS IS&quot; WITH NO WARRANTIES OR GUARANTEES OF
# ANY KIND, INCLUDING BUT NOT LIMITED TO MERCHANTABILITY AND/OR FITNESS FOR
# A PARTICULAR PURPOSE. ALL RISKS OF DAMAGE REMAINS WITH THE USER, EVEN IF
# THE AUTHOR, SUPPLIER OR DISTRIBUTOR HAS BEEN ADVISED OF THE POSSIBILITY OF
# ANY SUCH DAMAGE. IF YOUR STATE DOES NOT PERMIT THE COMPLETE LIMITATION OF
# LIABILITY, THEN DELETE THIS FILE SINCE YOU ARE NOW PROHIBITED TO HAVE IT.
####################################################################################
Param ($PasswordArchivePath = &quot;.\&quot;, $ComputerName = &quot;*&quot;, $ArchivesToKeep = 5,
                    [Switch
                    ] $VerboseReporting,
                    [Switch
                    ] $DoNotDelete,
                    [Switch
                    ] $DeleteAllPasswordArchives)

# Test access to path.
if (Resolve-Path -Path $PasswordArchivePath)
{ $PasswordArchivePath = $(Resolve-Path -Path $PasswordArchivePath).Path
                    }
else
{ &quot;`nERROR: Cannot resolve path to archive folder: $PasswordArchivePath `n&quot; ; exit
                    }
# Sanity check on $ArchivesToKeep
if ($ArchivesToKeep -le 0) { &quot;`nERROR: The -ArchivesToKeep argument must be 1 or larger.`n&quot; ; exit
                    }
# Get all matching files.
$filter = $($ComputerName + &quot;*+*+*+*&quot;).Replace(&quot;**&quot;,&quot;*&quot;)
$files = dir -Path $PasswordArchivePath -Filter $filter
if ($VerboseReporting)
{
 &quot;`nTotal number of matching ($ComputerName) archive files = &quot; + $files.count
 $files | foreach { $_.fullname
                        }
 &quot;`n&quot;
                    }
# Maybe just delete them all.
if ($DeleteAllPasswordArchives -and $DoNotDelete) { &quot;`nERROR: Invalid combination of switches.`n&quot; ; exit
                    }
if ($DeleteAllPasswordArchives -and $ComputerName -ne &quot;*&quot;) { &quot;`nERROR: Invalid combination of switches.`n&quot; ; exit
                    }
if ($DeleteAllPasswordArchives)
{
 &quot;`nDeleting all password archive files...`n&quot;
 $files | foreach { remove-item $_
                        }
 exit
                    }
# Separate successful vs. failed password reset files.
$failurefiles = $files | where { $_.Name -like &quot;*FAILURE&quot;
                    }
$successfiles = $files | where { $_.Name -notlike &quot;*FAILURE&quot;
                    }
if ($VerboseReporting) { &quot;Files for failed resets = &quot; + $failurefiles.count
                    }
if ($VerboseReporting) { &quot;Files for successful resets = &quot; + $successfiles.count
                    }
# Build arrays of unique computername+username combinations.
$failurenames = @()
$successnames = @()

foreach ($file in $failurefiles)
{
 $computer = $($file.name -split '\+')[
                            0
                        ] + &quot;+&quot; + $($file.name -split '\+')[
                            1
                        ]
 if ($computer -notin $failurenames){ $failurenames += $computer
                        }
                    }
if ($VerboseReporting) { &quot;`nUnique Computer+User combinations for failed resets = &quot; + $failurenames.count
                    }
if ($VerboseReporting) { $failurenames ; &quot;`n&quot;
                    }

foreach ($file in $successfiles)
{
 $computer = $($file.name -split '\+')[
                            0
                        ] + &quot;+&quot; + $($file.name -split '\+')[
                            1
                        ]
 if ($computer -notin $successnames){ $successnames += $computer
                        }
                    }
if ($VerboseReporting) { &quot;Unique Computer+User combinations for successful resets = &quot; + $successnames.count
                    }
if ($VerboseReporting) { $successnames ; &quot;`n&quot;
                    }
# Delete the non-keepers for each unique name.
$SuccessFileCounter = $FailureFileCounter = 0

foreach ($name in $failurenames)
{
 $targets = $failurefiles | where { $_.Name -like ($name + &quot;+*&quot;)
                        } | sort Name
 if ($targets.count -le $ArchivesToKeep) { continue
                        }
 0..$($targets.count - $ArchivesToKeep - 1) |
 foreach { if (-not $DoNotDelete){remove-item $targets[$_
                                ].fullname ; if($?){$FailureFileCounter++
                                }
                            }
                        }
                    }

foreach ($name in $successnames)
{
 $targets = $successfiles | where { $_.Name -like ($name + &quot;+*&quot;)
                        } | sort Name
 if ($targets.count -le $ArchivesToKeep) { continue
                        }
 0..$($targets.count - $ArchivesToKeep - 1) |
 foreach { if (-not $DoNotDelete){remove-item $targets[$_
                                ].fullname ; if($?){$SuccessFileCounter++
                                }
                            }
                        }
                    }
# Default Report
[String
                    ] $SuccessFileCounter + &quot; files deleted out of the set of &quot; + [String
                    ] $successfiles.count + &quot; successful reset files.&quot;
[String
                    ] $FailureFileCounter + &quot; files deleted out of the set of &quot; + [String
                    ] $failurefiles.count + &quot; failure reset files.&quot;
&quot;`n&quot;

&amp;nbsp;

[/code
                    ]

</div>
