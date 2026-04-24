---
title: "How I Use LLMs for Security Work: Part 2"
date: 2026-02-22T14:00:00-06:00
draft: true

categories: [security,automation]
tags: [ai,llm,claude,cursor,chatgpt,threat-hunting,SOC,productivity]
author: "Josh Rickard"
---

# How I use LLMs For Security Work: Part 2

I previously wrote a blog for THOR Collective Dispatch about some basic examples of different approaches when it comes to LLMs. It was cool and I hope it truly helps those starting out but I wanted to follow up and share some other more specific examples, including more “advanced” patterns that have worked for me over the past year or so. 

We’ve all seen the scope, complexity and rise of usage of LLMs from products which integrate them, to all new product categories to ClawdBot. If you’re not familiar with all the facets of LLMs that’s okay but before I dive into these more advanced use cases, I think it’s advantageous to understand some terminology (at a high-level) when it comes to LLMs.

Once we have a firm grasp on these different concepts, I will provide some more concrete examples of how I have used LLMs in the past.

## Terminology

This section defines some common (current) concepts related to LLMs but really, they are just Markdown with the exception that Assistants also may include code.

### Prompting

Really this is exactly what I wrote about in my previous blog. In this approach/use you provide statement(s), with some minimal context, maybe some general requirements and either a question or a problem statement.

I’ve seen vibe coding thrown around but never cared to look it up but my understanding is that it’s either using speech to text and just describing your problems or just typing it out listening to some JL or Joey Cool (my current vibe). Often, I believe this approach of question, answer, fix, validate, test, fix, etc. is painful and can go awry pretty quick depending on the client used.

Vibe coding maybe useful for some but where the real work will happen in our industry will be in the trenches. You must know how to describe the problem you are trying to solve, which requires you to intimately know the problem.

### Agents

Agents are the next “level” where there is very precise context given to an LLM. This context (which is really what this post is about) is about providing the guardrails for a request. Some provide this context in form of documentation, use cases, hard and loose requirements, gotchas, what not to do, perspectives including situational awareness statements and more. This can be 1,000-word document referencing 1 or 500 other documents to a single 50K (or more) prompt and typically includes extremely detailed descriptions, when to consider alternative options and especially negations of decisions.

#### SKILLS.md

Skills (e.g. SKILLS.md) are markdown files that essentially take everything a team knows about how to perform an action and writes a document that then feeds into an agent for absolute context, decision making, etc. These are almost identical to `agents` but I’ll let others decide where the naming concepts go.

#### Workflows

Workflows are like skills, but these are supposed to be directions for an LLM on how they should “analyze” or “examine” or “perform” the task being asked. For example, how to investigate an alert may have 1 or 15 steps defined including which tools (MCPs), how to interrupt results and how to make decisions before moving on to the next phase of the workflow. 

I like to think of workflows in the same way we define/document playbooks but in markdown. I think a good starting place for more mature organizations would be to embed their existing incident response documentation and response playbooks into their Agents and/or Assistants. Iterate and go wild from there.

### Assistants

This is the “newest” evolution (that I’m aware of) and I believe is where we are headed as an industry. Assitants are multi-faceted, customized and curated to tackle problems both big and small. These are the combination of multiple Workflows which trigger defined SKILLS.md and tools (MCP servers) and use multiple discrete agents to perform tasks along the way. 

These are larger projects that allow someone to hook into how an LLM is called (via it’s API) - for example, this is how one such project called PAI works (btw, Daniel is definitely onto something here). These hooks are used to control the flow of operations all described in text and past decisions. It’s quite interesting but nuanced.

## Context Is Key

I know that’s a lot, but really the first thing you need to understand is that this is really just all text/Markdown files. Instead of designing and defining how to communicate with a services APIs using some abstraction integration pattern, you can provide the docs and in plain English define what the inputs and outputs should be along with when to use it and how to perceive the results.

With everything said so far, I’d like to switch gears to provide some examples of why context maters and describing your problem succinctly will provide more value than “vibing” (I’m old) your way through it.
Let’s take this simple example I ran across the other week. Let’s say that you want to automate logging into multiple Google Chrome Profiles (you MSSP & thrunters know what I mean) and kick-off a simple hunt (search) in each. Why you may ask, because it’s tedious and you have to do what you have to do with the tools you have and really this is a silly example (and don’t really do this please).

Using this example, you may start up Claude Desktop/Code or Cursor and say:

```text
As a threat hunter, I want to create a python package and CLI utility which accepts a list of Google Chrome Profiles to open. I want this package to ensure the latest ChromeDriver is installed. For each provided Google Chrome Profile provided as input, I want this tool to only accept Chrome Profiles that exist on the system and do not create one if it doesn’t exist. Once validated, it should create a new browser instance that opens in the provided profile display name and the first tab is X url.
```

Doing this may result in some success (again this is a simple example) but more than likely it will never get it right because it will guess at which Profile and only if that name exists will it try and open that profile. It may also take a completely different approach and may solve, it but I’d honestly be surprised.

If I change this prompt by adding the following, giving it context, it will understand and find the correct answer because it has been given explicit instructions and a determined example output.

```text
… Ensure that the provided Google Chrome Profile name represents the display name shown within Google Chrome. For example, I have a profile named “Thrunting - X organization name” and it should match the input value”
```

This simple addition, of providing actual context and an expected result aligns the context/data inputs with your expected outputs; again guardrails.

This was a silly example, but I hope it provides some clarification that the more concrete outputs, decision points, paths to follow, descriptions of key terms, specifications, requirements and more in the context you provide to an LLM the better inference results.

p.s. The reason why LLMS do not understand that the values you are wanting to match reside in `./LocalState` instead of its parent directory is beyond me but that is where those display names are located (FYI).

## Back to the Basics

First, I want to reiterate that in order to build something meaningful using an LLM, you must NO MATTER WHAT first understand the problem you are trying to solve. If you don’t intimately know the problem, then start by writing what you do know and ask questions until you know what the problem is.

I’ve talked a lot about context but that’s a vague statement. In this section I wanted to provide some examples of context that I’ve found to be extremely beneficial when it comes to LLM output. Here is a non-inclusive list of context examples (in no particular order):

### Personas -> Identities -> Personalities

When starting, this is less of a concern but as your knowledge base on how you prefer to use LLMs grows you probably want to repeat a process, especially investigations, analysis, research, and/or tooling. This is where you can describe the experience, technologies, frameworks, etc. to skew results towards your current knowledge.

For example, you can describe your preferred Python package layout, templates, etc. You can define a persona for different projects or code bases. The point is to use the tools you are familiar with already when starting out. Don’t just let the LLM use TypeScript if you have never use it previously. 
Over time your design patterns, thinking logic and more can be recorded and use as persona or identity for repeatable work from a specific perspective and experience. 

There are some projects, like PAI, which are experimenting on building personalities from defining your background, failures, successes, etc. Pretty weird to think about but also pretty cool.

### Perspectives & Goals

Describe the perspective you want this problem to be researched or reviewed from. Whether that is QA as a staff level SDET or an elite red team ninja warrior. Defining these perspectives as well as the overall goals of the project will help keep scope within the problem space.

Here you can also define the overall skills (threat hunting, phishing defense, detection rule guru, etc.). You should also define the goals of the ask in general (e.g. find new and novel threats).

### Tools

This is pretty straight forward but provide a list of different external tools which can be used within this project. Most of these will be MCP servers and their exposed methods. But it can also be things like:

* A local runner docker compose stack
* Guidelines on which tools to use:
    * use python not golang or js
    * Use python-fire for CLI, attrs models
    * Class and inheritance over utility functions, etc.
    * Use uv over poetry
    * Etc.
* Specific APIs with examples (Schema docs is preferred)

For all of these, provide context as to when to use the tool, how to use it and how to interpret the results. This will definitely improve your results.

### Documentation

As much reference documentation you can provide will always be helpful but ensure that you are not bloating your token usage or extending beyond the context windows of these models; size of your prompt matters both on costs and the ability for the model to provide correct inference results.

Provide things like:

* API specifications
* JSONSchemas
* Repositories
* Internal & external docs to terms/keywords specific to your org/worldview
* Provide examples of similar problems
    * It is also advantageous to provide examples that you already have documented on solving a problem or of a previous investigation decision

In addition to these standard pieces of documentation, you should also provide what NOT to do. For example:
* Provide scenarios that will / may occur and describe what not to do and why
* Document when to not use a tool (defined above)
* Document what to do if a situation does occur that’s critical

### Requirements

Like I have mentioned a few times, you must understand the problem to fully get the benefits of LLMs. Another great way to improve your research, discovery, analysis, etc. uses of LLMs is to ensure you provide all the business and technical requirements.

When defining technical requirements, provide things around when to use tools, different tools or frameworks to avoid using, and other specifics. For example:

* Defining the requirements can be as simple as “use caching of results” or specific enough to warrant something like “use Redis caching, using the rueidis go package”
* Document what not to use including languages, frameworks, etc.
* Define business requirements
    * This should likely be the largest section, but it depends on the end goal of the prompt.
* Define gotchas

There are lots of opportunities to write here. As a side note, I believe the ones that will prevail in the future of the “tech” industry are the ones that can describe a problem in detail effectively and efficiently as possible.

In addition to all of the above, I recommend checking out frameworks like Skills https://platform.claude.com/docs/en/agents-and-tools/agent-skills/overview and review projects which have implemented `SKILLS.md` to get a different perspective. We are in a new frontier and the frameworks, schemas, etc. are constantly evolving. Just look at MCP (plug for a MCP I wrote about a year ago https://github.com/MSAdministrator/enrichment-mcp) and its evolution (I still think they should have used gRPC https://github.com/modelcontextprotocol/modelcontextprotocol/discussions/1144).

## Advanced Example

Now let’s get into an example. This is purely hypothetical and for posterity I’m actually not going to put this prompt into any LLMs and just let you try it for yourself (mostly because I don’t want to waste the energy — LLMs have Externalities that reach further than most other technology known to humans — what you input has an external cost that you may not realize).

Note: I wrote this in example below in like 30 minutes. Your mileage will vary depending on the number of details provided.

## Description

As a senior security research engineer focused on building highly scalable threat detection systems. As a senior software engineer proficient in Golang, gRPC, Protobuf, unary and bi-directional streaming, ingestion processing using Kafka or google pub/sub, caching using Redis pipelining, Postgres (and ip4r) scaling using pgbouncer(s), kubernetes, monitoring and metrics using Prometheus.Your goal is to build highly scalable threat enrichment pipeline that can ingest logs of different services, extract the necessary IPv4/IPv6 addresses (as well as their context  e.g. source ips vs destination ips, etc.) and perform enrichment providing precise geolocation information (for now you can use ipinfo sample databases). 

This service can process anywhere from 100 to 1 billion IPs per day to enrich but performance throughput and low latency (10ms~) are REQUIRED.

## Tools

You have the following tools available to you:

* Golang
* gRPC & protobuf for inner service communications
* Use Postgres (using the ip4r extension)
    * Use pgbouncer for scalable queries
    * Ensure proper indexes are in place
* Cache results using Redis (rueidis client library)
* Use kubernetes and light weight images
* Setup monitoring and metrics throughout the pipeline using Prometheus

## Documentation

The following are references to use:

* Use the ipinfo sample databases https://github.com/ipinfo/sample-database as the core database structure
* Expect that the incoming logs are in this schemas format (link to schema or samples)
* It is expected that every log ingested will be enriched, but this does not mean every log will have values. Indicate in the log if enrichment occurred no matter if successful or not
* Ensure you are creating the appropriate views or queries utilize the correct ip4r data types https://github.com/RhodiumToad/ip4r

## What Not to do

* Do not create two separate paths for ipv4 and ipv6 addresses

## Requirements

* Ensure the pipeline can handle 1 billion events per day
* Ensure that you are extracting all IPs found and that each IP addresses found is enriched in the correct context (source vs. destination, etc.)
* Ensure that extract can be changed easily, you never know when new formats are going to be supported in the future
* Keep cached results for up to 18 hours (at a minimum) but provide a way to invalidate cache
* Ensure all communications are encrypted and have proper (and secure) authorization between services
* Create indexes that use the ip4r data types for IPs 
* Data will be updated from a remote location at any time so upgrading of IP geolocation must be straight forward

I hope this more advanced example helps you understand that the more context you can provide the better results you will receive. Vibe coding is cool and all but just like how a Product/Project Manager will provide guidance for a project, you too must do the same in order to get the best results.

As I have stated previously, I believe that those who understand a problem fully and can describe it in detail, are the ones that will prevail as we move into this new era of technology advancement. Time will tell if I’m right or wrong.

Peace
