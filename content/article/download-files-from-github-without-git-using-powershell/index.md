---
title: "Download Files From Github Without Git Using Powershell"
date: 2018-08-07T20:44:52-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
Have you ever needed to download code or a repository from Github, but didn't want to download and install Git on a machine, create an SSH key, etc. If so, I have something that you may like.

You can find the entire function here: <a href="https://github.com/MSAdministrator/GetGithubRepository">https://github.com/MSAdministrator/GetGithubRepository</a>

To use this function, you will need to know the path to the Github repository (of course) you want to download.  Once you have that URL, you will need to pass each piece of the URL into a parameter on the function.

For example, let's take a URL like https: //github.com/MSAdministrator/WriteLogEntry.  This URL can be broken down as follows
<ul>
 	<li>MSAdministrator = Owner</li>
 	<li>WriteLogEntry = Repository</li>
</ul>
We also know that we want to download the "master" branch of this repository.  The next part is that we need to gather a list of files/paths that we need to download as well.  These will be passed as an array of strings to the FilePath parameter.
<ul>
 	<li>Branch = Master (unless you want a different branch)</li>
 	<li>FilePath = (Files and paths you want to download)</li>
</ul>
By default this function will always get the master branch of the repository you are wanting to download, but you can specify a different branch if wanted.  Additionally, this function will download the specified files to your user profiles Module Path (C:\users\some_user\Documents\WindowsPowerShell\Modules)

To use this function, you will need to pass the following values as parameters to the function.  For example, to download my WriteLogEntry repository you will need to call the function like so:<code>
Get-GithubRepository -Owner MSAdministrator -Repository WriteLogEntry -Verbose -FilePath `
'WriteLogEntry.psm1',
'WriteLogEntry.psd1',
'Public',
'en-US',
'en-US\about_WriteLogEntry.help.txt',
'Public\Write-LogEntry.ps1'</code>

I hope that this function helps some of you who want to quickly download a Github repository without installing or using Git.  If you have issues or like this function, please submit issues or fork requests to my Github.

Enjoy!

Original Image here: <img src="http://s.quickmeme.com/img/e0/e0d4afacba74c1b28ae4caad6f98e9d2d1689fe8e43dc1ee680214c75eb24e17.jpg" />
