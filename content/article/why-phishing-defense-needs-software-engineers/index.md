---
title: "Why Phishing Defense Needs Software Engineers"
date: 2026-01-18T12:00:00-06:00
draft: true

categories: [security,phishing]
tags: [phishing,threat-intelligence,automation,software-engineering,CTI]
author: "Josh Rickard"
---

If you've worked in security for any amount of time, you know that phishing is the attack vector that just won't quit. It's evolved from Nigerian prince emails to sophisticated credential harvesting operations powered by Phishing-as-a-Service (PhaaS) platforms like Tycoon 2FA. The attackers have leveled up—and honestly, most defenders are still playing catch-up.

Here's the thing: traditional security approaches to phishing defense aren't cutting it anymore. We need to think differently. We need to think like software engineers.

## The Problem with Traditional Phishing Defense

Most organizations approach phishing defense reactively. An email comes in, gets flagged (maybe), an analyst investigates, and if it's malicious, they block the sender or domain. Rinse and repeat.

The problem? Modern phishing campaigns don't work that way. Attackers spin up infrastructure in minutes, rotate domains hourly, and use anti-bot detection to serve benign content to security scanners while showing the phishing page to real victims. By the time you've blocked that domain, they've already moved on.

Let's be honest—we're not going to out-click the attackers. We need systems that can collect, correlate, and attribute at scale.

## Thinking Like a Software Engineer

When I approach phishing defense now, I don't just think about security controls. I think about data pipelines, integration patterns, and systems that can evolve over time. This is where critical systems thinking comes into play.

Consider the challenge: you want to analyze every suspicious URL and attachment that comes through your email gateway. That's potentially millions of observables per day. Each one needs to be:

1. Collected and normalized
2. Enriched with external intelligence
3. Analyzed for malicious indicators
4. Correlated with historical data
5. Attributed to known campaigns, kits, or actors

That's not a security problem—that's a data-intensive application design problem.

## The Building Blocks

If I were building a modern phishing intelligence platform from scratch, here's how I'd approach it:

### Data Ingestion Layer

You need to handle both batch and streaming workloads. Emails come in real-time, but you also need to backtest new indicators against historical data. I've seen organizations accumulate 2+ million new indicators per day across domains, IPs, URLs, and files. As each day passes, that dataset grows exponentially.

This is where technologies like gRPC and protobuf shine. Define your message schemas upfront with something like JSONSchema or protobuf definitions. This forces you to think about your data model before you start writing code—and trust me, that investment pays dividends when you're correlating data six months later.

### Intelligence Collection

Here's where it gets interesting. Modern phishing kits are designed to detect and evade security tools. They use:

- **Browser fingerprinting** to identify automated analysis
- **Behavioral turnstiles and captchas** to block bots
- **Cloaking** to serve different content based on visitor characteristics
- **Short-lived infrastructure** that rotates faster than blocklists update

To collect intelligence on these kits, you need to think like the attackers. Tools like Puppeteer and Playwright give you headless browser automation, but that's just the start. You need to consider cookie injection, realistic fingerprinting, and techniques to evade behavioral detection.

This isn't about being sneaky—it's about ensuring your analysis tools see what a real victim would see.

### Attribution Engine

Collection without attribution is just noise. The real value comes from answering questions like:

- Is this the same kit we saw targeting our CEO last month?
- What infrastructure patterns does this threat actor typically use?
- Are multiple campaigns connected through shared resources?

This requires thinking about your data model carefully. A detection rule isn't just a pattern—it's an entity with relationships to campaigns, actors, techniques, and historical observations. Build those relationships into your schema from day one.

### The Human Element

With all this talk about automation and systems, it's easy to forget that people are the point of all this. Every phishing email that gets blocked is an employee who didn't have their credentials stolen. Every campaign we attribute is intelligence we can share to protect others.

As InfoSec professionals, it's our responsibility to build systems that make our analysts more effective—not replace them. The goal is to handle the volume and repetition so humans can focus on the novel and complex cases that actually require judgment.

## Where to Start

If you're looking to level up your phishing defense capabilities, here are some practical first steps:

1. **Define your data model**: Before you buy another tool, figure out what entities matter to you and how they relate. URLs, domains, IPs, files, campaigns, actors, kits—model them.

2. **Evaluate your enrichment sources**: Tools like VirusTotal, Team Cymru, and any.run each have strengths. Understand what gaps you're trying to fill before you integrate.

3. **Build for evolution**: Phishing tactics change constantly. Design your systems to adapt—new indicator types, new attribution patterns, new collection techniques.

4. **Invest in correlation**: Individual indicators have limited value. Connected indicators tell stories. Make sure your platform can surface those connections.

## The Path Forward

Phishing defense has become a software engineering problem. The organizations that recognize this—and invest in the engineering capabilities to address it—will be the ones that get ahead of the threat.

I'm not saying every security team needs to become a software shop. But we need to think about our tools and processes with the same rigor that software engineers apply to their systems. Data models matter. Integration patterns matter. Scalability matters.

The attackers are running automated, scalable operations. If we're going to defend against them, we need to do the same.

Just remember—at the end of the day, it's not about the technology. It's about the people we're protecting. Build your systems with that in mind, and you'll be pointed in the right direction.
