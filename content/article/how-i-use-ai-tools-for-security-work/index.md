---
title: "How I Use LLMs for Security Work"
date: 2026-01-18T14:00:00-06:00
draft: true

categories: [security,automation]
tags: [ai,llm,claude,cursor,chatgpt,threat-hunting,SOC,productivity]
author: "Josh Rickard"
---

I've been using LLM tools like Claude, Cursor, and ChatGPT extensively in my security & engineering work for the past couple years. Not as a replacement for thinking—but they genuinely help me move faster through complex problems. If you're a security analyst, SOC analyst, threat hunter or engineer who hasn't found a rhythm with these tools yet, I'll try to share what's been working for me with the hope it helps you too.

Here's the thing: most people prompt LLMs like they're searching Google. They type a few keywords and expect magic. That doesn't work, especially for security work where context and precision matter. You wouldn't walk up to a senior analyst and say "phishing bad, clicked link, help" and expect useful output. Same principle applies here. The way you prompt these tools completely changes what you get back.

I don't claim to be an expert by any means so please take this all as my opinion--I know there are many other ways to approach using LLMs. I've used approaches like:

* writing a design & requirement document and feeding that into an LLM while writing examples shared below.
* providing a repository of code and giving clear problem statements
* question & answer analysis
* etc.

Here's some examples of how I think they can be most useful for security peeps just starting out with LLMs.

## Role-Stacking: Set the Stage

One of the most effective techniques I've found is what I call "role-stacking." Instead of just asking a question, I tell the LLM what perspectives I need it to consider. I also found that using my own experience when setting the stage is extremely helpful since it's what I know.

Here's an example:

```text
As a security analyst and phishing threat detection expert. As a software engineer experienced with Python, Flask, and Docker.

Create a simple Flask (bootstap, etc.) application to collect DNS, WHOIS/RDAP, HTML and other opensource threat intelligence for a given URL.
```

Notice what I did there. I'm not just asking "create a simple flask application." I'm telling the LLM to think from multiple angles simultaneously—security analysis, phishing expertise, and software engineering. This produces output that bridges disciplines rather than staying siloed.

For SOC analysts, this might look like:

```text
As a SOC analyst experienced in alert triage. As a threat hunter 
familiar with MITRE ATT&CK. As someone who has dealt with alert 
fatigue firsthand.

Analyze this detection rule and identify potential blind spots or false positive generators.
```

The role-stacking approach forces the LLM to consider your problem from multiple angles, which often shows you things you wouldn't get from a single-perspective prompt.

## Be Explicit About Your Technology Stack

LLMs perform dramatically better when you tell them what you're actually working with. Be specific about the technologies, products, and constraints in your environment (as much as you know).

Here's how I do it:

```text
As a senior security engineer and sr. software engineer. Experience 
with Docker, Kubernetes, caching, data streaming, gRPC, protobuf, 
JSONSchema, common data models, Puppeteer, Playwright, extensive 
experience with APIs, network communications, web frameworks, 
anti-bot detection, Chromium, Selenium, network captures, monitoring, 
knowledge about fingerprinting, cookie injection, evading behavioral 
turnstiles/captchas.

Using these technologies, products, tools, frameworks and knowledge 
bases, let's design an application that [specific goal]...
```

I know that looks like a lot. I mean, it is a lot. But here's why it matters: the LLM now knows exactly what tools are on the table. It "shouldn't" suggest solutions using technologies I don't have (but it does sometimes but I have found this approach helps). It'll reason within my actual constraints most of the time. When it does, it's a huge benefit--especially when you're trying to solve real problems in your actual environment—-not hypothetical ones.

For threat hunters, this might be:

```text
As a threat hunter with access to Splunk, CrowdStrike EDR, and 
network flow data. Working in a hybrid cloud environment with 
AWS and on-prem Windows infrastructure. Familiar with Sigma 
rules and MITRE ATT&CK.

Help me develop a hunting hypothesis for [specific threat behavior].
```

## Request Thoroughness Explicitly

So, how do you get past the surface-level responses? LLMs will often give you the quick answer—which is usually the shallow answer. If you want depth, you have to ask for it and provide a very specific example output.

I frequently use phrases like:

- "Take your time, think through carefully"
- "Use critical systems thinking"
- "Consider batch and streaming patterns, integration patterns, and how this evolves over time"
- "Do not hallucinate and validate any decisions and findings"

That last one is important. Honestly, these tools can confidently generate plausible-sounding nonsense. Telling them explicitly to validate their reasoning helps—not perfectly, but noticeably.

Here's an example:

```text
Using your knowledge of cyber security and threat intelligence 
as it relates to phishing defense. We are evaluating several 
products to integrate into our detection pipeline.

We are evaluating VirusTotal GTI, Team Cymru, Feedly, and any.run.

Knowing all that, create an evaluation criteria process.

Take your time. Think through carefully. Do not hallucinate—validate 
any decisions and findings.
```

## Ask for Current Information

This is especially important for security work where the landscape changes constantly. Tools, techniques, and threat actor behaviors evolve. Explicitly ask for updated context:

```text
Search for the latest information regarding security tools and products.

Evaluate the best option for a sandbox analysis tool when it 
comes to inspecting and analyzing both phishing links and 
attachments from phishing emails.
```

Will the LLM always have the latest data? No. Prompting it this way encourages it to reason about recency and often produces more thoughtful responses about what might have changed. Luckily, many of these tools have web search capabilities, so this prompt pattern becomes even more effective.

## Think in Systems, Not Point Solutions

Security work is inherently about systems—interconnected components that create emergent behaviors (and emergent vulnerabilities). I prompt AI tools to think the same way.

Here's an example from my own work:

```text
Imagine you have a platform which can use a list of indicators 
to hunt backwards in time for up to 30 days. The list of indicators 
per type (domains, IP addresses, URLs, files) will add about 
2 million new indicators per day that we must back-test/hunt for. 
As each day passes, the indicators exponentially grow in size.

Provide 5 options for building a system to handle and manage this data for X years. Remember to use critcial systems thinking.
```

This prompt describes a real systems problem—not a feature request. The tool now has to reason about data growth, retention strategies, computational constraints, and tradeoffs. That's the kind of thinking that produces useful output.

For SOC analysts dealing with alert volume, try:

```text
Our SIEM generates approximately 50,000 alerts per day across 
200 detection rules. About 15% of our analyst time is spent on 
5 rules that generate 60% of the volume.

How should we approach optimizing this situation? Consider both short-term tactical fixes and 
longer-term strategic improvements.
```

## Practical Tips for Getting Started

If you're new to using LLMs for security work, here are some concrete starting points:

- **Start with role-stacking**: Before every prompt, think about what perspectives would be valuable. Security analyst? Software engineer? Incident responder? Stack them.
- **Be embarrassingly specific**: Include your actual tools, technologies, and constraints. The more context, the better the output.
- **Ask for validation**: Explicitly request that the LLM validate its reasoning and not hallucinate. It helps.
- **Think in systems**: Frame your questions as systems problems, not isolated tasks.
- **Iterate**: Your first prompt won't be perfect. Refine based on what you get back. Tell the tool what was useful and what wasn't.

Finally, if you really want to stretch how you think about LLMs. Once you have completed a project / idea tell the tool to write a mark down file that can be used next time when wanting to create a similar tool (or just a project in general).

An additional approach I have been playing with is asking the LLM to generate this markdown document in a way that considers current and future progressions of how we interface with LLMs and to build it in a way that is most efficient for the LLM itself.

For example:

```text
Assess this project as a whole and generate a markdown definiton that will be used in the future for similar projects. Think about the current adoption and patterns used to interact with LLMs as well as future progression based on industry trends.

Generate this document so that it is efficient, clear and precise for future iterations.
```

That's it! These six techniques cover about 90% of how I get value from LLMs in my daily work.

## A Note on People

With that being said, I want to be clear about something: these are tools to augment human judgment, not replace it. The value of a good security analyst isn't their ability to generate text—it's their judgment, their intuition, their ability to recognize what doesn't fit.

LLMs help me move faster through the mechanical parts of my work. They help me explore ideas, draft documentation, reason through complex systems. But the decisions? Those are still mine.

As InfoSec professionals, we're responsible for the security of real people and real organizations. LLms can help us do that job better—but only if we stay in the driver's seat. Just remember that these tools are amplifiers—they amplify good thinking and bad thinking alike. Bring the good thinking.

## What's Next

I'm still learning how to use these tools effectively. The techniques I've shared here are simplified examples of what's working for me right now, but I expect they'll evolve as the tools themselves improve.

I'm currently building my own `agent` and `workflow` (state machines) so I may write about that next as I continue to learn and adapt on the many ways you can approach those problems.

In the real world, especially more complex work, I define my goals, general requirements, my constraints, ideal/desired inputs and outputs. Remember the more context you given an LLM the better it will be (e.g. provide reference API docs, schemas, query examples, etc.).

If you've found effective prompting patterns for security work, I'd love to hear about them. Reach out on LinkedIn or GitHub—let's share what's working.

I hope this helps some of you get more out of these tools. The threat landscape isn't slowing down. Neither should we.

Enjoy!
