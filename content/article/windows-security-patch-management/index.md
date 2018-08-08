---
title: "Windows Security Patch Management"
date: 2018-08-07T20:44:13-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
Recently, at work, I nominated myself to begin a "Windows Security" course for IT Professionals that I work with.  Being a former IT Pro, and now part of our security department as an Incident Responder, I thought I would create a course surrounding security.  So, i'm going to use my blog to layout my plans for this "Windows Security" course - which will hopefully be useful for others as well.

My first post is going to focus on "Patch Management".  Many IT Pro's, SysAdmins, etc. deploy assets (systems, applications, services, etc.) and join them to their domain, all while not being patched.  Having assets that are not fully patched is a major security risk for your organization.  Imagine, you have server that's not fully patched you've deployed (or someone else) on a Friday afternoon and then you become busy because of another incident.  Monday comes along and your slammed again - once again you forget about this server for some period of time.  We've all seen this happen or know of someone who does this.

In this situation, your Patch Management strategy is of the utmost importance.  Having this server on your network is a major security risk, but not if you have a fully patched image.  Whether you are using a fat, thin, zero-touch imaging solution, you need to make sure that your images are up to date and ready to deploy.

Using Microsoft Deployment Toolkit or SCCM (System Center Configuration Manager), can solve this problem with little to no interaction needed.  I'm personally a fan of MDT (check out my walk-through) in an large, decentralized, environment.  Utilizing MDT for your servers is extremely easy and gives your "System Administrators" a flexible and reliable solution for the many configurations your environment demands.

You can also use SCCM, if your environment can justify the cost, to automate this process to a complete "Zero-Touch" solution.  My environment does not allow this because we are not a centralized IT department with a standard "image" across all departments.  Setting up SCCM is cumbersome unless you have full access to the SCCM "site server(s)".  Never-the-less, SCCM is extremely powerful and can manage all systems (servers, workstations, etc.) in an automated way - but again, it's pricey.

If you choose to solely use a "fat" image and decide to just use a WinPE disc or even Windows Deployment Servers (WDS), just make sure that you update your image every month or at-least quarterly - and do not, I repeat, do not, join it to your domain/network without it being fully patched.

Deploying Operating Systems is a fairly complicated affair, and we need to utilize the tools available to us - but don't forget about our third party applications as well.  In my environment, most malware outbreaks are caused by either two types of incidents:
<ul>
	<li>Third party products are out of date and malware droppers are taking advantage (either in advertising sites or plan malicious sites) of these exploits.</li>
	<li>Phishing attempts</li>
</ul>
Maintaining our applications is also a crucial step that cannot be overlooked.  Again, you can utilize SCCM for this process (if you can justify it) or you can use additional third party products (Ninite, Secunia PSI, WSUS, etc.).  No matter what you use, you need to make sure that all of your systems are updated, and be able to report on this.

Having the ability to view your network/systems is a crucial part of a proper "Patch Management" strategy, so you need to have continual scanning on your network (with the ability to report on systems).  You can either use Nessus, SCCM, QualysGuard, etc., but no matter what, you need this data.  Again, utilize the tools you have - LEARN POWERSHELL!  PowerShell can give you crazy amounts of data - use it, love it, live it.

The last part of this discussion is about anti-virus/malware software.  Depending on the solution, your organization is using, you should be able to alert on infected systems.  If you're using Microsoft ForeFront Endpoint Protection, then well you may not be able to (besides using PowerShell to gather the log files). It would be preferred if you have a anti-virus/malware solution that has an administrative console or the ability to run reports.

If you don't have a A/V solution that has this capability, then you need to rely on your Windows Logs and parse them with either Splunk or LogStash or something similar.  Utilizing a system that can correlate this data for you is of immense help - especially if this repository is the same repository as your IDS/IPS logs, Windows Event Logs, etc.

Having the ability to fully patch a system before it is deployed is crucial in every environment.  One piece of malware (with a C2) can scan your entire network for a new server and then as soon as a "SysAdmin" logs in...... well, the game is over - time to rebuild.
