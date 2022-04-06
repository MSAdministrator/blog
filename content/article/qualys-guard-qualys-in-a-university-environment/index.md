---
title: "Qualys Guard Qualys in a University Environment"
date: 2018-08-07T20:44:11-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
The University I work for has began using Qualys for our Enterprise Vulnerability Scanning and so far it's been well received.  The problem is that every "College/School" maintains their own systems thus we are decentralized, which makes maintaining Reports/Scans/Maps/etc. very difficult.

Because I have not found many posts/articles focused on a decentralized environment I decided I would explain the way we are approaching this.  This is all a work in progress - if you have any questions or ideas, please get a hold of me.:)

So our basic process for setting up Qualys goes like this (overview):
<ul>
	<li>Gather IPs to add to our Qualys subscription (we are only worrying about servers at this time)</li>
	<li>Create Asset Groups (Naming Conventions: CAMPUS DEPT VLAN QUALYSCANNER#)</li>
	<li>Create User that will be the Unit Manager of a Business Unit</li>
	<li>Create Business Unit while creating user</li>
	<li>Assign Asset Group to Business Unit</li>
	<li>Setup a Scheduled Scan</li>
	<li>Have the Unit Manager create scheduled reports based on Global Templates that we've create</li>
</ul>
Again, this is a high level overview but this is our basic process.  In future posts I will try to break down Qualys in more detail and how to manage a large diverse group of systems across a decentralized campus.
