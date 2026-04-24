---
title: "Powershell Updating Local Admin Passwords Securely 1 of 3"
date: 2018-08-07T20:43:47-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
So I haven't posted in a bit but I've seen this request many times.  Below is an example of how to remotely (using PowerShell) update and change the Local Administrator password securely.  This is not my script, I received this script along with many others from the SANS SEC 505 course.  I have not altered it in any way.

Updating the Passwords of the Local Administrator on remote mahcines (You must have a Certificate either from your CA or another Certificate Authority):

This script will update the local administrator password with a unique 15 character, random, complex password, which is encrypted by your Public Key Certificate.

Copy this text into a PowerShell Script called Update_PasswordArchive.ps1

<strong>Also, see below for a readme file for more explanation!</strong>

[code
                    ]

####################################################################################
#.Synopsis
# Resets the password of a local user account with a 15-character, random,
# complex password, which is encrytped with a chosen pubic key certificate. The
# plaintext password is displayed with the Recover-PasswordArchive.ps1 script.
#
#.Description
# Resets the password of a local user account with a 15-character, random,
# complex password, which is encrytped with a chosen pubic key certificate.
# Recovery of the encrypted password from the file requires possession of the
# private key corresponding to the chosen public key certificate. The password
# is never transmitted or stored in plaintext anywhere. The plaintext password
# is recovered with the companion Recover-PasswordArchive.ps1 script. The
# script must be run with administrative or Local System privileges.
#
#.Parameter CertificateFilePath
# The local or UNC path to the .CER file containing the public key
# certificate which will be used to encrypt the password. The .CER
# file can be DER- or Base64-encoded. Any certificate with any
# purpose(s) from any template can be used.
#
#.Parameter LocalUserName
# Name of the local user account on the computer where this script is run
# whose password should be reset to a 15-character, complex, random password.
# Do not include a &quot;\&quot; or &quot;@&quot; character, only local accounts are supported.
# Defaults to &quot;Administrator&quot;, but any name can be specified.
#
#.Parameter PasswordArchivePath
# The local or UNC path to the folder where the archive files containing
# encrypted passwords will be stored.
#
#
#.Example
# .\Update-PasswordArchive.ps1 -CertificateFilePath C:\certificate.cer -PasswordArchivePath C:\folder
#
# Resets the password of the Administrator account, encrypts that password
# with the public key in the certificate.cer file, and saves the encrypted
# archive file in C:\folder.
#
#.Example
# .\Update-PasswordArchive.ps1 -CertificateFilePath \\server\share\certificate.cer -PasswordArchivePath \\server\share
#
# UNC network paths can be used instead of local file system paths. Password
# is not reset until after network access to the shared folder is confirmed.
# The certificate and archive folders do not have to be the same.
#
#.Example
# .\Update-PasswordArchive.ps1 -LocalUserName HelpDeskUser -CertificateFilePath \\server\share\certificate.cer -PasswordArchivePath \\server\share
#
# The local Administrator account's password is reset by default, but any
# local user name can be specified instead.
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
Param ($CertificateFilePath = &quot;.\PublicKeyCert.cer&quot;, $LocalUserName = &quot;Administrator&quot;, $PasswordArchivePath = &quot;.\&quot;)
####################################################################################
# Function Name: Generate-RandomPassword
# Argument(s): A single argument, an integer for the desired length of password.
# Returns: Pseudo-random complex password that has at
# least one of each of the following character types:
# uppercase letter, lowercase letter, number, and
# legal non-alphanumeric.
# Note: # and &quot; and &lt;space&gt; are excluded to make the
# function play nice with other scripts. Extended
# ASCII characters are not included either. Zero and
# capital O are excluded to make it play nice with humans.
# Note: If the argument/password is less than 4 characters
# long, the function will return a 4-character password
# anyway. Otherwise, the complexity requirements won't
# be satisfiable.
####################################################################################
Function Generate-RandomPassword ($length = 15)
{
 If ($length -lt 4) { $length = 4
                        } #Password must be at least 4 characters long in order to satisfy complexity requirements.

 Do {
 $password = $null
 $hasupper = $false #Has uppercase letter character flag.
 $haslower = $false #Has lowercase letter character flag.
 $hasnumber = $false #Has number character flag.
 $hasnonalpha = $false #Has non-alphanumeric character flag.
 $isstrong = $false #Assume password is not strong until tested otherwise.

 For ($i = $length; $i -gt 0; $i--)
 {
 $x = get-random -min 33 -max 126 #Random ASCII number for valid range of password characters.
 #The range eliminates the space character, which causes problems in other scripts.
 If ($x -eq 34) { $x--
                                } #Eliminates double-quote. This is also how it is possible to get &quot;!&quot; in a password character.
 If ($x -eq 39) { $x--
                                } #Eliminates single-quote, also causes problems in scripts.
 If ($x -eq 48 -or $x -eq 79) { $x++
                                } #Eliminates zero and capital O, which causes problems for humans.

 $password = $password + [System.Char
                                ] $x #Convert number to an ASCII character, append to password string.

If ($x -ge 65 -And $x -le 90) { $hasupper = $true
                                }
 If ($x -ge 97 -And $x -le 122) { $haslower = $true
                                }
 If ($x -ge 48 -And $x -le 57) { $hasnumber = $true
                                }
 If (($x -ge 33 -And $x -le 47) -Or ($x -ge 58 -And $x -le 64) -Or ($x -ge 91 -And $x -le 96) -Or ($x -ge 123 -And $x -le 126)) { $hasnonalpha = $true
                                }
 If ($hasupper -And $haslower -And $hasnumber -And $hasnonalpha) { $isstrong = $true
                                }
                            }
                        } While ($isstrong -eq $false)

 $password
                    }

&amp;nbsp;

####################################################################################
# Writes to console, writes to Application event log, optionally exits.
# Event log: Application, Source: &quot;PasswordArchive&quot;, Event ID: 9013
####################################################################################
function Write-StatusLog ( $Message,
                    [Switch
                    ] $Exit )
{
 # Define the Source attribute for when this script writes to the Application event log.
 New-EventLog -LogName Application -Source PasswordArchive -ErrorAction SilentlyContinue

&quot;`n&quot; + $Message + &quot;`n&quot;

#The following here-string is written to the Application log only when there is an error,
#but it contains information that could be useful to an attacker with access to the log.
#The data is written for troubleshooting purposes, but feel free change it if concerned.
$ErrorOnlyLogMessage = @&quot;
$Message

CurrentPrincipal = $($CurrentPrincipal.Identity.Name)

CertificateFilePath = $CertificateFilePath

LocalUserName = $LocalUserName

PasswordArchivePath = $PasswordArchivePath

ArchiveFileName = $filename

NET.EXE Output = $netout
&quot;@

if ($Exit)
 { write-eventlog -logname Application -source PasswordArchive -eventID 9013 -message $ErrorOnlyLogMessage -EntryType Error
                        }
 else
 { write-eventlog -logname Application -source PasswordArchive -eventID 9013 -message $Message -EntryType Information
                        }

if ($Exit) { exit
                        }
                    }

&amp;nbsp;
# Confirm that this process has administrative privileges to reset a local password.
$CurrentWindowsID = [System.Security.Principal.WindowsIdentity
                    ]: :GetCurrent()
$CurrentPrincipal = new-object System.Security.Principal.WindowsPrincipal($CurrentWindowsID)
if (-not $? -or -not $CurrentPrincipal.IsInRole(&quot;Administrators&quot;))
 { write-statuslog -m &quot;ERROR: This process lacks the privileges necessary to reset a password.&quot; -exit
                    }

&amp;nbsp;

# Confirm that the target local account exists and that NET.EXE is executable by this process.
if ($LocalUserName -match '[\\@
                    ]') { write-statuslog -m &quot;ERROR: This script can only be used to reset the passwords of LOCAL user accounts, please specify a simple username without an '@' or '\' character in it.&quot; -exit
                    }
$netusers = invoke-expression -Command $($env:systemroot + &quot;\system32\net.exe user&quot;)
if (-not $($netusers | select-string &quot;$LocalUserName&quot; -quiet)) { write-statuslog -m &quot;ERROR: Local user does not exist: $LocalUserName&quot; -exit
                    }

&amp;nbsp;

# Get the public key certificate.
if (Resolve-Path -Path $CertificateFilePath)
{ $CertificateFilePath = $(Resolve-Path -Path $CertificateFilePath).Path
                    }
else
{ write-statuslog -m &quot;ERROR: Cannot resolve path to certificate file: $CertificateFilePath&quot; -exit
                    }
if ($CertificateFilePath -ne $null -and $(test-path -path $CertificateFilePath))
{
                        [Byte[]
                        ] $certbytes = get-content -encoding byte -path $CertificateFilePath #Trick to support UNC paths here.
 $cert = new-object System.Security.Cryptography.X509Certificates.X509Certificate2(,$certbytes)
 if (-not $? -or ($cert.GetType().fullname -notlike &quot;*X509*&quot;))
 { write-statuslog -m &quot;ERROR: Invalid or corrupt certificate file: $CertificateFilePath&quot; -exit
                        }
                    }
else
{ write-statuslog -m &quot;ERROR: Could not find the certificate file: $CertificateFilePath&quot; -exit
                    }

&amp;nbsp;

# Construct name of the archive file, whose name will also be used as a nonce.
$filename = $env:computername + &quot;+&quot; + $LocalUserName + &quot;+&quot; + $(get-date).ticks + &quot;+&quot; + $cert.thumbprint
if ($filename.length -le 60) { write-statuslog -m &quot;ERROR: The archive file name is invalid (too short): $filename &quot; -exit
                    }

&amp;nbsp;

# Prepend first 60 characters of the $filename as a nonce to the new password (as a byte array).
$newpassword = &quot;ConfirmThatNewPasswordIsRandom&quot;
$newpassword = Generate-RandomPassword
if ($newpassword -eq &quot;ConfirmThatNewPasswordIsRandom&quot;) { write-statuslog -m &quot;ERROR: Password generation failure, password not reset.&quot; -exit
                    }
$bytes = [byte[]
                    ][char[]
                    ] $filename.substring(0,
                    60)
$bytes += [byte[]
                    ][char[]
                    ] $newpassword

&amp;nbsp;

# Encrypt the nonce+password string.
$cipherbytes = $cert.publickey.key.encrypt($bytes,$false) #Must be $false for my smart card to work.
if (-not $? -or $cipherbytes.count -lt 60) { write-statuslog -m &quot;ERROR: Encryption failed, password not reset.&quot; -exit
                    }

&amp;nbsp;

# Must save encrypted password before resetting, confirm that it actually worked.
if (Resolve-Path -Path $PasswordArchivePath)
{ $PasswordArchivePath = $(Resolve-Path -Path $PasswordArchivePath).Path
                    }
else
{ write-statuslog -m &quot;ERROR: Cannot resolve path to archive folder: $PasswordArchivePath&quot; -exit
                    }

if (-not $(test-path -pathtype container -path $PasswordArchivePath))
{ write-statuslog -m &quot;ERROR: Archive path not accessible: $PasswordArchivePath&quot; -exit
                    }

if ($PasswordArchivePath -notlike &quot;*\&quot;) { $PasswordArchivePath = $PasswordArchivePath + &quot;\&quot;
                    }

$cipherbytes | set-content -encoding byte -path ($PasswordArchivePath + $filename)

if (-not $?) { write-statuslog -m &quot;ERROR: Failed to save archive file, password not reset.&quot; -exit
                    }

if (-not $(test-path -pathtype leaf -path $($PasswordArchivePath + $filename))){ write-statuslog -m &quot;ERROR: Failed to find archive file, password not reset.&quot; -exit
                    }

&amp;nbsp;

# Attempt to reset password by hopefully satisfying length and complexity requirements.
$netout = Invoke-Expression -Command $($env:systemroot + &quot;\system32\net.exe user $LocalUserName &quot; + '&quot;' + $newpassword + '&quot;')
if (-not $? -or ($LASTEXITCODE -ne 0) -or ($netout -notlike &quot;*success*&quot;))
{
 # Write failure file to the archive path.
 $filename = $env:computername + &quot;+&quot; + $LocalUserName + &quot;+&quot; + $(get-date).ticks + &quot;+PASSWORD-RESET-FAILURE&quot;
 &quot;ERROR: Failed to reset password after creating a success file:`n&quot; + $netout | set-content -path ($PasswordArchivePath + $filename)
 write-statuslog -m &quot;ERROR: Failed to reset password after creating a success file:`n $netout&quot; -exit
                    }
else
{
 remove-variable -name newpassword #Just tidying up, not really necessary at this point...
 write-statuslog -m &quot;SUCCESS: $LocalUserName password reset and archive file saved.&quot;
                    }

[/code
                    ]

README.TXT

[code
                    ]&lt;/pre&gt;
**************************************
 Background:
**************************************
The passwords of local administrative accounts should be changed regularly and be different from one computer to the next. But how can this been done securely and conveniently?

The scripts in this project demonstrate how it can be done without spending a penny. The scripts are intended to be relatively easy to understand and modify (you don't have to be a PowerShell guru, only intermediate skills required). Error-checking was kept to a minimum to reduce clutter, but should be adequate for troubleshooting and preventing passwords from being reset when an archive file cannot be saved for it. All scripts are in the public domain. A sample certificate (CER) and private key file (PFX) are included for testing.

&amp;nbsp;

**************************************
 Solution:
**************************************
A trusted administrator should obtain a certificate and private key, then export that certificate to a .CER file into a shared folder (\\server\share\cert.cer).

Copy the Update-PasswordArchive.ps1 script into that shared folder (\\server\share).

Using Group Policy, SCCM, a third-party EMS, SCHTASKS.EXE or some other technique, create a scheduled job on every computer that runs once per week (or every night) under Local System context that executes the following command: &quot;powershell.exe \\server\share\update-passwordarchive.ps1 -certificatefilepath \\server\share\cert.cer -passwordarchivepath \\server\share&quot;. This resets the password on the local Administrator account, or whatever account is specified, with a 15-character, random complex password. The password is encrypted in memory with the public key of the certificate (cert.cer) and saved to an archive file to the specified share (\\server\share).

When a password for a computer (laptop47) needs to be recovered, the trusted administrator should run from their own local computer the following PowerShell script: &quot;recover-passwordarchive.ps1 -passwordarchivepath \\server\share -computername laptop47&quot;. This downloads the necessary encrypted files and decrypts them locally in memory using the private key of the administrator, displaying the plaintext password within PowerShell.

&amp;nbsp;

**************************************
 Notes:
**************************************
The password is never sent over the network in plaintext, never saved to disk in plaintext, and never exposed as a command-line argument, either when resetting the password or when recovering it later. The new password is generated randomly in the memory of the PowerShell process running on the computer where the password is reset. The process runs for less than a second in the background as Local System.

Different certificates can be used at different times, as long as their private keys are available to the administrator. When recovering a password, the correct certificate and private key will be used automatically. A smart card can be used.

If the shared folder is not accessible to the computer when the scheduled job runs, the password is not reset.

If multiple administrators must be able to recover the plaintext passwords, export the relevant certificate and private key to a PFX file and import it into each administrator's local profile.

&amp;nbsp;

**************************************
 Threats and Recommendations:
**************************************
Keep the private key for the certificate used to encrypt the password archive files secure, such as on a smart card. This is the most important factor.

Prevent modification of the Update-PasswordArchive.ps1 script itself by digitally signing the script, enforcing script signature requirements, and using restrictive NTFS permissions. Only allow NTFS read access to the script to those identities (computer accounts) which need to run it or to edit it.

Attackers may try to delete or corrupt the existing password archive files to prevent access to current passwords. It's best to store the certificate and archive files in a shared folder whose NTFS permissions only allow the client computer accounts the following permissions:

Principal: Domain Computers
 Apply to: This folder, subfolders and files
 Allow: Full Control
 Deny: Delete subfolders and files
 Deny: Delete
 Deny: Change permissions
 Deny: Take ownership
 Deny: Create folders/append data

Principal: Domain Computers
 Apply to: Files only
 Deny: Create files/write data

The trusted administrator(s) can be granted Full Control to the archive files, certificates, and scripts as needed.

Attackers might also try to generate spoofed archive files and add them to the shared folder. The files are not digitally signed, but there is a crude integrity checking feature (signature-security through obscurity?) built into the scripts: the name of the archive file is also encrypted into the contents of the file along with the password. The Recover-PasswordArchive.ps1 script outputs objects which include a &quot;Valid&quot; property, which if false, indicates verification failure. To deal with spoofed files, you can delete all files with timestamps after the beginning of the attack which are Valid = False. NTFS auditing on the share will also log which computer(s) added the suspicious files and when, which provides another source of information to determine which new files are spoofed. Because attackers can presumably run commands as Local System on the machine(s) taken over, the attackers will be able to read the Update-PasswordArchive.ps1 script and the public key CER file out of the shared folder too, hence, the attackers will be able to defeat this crude integrity check if they wish to spoof the creation of new archive files. Adding true digital signatures to the archive files would add significant complexity with little benefit because we must assume the attackers can extract any signing keys from kernel memory on the computers they have already compromised. Realistically, though, this DoS attack would likely be of low value for an adversary expending this much effort, it would tip their hand, and the benefit to us of managing local administrative account passwords correctly far exceeds the potential negative of this sort of DoS attack.

Whole drive encryption of the server is recommended, but not really necessary since each password archive file is already encrypted.

IPSec or SMB encryption to the server is recommended, but not really necessary since each password archive file is already encrypted. On the other hand, IPSec port permissions which limit access to the SMB ports (TCP 139/445) is recommended, but not primarily for the encryption, but for restricting access based on group memberhips.

Back up the server with the shared folder every night and keep at least 30 days of prior backups to help deal with the threat of spoofing new archive files to flush out the current valid ones.

If the private key for the certificate is compromised, create a new key pair, replace the certificate file (.CER) in the shared folder, and immediately remotely trigger the scheduled job on all machines using Group Policy, SCHTASKS.EXE or some other technique.

&amp;nbsp;

**************************************
 Tips:
**************************************
Keep the number of files in the archive folder manageable by using the CleanUp-PasswordArchives.ps1 script. Perhaps running this script as a scheduled job every two or four weeks.

To optimize the performance of the Recover-PasswordArchive.ps1 script when there are more than 100,
                    000 files in the folder containing the password archives, disable 8.3 file name generation and strip all current 8.3 names on the volume containing that folder. Search the Internet on &quot;fsutil.exe 8dot3name&quot; to see how.

To maximize fault tolerance, use Distributed File System (DFS) shared folders across two or more servers.

The output of the Recover-PasswordArchive.ps1 script can be piped into other scripts to automate other tasks which require the plaintext password, such as executing commands, doing WMI queries, opening an RDP session, or immediately resetting the password again when finished.

You can also perform an immediate password update with commands like these wrapped in a function:

Copy-Item -Path .\PublicKeyCert.cer -Destination \\laptop47\c$
 Invoke-Command -ComputerName laptop47 -filepath .\Update-PasswordArchive.ps1 -argumentlist &quot;C:\publickeycert.cer&quot;,&quot;Administrator&quot;,&quot;c:\&quot;
 Copy-Item -Path \\laptop47\c$\laptop47+Administrator+* -Destination C:\LocalFolder
 Remove-Item -Path \\laptop47\c$\PublicKeyCert.cer
 Remove-Item -Path \\laptop47\c$\laptop47+Administrator+*

The above Invoke-Command can be done by specifying UNC paths, but this requires delegation of credentials to the remote computer, which is not ideal, so the certificate and archive files have to be copied back-and-forth manually.

[/code
                    ]
