---
title: "Powershell Scripts Functions Modules Cmdlets Oh My"
date: 2018-08-15T11:54:36-04:00
draft: false

categories: [powershell]
tags: [scripts,functions,modules]
author: "Josh Rickard"
---
PowerShell is unique, but it is also necessary in today's world.  I find that newcomers to the language are sometimes confused or don't understand the basic layers of PowerShell scripting.  You can use PowerShell in different ways, but I have yet to find an all encompassing article that explains the high-level of how to interact with PowerShell in these ways.

This post will explain the main advantages and use cases of invoking PowerShell for newcomers to the language.  We will dive into the different approaches of implementing PowerShell and why you would use one over the other.  

## Console

The PowerShell console is Windows shell environment that is used to invoke the built-in CmdLets provided by the PowerShell language.  The console is traditionally used when you want to run one-off comamnds or to invoke other custom scripts, functions, modules, cmdlets, etc.  A typical PowerShell `developer` will use the console to quickly do a single action.  For example, if you wanted to identify running processes on a computer you would run the `Get-Process` CmdLet.  You probably would not write a script or function to invoke this simple command unless you wanted to do further action against a process or format the output.  

The PowerShel console is great for these quick and dirty commands, but you would not "want to" write tons of logic in the console. Instead, you would proably write that logic in a script or function.  I consider the use of the PowerShell console a quick way of proving that your thoughts or logic will work and not necessarily the final product.  If all you need to do is `Get-Process -Name notepad | Stop-Process` then just typing that in the console is all you need.  Great!  If you need a little more logic or flow control in your efforts then you will proably choose to write a PowerShell script or function.

<img src="PowerShell Console - Get and Stop Process.gif" style="max-width:100%;" alt="PowerShell Console - Get and Stop Process">

## Scripts

