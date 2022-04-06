---
title: "Qualysguard Decentralized It How to Organize Your Assets"
date: 2018-08-07T20:44:23-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
I work for a University with a decentralized IT department: each college, division, department, etc maintains their users.  As a security department who maintains QualysGuard, we were wanting each department to scan their own assets and re-mediate all vulnerabilities found in these scans based on the following policy:
<ul>
	<li>Level 4 and Level 5 vulnerabilities must be re-mediated within 15 days</li>
	<li>Level 3 vulnerabilities must be re-mediated within 30 days</li>
	<li>Level 2 vulnerabilities must be re-mediated within the next semesters</li>
	<li>Level 1 vulnerabilities must be re-mediated whenever possible</li>
</ul>
WIth this policy in mind, we began rolling out our QualysGuard service using the following methods.  We would create Asset Groups for each group of servers that belong to one of the following: a department, college, division, application group, etc.  Each Asset Group would be additionally subdivided into each network core.  For example, if you have a Athletics department, they may have assets in all the different network cores (Faculty/Staff Network, Data Center, DMZ, Residential Network, etc.).  Because each of these departments will have multiple assets in multiple network cores, we relied heavily on our naming conventions.  Our naming convention is the following for Asset Groups: CAMPUS DEPT NETWORK Assets (SCANNER NAME) -&gt; CAMPUS Athletics DC Assets (DC_SCANNER)

When dealing with QualysGuard in a decentralized IT infrastructure, your naming convention will save you!

Once you have a group of Assets in their respective Asset Groups, then we add them to their own Business Unit.  Remember that you must a Unit Manager (at least 1), and you may any number of Scanner and Reader roles.  You can additionally assign a role to specific Asset Groups within the Business Unit (or another Business Unit).

Please see the following graphic, which outlines what was previously stated:

<a href="https://msadministrator.files.wordpress.com/2015/01/2015-01-11-14_12_21-business-unit-hierarchy.png"><img class="alignnone size-medium wp-image-297" src="https://msadministrator.files.wordpress.com/2015/01/2015-01-11-14_12_21-business-unit-hierarchy.png?w=300" alt="2015-01-11 14_12_21-Business Unit Hierarchy" width="300" height="166" /></a>

Remember, when you are rolling out your QualysGuard VM infrastructure you will want to plan (in great detail) your roll-out.  Creating a roll-out plan that relies on system owners to take responsibility for their own systems, instead of System Administrators and/or Security Analyst is the idea goal.  By doing this, it highlights the importance for security in your organization as well as giving everyone insight into the security posture of their organization.  Hopefully they will see QualysGuard as a tool of transparency that helps strengthen your organization vulnerability management life cycle management.
