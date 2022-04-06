---
title: "Manage User Rights With Group Policy"
date: 2018-08-07T20:45:08-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
Group Policy is nothing but flexible and extremely powerful when it comes to both configuration management and installation of software.  In addition, Group Policy is one of your best tools for securing your endpoints.  You can manage anything and everything from Firewall rules, account privileges, application white-listing, etc.  You can also manage user rights as well.

Computers and Users in your environment have a lot of rights, by default, that they don’t need.  Using Group Policy, we can manage these privileges and start to lock-down our environments without making it burdensome for our end users.  One such privilege is the ability to Log on Locally.

[caption id="attachment_413" align="aligncenter" width="656"]<a href="http://msadministrator.com/2017/07/19/manage-user-rights-with-group-policy/use-group-policy-to-define-accounts-or-services-that-are-allowed-to-log-on-locally/" rel="attachment wp-att-413"><img class="size-full wp-image-413" src="https://msadministrator.files.wordpress.com/2017/07/use-group-policy-to-define-accounts-or-services-that-are-allowed-to-log-on-locally.png" alt="Use Group Policy to define accounts or services that are allowed to log on locally" width="656" height="374" /></a> Use Group Policy to define accounts or services that are allowed to log on locally[/caption]

By default, anyone that has the correct username and password can log on locally to a system, but do you really need to log on to a server in your datacenter using a local account?  Some of you might, in this case you should explicitly allow certain accounts to have this privilege.  Instead of using the default setting of “if you have a local account you can log in to this system”, but instead restrict this at a global level.  This ensures that your systems are properly managed and no one was being lazy or malicious by creating a one-time account they forgot about.

[caption id="attachment_414" align="aligncenter" width="656"]<a href="http://msadministrator.com/2017/07/19/manage-user-rights-with-group-policy/use-group-policy-to-define-accounts-or-services-that-are-not-allowed-to-log-on-locally/" rel="attachment wp-att-414"><img class="size-full wp-image-414" src="https://msadministrator.files.wordpress.com/2017/07/use-group-policy-to-define-accounts-or-services-that-are-not-allowed-to-log-on-locally.png" alt="Use Group Policy to define accounts or services that are not allowed to log on locally" width="656" height="375" /></a> Use Group Policy to define accounts or services that are not allowed to log on locally[/caption]

Let’s take the opposite approach.  Do you have systems on your network(s) that should only be logged on by specific individuals, accounts, services, etc?  Instead of relying on plainly on the security of your username and password, we should restrict this right to the specific accounts, computers, users, etc. that should have access. Only then, if they have the correct credentials are they allowed to login over the network.

[caption id="attachment_415" align="aligncenter" width="417"]<a href="http://msadministrator.com/2017/07/19/manage-user-rights-with-group-policy/use-group-policy-to-allow-access-to-computers-from-the-network/" rel="attachment wp-att-415"><img class="size-full wp-image-415" src="https://msadministrator.files.wordpress.com/2017/07/use-group-policy-to-allow-access-to-computers-from-the-network.png" alt="Use Group Policy to allow access to computers from the network" width="417" height="507" /></a> Use Group Policy to allow access to computers from the network[/caption]

By restricting this access to only the certain machines or users within a specific group, someone who has either found a set of credentials or has somehow infiltrated your network will only be able authorize a set of systems because others have been restricted.

Another example is to manage who has access to Log on Remote Desktop Services permissions.  Does everyone need to access a set of systems (this goes for both workstations and servers)?  I bet not, so why just enable RDP (Remote Desktop Protocol) for anyone who has valid credentials?  We should tightly restrict who has access to our systems, especially when using RDP.

[caption id="attachment_416" align="aligncenter" width="656"]<a href="http://msadministrator.com/2017/07/19/manage-user-rights-with-group-policy/use-group-policy-to-allow-or-deny-access-to-remote-desktop-services/" rel="attachment wp-att-416"><img class="size-full wp-image-416" src="https://msadministrator.files.wordpress.com/2017/07/use-group-policy-to-allow-or-deny-access-to-remote-desktop-services.png" alt="Use Group Policy to allow or deny access to Remote Desktop Services" width="656" height="398" /></a> Use Group Policy to allow or deny access to Remote Desktop Services[/caption]

For all situations regarding user rights and access to systems, we should always restrict access as much as possible.  The key is to create these restrictions without being burdensome for your end-users.  There is a fine line, but we should always attempt to be reasonable with this approach.  Some systems just shouldn’t be accessed over RDP or locally, this will be up to the discretion of your organizations risk.  Providing clear guidance and allowing your management to either enable these restrictions or to accept the risk is all that we as IT professionals can do.

&nbsp;
