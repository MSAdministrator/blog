---
title: "Design Before Coding Gathering Requirements"
date: 2018-08-07T20:44:41-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
If you have worked in IT for any duration, I’m sure you have overheard or been asked to build a tool to complete X or Y. Creating tools with PowerShell is fun, but it can become daunting when you create a tool that does not meet its intended purpose.  Without understanding the full requirements, you may waste time and energy on developing a tool that no one will use.

Creating tools with PowerShell to automate a manual process or to help an internal stakeholder accomplish a desired result, typically does not need to turn into a large initiative with a Project Manager or Project Management Office (PMO). Being tasked with creating these tools usually comes in the form a short conversation or through an email.  Out of habit, we usually dive right into writing a script or function to solve the problem.  This approach can cause a lot of re-work or redesign of our tool once complete.  Even though we believe we understand all the requirements, it is better to have the stakeholder create a “Goal Statement” that defines the intended purpose of the tool.  The “Goal Statement” helps everyone involved understand when the initiative is done.

A “Goal Statement” does not need to be a large body of work, it can simply be a couple of sentences or paragraphs.  Personally, I take the Scrum/Kanban approach and use User Stories.

User Stories are typically designed in the following format (there are different styles, but in my experience this the simplest form):
<p style="text-align:center;"><em>As a &lt;type of user&gt;, I want &lt;goal&gt; so that I &lt;receive benefit&gt;.</em></p>
Having a defined User Story reduces re-work and ensures that all stakeholders involved agree on the intended uses of this new tool.  Agreement on the intended results of this new initiative may not solve the problem completely, but it’s a great start!

At this point, we have not written any scripts, functions, modules, classes, etc.  You may want to dive right into writing a POC (Proof of Concept), but I recommend that you hold-off.  Once all stakeholders have agreed on our User Story, we should move to the design phase (Part 3 coming soon).

Let’s say that we work on a “Automation Team” in our organization that focuses on building tools to streamline processes for both IT and business teams.  We have been tasked with helping the organizations IT managers identify and verify that all Active Directory groups in our Forest have the correct owners associated with them.  As we start our requirements gathering phase, we ask all stakeholders to provide our team with agreed upon User Stories.  Our team receives the following:
<p style="padding-left:60px;"><em>As a manager, I want to know all Active Directory groups owned by myself so I can ensure that they are correct.</em><em> </em></p>
<p style="padding-left:60px;"><em>As a manager, I want to know all Active Directory groups owned by my employees so that I can ensure that they should have access.</em><em> </em></p>
<p style="padding-left:60px;"><em>As a manager, I want to know all Active Directory groups that do not have an owner but reside in my Active Directory OU so that I can assign the correct owner.</em></p>
Now that we have our agreed upon User Stories, we can begin the next phase; designing the “look and feel” of our new tool based on the requirements we have been given.  Having a general idea of what our stakeholders are needing reduces our work effort, as well as setting clear expectations that are agreed upon.

Understanding why we need to gather requirements is the first step.  The next post in this series I will discuss how you can use Kanban, digitally and manually, to organize our tasks so that you or your team can keep track of the status/progress along the way.

The final post in this series, we will begin designing our code layout.  This will help us and our stakeholders understand what parameters need to be present, what objects should be accepted in the pipeline, what return objects should look like, and how the new tool will be used.
