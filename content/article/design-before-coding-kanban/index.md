---
title: "Design Before Coding Kanban"
date: 2018-08-07T20:44:44-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
The first post in this three-part series focused on gathering requirements before spending time coding.  While it is not necessary, I recommend that everyone read part 1 (<a href="https://msadministrator.com/2017/03/29/design-before-coding-gathering-requirements/">Gathering Requirements</a>).  Understanding and having clear “User Stories” outlining the intended purpose of a tool is crucial, especially as we move towards building our new tool.

Once our “User Stories” have been defined and agreed upon by all stakeholders, we then need to begin breaking them down into tasks.  There are many different methodologies that allow us to track these different tasks. Part 2 of this three-part series will focus on one of them; Kanban.

I use Kanban daily, both personally and professionally.  If you want to understand the principles of Kanban, then I recommend that you start with <a href="https://en.wikipedia.org/wiki/Kanban">this</a> Wikipedia page. No matter what methodology or process you use, having a consistent and repeatable utility is a must.

This post will go over using Kanban both digitally and manually, but first you must understand the general purpose of Kanban.  Tracking our work can be difficult, especially with the use of E-mail, Slack, Skype, Teams, Yammer, HipChat, etc. etc.  The constant communication that is available to us is overwhelming, but having a central location that you can organize your “To-Do’s” or tasks is necessary.  Not for our management or organizations tracking purposes, it is so that we can track exactly what we need to do next.

<img class="alignnone size-full wp-image-355" src="https://msadministrator.files.wordpress.com/2017/03/factory-35081_1280.png" alt="factory-35081_1280" width="1280" height="1006" />

The theory of Kanban is to visually identify items that need to be worked on. Kanban allows you to understand what tasks need to be worked on, which ones are in-progress, and which ones are complete.  Using this information, we begin to identify any blockers or obstacles that may need to be fixed so that an item/task can move from “To Do” to “Done”.  This principle helps us identify our WIP (Work in Progress) so that the flow between “gates” or “hand-off points” is as smooth and controlled as possible.  Think of this like an assembly line:
<p style="text-align:center;padding-left:60px;"><em>Let’s say we have two workers in an assembly line.  The first person’s job is to paint a car door handle, the second person’s job is to install that door handle on a new car.  If the first person can paint 5 handles in 10 minutes, but the second person takes 10 minutes to install the handle; we have a problem.  This means that we either need to increase staff that install car door handles or maybe the same person should do both.</em></p>
Understanding these blockers will help us identify gaps in our processes, or the lack of labor to accomplish our goals.  Visually displaying this information on a Kanban board is much easier to understand than a bunch of tasks lists or “tickets”.

There are many tools available for a digital Kanban board.  I have listed a few below that are both free and paid.  In my professional life, I use <a href="https://www.atlassian.com/software/jira">Jira’s</a> Kanban feature.  In my personal life, I use both a whiteboard with post-it notes and built-in features of GitHub Projects (<a href="https://github.com/MSAdministrator/GitHubCardsExample/projects/1">example</a>):
<ul>
	<li><a href="https://trello.com/">Trello</a></li>
	<li><a href="http://volerro.com/index.php">Vollero</a></li>
	<li><a href="http://kanbantool.com/free-kanban-board">Kanban Tool</a></li>
	<li><a href="http://www.kanbanchi.com/">Kanbanchi</a></li>
	<li><a href="https://taiga.io/">Taiga.io</a></li>
	<li><a href="https://clubhouse.io/">Clubhouse.io</a></li>
</ul>
If you just do a quick google search for “free Kanban tools” or go to <a href="http://github.com/">GitHub.com</a> and search for “<a href="https://github.com/search?utf8=%E2%9C%93&amp;q=kanban&amp;type=">Kanban</a>” you will find many open source projects that you can host yourself.  If you don’t want to host it yourself, then check out <a href="https://www.digitalocean.com/">DigitalOcean.com</a>.  If you think a digital tool would work for you, you can even use Outlook (<a href="https://github.com/frederik/outlook-task-kanban">here</a> or <a href="https://github.com/evrenvarol/outlook-taskboard">here</a>) or <a href="https://www.sortd.com/">Gmail</a> to manage your tasks in the Kanban style.

I’m not sure about you, but I personally carry a leather-bound notebook (with <a href="http://www.doanepaper.com/">DoanePaper</a>) with me wherever I go.  Whether at work, out with friends, going to bed, etc., I always have my notebook.  In my opinion a digital tool is great, but I’m faster at writing things down on paper than I am opening an app.  Plus, I always have it with me.

<img class="alignnone size-full wp-image-361" src="https://msadministrator.files.wordpress.com/2017/03/simple-kanban-board.jpg" alt="Simple-kanban-board-" width="2355" height="1404" />

Another option or addition is by using a whiteboard in your home or work office.  The first thing you do is draw some columns.  Typically, you have three different columns: To-Do, In-Progress, and Done.  Starting out you will have everything in your To-Do column.  As you begin a new task you move that sticky-note to the In-Progress column.  If that item gets blocked or cannot be completed, you should move it back to the To-Do column.  You should only have a few items In-Progress (ideally, you would only have one).  Once you have completed that task, you move it to the Done column.

That’s it! Kanban allows you to visually see tasks and progress you are making on your projects.  The manual process is great for a single person or a team that is in close quarters.  If you’re spread out or in a cubicle this may not work as well.  This is where having a platform like Jira or Trello really shines.  Especially for teams that are global or in different locations.

Kanban is powerful, yet extremely simple. Using a tool to manage your tasks so that you understand exactly what you, your team, and others are working on reduces potential re-work while also making sure that all tasks for a project are complete (and on-time).  The third post in this series I will take the concepts of both post <a href="https://msadministrator.com/2017/03/29/design-before-coding-gathering-requirements/">one</a> and two, and we will begin to breakdown our User Stories onto our Kanban board.  Remember, we have not started coding yet.  Next, we will design how our stakeholders may use our new tool.  Understanding this, will speed up our development time and reduce re-work.
