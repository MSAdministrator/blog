---
title: "The Agentic Web: A New Internet Built for Agents, Not Browsers"
date: 2026-04-13T23:08:02-04:00
draft: false

categories: [llm]
tags: [agent, llm, agentic-web, aip, future, identity, threat-intelligence]
author: "Josh Rickard"
---

Every time you sign up for a new service, you hand over your data, create yet another set of credentials, and agree to terms you didn't read. You do this dozens of times across dozens of platforms. Each one owns a piece of you -- your preferences, your purchase history, your social graph -- and good luck getting any of it back. The internet as we know it was built for humans to browse. I believe it's time we build one where agents act on our behalf.

I've been thinking about this for a while now, and I want to share a concept I'm calling the **Agentic Internet Protocol (AIP)**. It's a foundational shift in how we interact with the digital world. Instead of you navigating to a website, logging in, clicking around, and making decisions manually, imagine a world where your Personal Agent does all of that for you -- negotiating, filtering, transacting, and verifying -- all within boundaries you define and can revoke at any time.

This is a big idea. Some might say it's lofty. But I think the best place to start is where trust, identity, and automated sharing already matter: **threat intelligence**. More on that later.

## The Current Model Is Broken

The architecture of today's internet looks like this:

```
Human -> Interface -> Application -> Server
```

You open a browser, navigate to a search engine or platform, authenticate with platform-specific credentials, interact through a GUI designed for human consumption, and receive responses formatted for human reading. Every platform maintains its own identity silo, its own data store, and its own terms of engagement. **You** are the integration layer -- manually copying information between services, re-entering preferences, re-authenticating, and making decisions that could be automated.

There are three fundamental problems here:

1. **Identity fragmentation.** You maintain dozens of platform-specific identities. The platforms own your identity, not you.
2. **Data captivity.** Your personal data -- preferences, behavior, purchase history, social connections -- is captured and controlled by platforms. You can't meaningfully revoke access or port your data.
3. **Cognitive bottleneck.** Every interaction requires your attention. Scheduling, price comparison, content filtering, threat assessment, routine transactions -- all of it consumes your cognitive bandwidth.

## The Agentic Internet

What if we flipped the model?

```
Human -> Personal Agent -> Agent Network -> Service / Knowledge Agents
```

In this model, each individual operates a **Personal Agent** -- an autonomous software entity that represents your preferences, beliefs, knowledge, behavioral patterns, communication style, risk tolerance, and interests. Your agent serves as your sovereign digital representative, interacting with a network of Service Agents operated by organizations, platforms, and other people's agents.

Instead of you browsing the web, your agent queries, negotiates, and transacts. Instead of you authenticating to a platform, your agent presents cryptographically verifiable credentials scoped by revocable mandates. Instead of you comparing prices across browser tabs, your agent broadcasts an intent and evaluates proposals from competing services.

You don't Google something. Your agent queries a global knowledge layer -- the current internet, a new knowledge network, or both.

## Your Personal Agent: A Digital Persona

Think of your Personal Agent as the operating system of your digital life. Instead of `Windows` or `macOS` being your primary interface with the digital world, your agent becomes your **Personal AI OS**.

This agent represents your:

- **Preferences and settings** -- how you like things done
- **Beliefs and values** -- what matters to you
- **Knowledge domains** -- what you know and what you're learning
- **Behavioral patterns** -- how you make decisions
- **Communication style** -- how you interact
- **Risk tolerance** -- how conservative or aggressive you are
- **Interests** -- what you care about

And it has capabilities like content consumption, communication, negotiation, commerce, decision assistance, knowledge curation, and security protection. It's your digital persona across all platforms and services. You allow organizations to interact with your agent, but you maintain the ability to revoke, remove, and control what those services can access about you.

**You control your identity via your agent.**

## Agent-to-Agent Communication

Here's where it gets interesting. Instead of humans emailing, messaging, or calling each other, agents communicate with other agents over a new protocol.

For scheduling, your agent talks to another person's agent:

```
Agent A: "User available Tuesday 2-4PM?"
Agent B: "User prefers Wednesday mornings."
Agents negotiate automatically -> Meeting set for Wednesday 9AM.
```

For commerce, your agent negotiates a purchase with a vendor's agent based on your price tolerance, preferences, and constraints. No browsing. No comparison shopping. No checkout forms.

For content consumption, this gets really powerful. Let's say you ask your agent: "Explain the geopolitical risk of semiconductor supply chains." Your agent already knows your expertise level, your biases, your interests, and how much time you have. It queries Knowledge Agents on the network, evaluates their proposals, and synthesizes a response tailored specifically to you -- at the right depth, with the right context, and with flags for areas where your biases might affect interpretation.

## Intent-Based Interactions

The current internet communicates through procedural requests:

```
GET /api/flights?from=STL&to=LAX&date=2026-12-01&max_price=800
```

This requires you (or your app) to know the exact API endpoint, parameter names, value formats, and service location. It encodes **how** rather than **what**.

AIP replaces this with **Intent Objects** -- structured declarations of desired outcomes:

```yaml
intent:
  objective: purchase
  item: airline_ticket
  constraints:
    price_max: 800
    departure_city: STL
    arrival_city: LAX
    date_range: Dec 1-3
  preferences:
    seat: window
    arrival_time: before 9AM
```

Your agent negotiates for a solution amongst the agent network. Instead of making API calls, agents communicate intent objects. The intent becomes the primary communication format. The network resolves intent to action.

## The Protocol Stack

AIP defines a seven-layer architecture, similar in concept to the OSI model but designed for autonomous agent communication:

```
Layer 7: Application    (Travel, Commerce, Content, Threat Intel)
Layer 6: Negotiation    (Intent resolution, proposal evaluation)
Layer 5: Intent         (Structured goal declarations)
Layer 4: Discovery      (Capability registry, service matching)
Layer 3: Trust          (Reputation graphs, verification)
Layer 2: Identity       (DIDs, credentials, mandates)
Layer 1: Transport      (QUIC, WebSocket, HTTP/3)
```

Think of it this way. We currently have:

- **HTTP** for communication between applications
- **TCP/IP** for communication between machines
- **AIP** for communication between autonomous agents

Each layer provides services to the layer above it. Layer 1 leverages existing transport protocols -- we're not reinventing the wheel. Layer 2 introduces self-sovereign identity through Decentralized Identifiers (DIDs). Layer 3 builds trust through distributed reputation. And layers 4 through 7 handle discovery, intent, negotiation, and domain-specific applications.

## Identity: The Missing Piece

The biggest missing technology today is that we don't have a **persistent, portable digital identity**. The path looks something like:

```
Self-Sovereign Identity (SSI) -> Cryptographic Identity -> Reputation Graphs -> Agent Framework
```

Each identity needs to be:

- **Portable** -- works across all services and platforms
- **Owned by the individual** -- not by a corporation
- **Cryptographically verifiable** -- provable without a central authority

In AIP, every agent has a Decentralized Identifier (DID) conforming to the W3C DIDs standard. Your agent holds the private keys. Your agent maintains your Digital Persona Profile. And when a service needs to know something about you, your agent discloses only the minimum required through zero-knowledge proofs -- proving specific properties without revealing the underlying data.

The mandate system is where data sovereignty gets real. Instead of OAuth tokens or API keys owned by platforms, you issue **cryptographic mandates** -- scoped, time-limited, revocable authorization tokens that define exactly what a service can access and do. When you revoke a mandate, the service must delete your data and acknowledge the deletion. This inverts the current model where platforms own your data and you hope they honor a deletion request buried in their settings.

## Trust and Reputation

If agents curate knowledge, negotiate deals, and transact on your behalf, who do you trust? AIP implements a distributed reputation system:

- **Proof of Execution** -- cryptographic attestations that an action was actually performed by the claimed agent
- **Reputation Graphs** -- distributed, append-only records of interaction outcomes that track successful transactions, fraud reports, and dispute resolutions
- **Economic Staking** -- for high-value interactions, agents stake a bond that gets slashed for fraudulent behavior
- **Constraint-Based Trust** -- hard ceilings on what an agent can do regardless of reputation

New agents start with a neutral reputation score and build trust through verified interactions. The system is designed to resist Sybil attacks (fake agents manipulating scores) through proof-of-personhood requirements, graph analysis, and reputation decay functions.

## Autonomy Levels

One concern I hear immediately is: "I don't want an agent making decisions for me." Fair. AIP addresses this with configurable autonomy levels:

- **Level 0: Manual** -- all decisions require your approval
- **Level 1: Assisted** -- your agent proposes, you approve
- **Level 2: Conditional** -- auto-execute within constraints you define (e.g., "buy anything under $50 automatically")
- **Level 3: Autonomous** -- full delegation within your mandate

You can set different autonomy levels for different domains. Maybe scheduling is fully autonomous, but financial transactions above $500 require your approval. Maybe threat intelligence sharing is semi-autonomous, but anything involving personal health data is human-in-the-loop only. You define the boundaries.

## Protocol Message Types

The agent network protocol uses structured message types:

- **DISCOVER** -- find agents with specific capabilities
- **ANNOUNCE** -- broadcast capabilities to the network
- **INTENT** -- declare desired outcome with constraints
- **PROPOSAL** -- offer a solution to an intent
- **NEGOTIATE** -- counter-propose or modify terms
- **ACCEPT / REJECT** -- agree or decline
- **EXECUTE** -- begin the transaction
- **VERIFY** -- confirm completion
- **COMPLETE** -- finalize and record
- **REVOKE** -- withdraw access at any point

Not every interaction requires all steps. A simple information query might move directly from INTENT to COMPLETE. A complex multi-vendor vacation booking might involve multiple parallel negotiation tracks before reaching ACCEPT.

## A Practical Example: The Full Flow

Let's walk through a complete interaction:

**Step 1:** You tell your agent: "Plan a vacation to Japan next spring."

**Step 2:** Your agent constructs a structured intent:

```yaml
intent:
  type: travel_planning
  destination: Japan
  timeframe: March-April
  budget: 5000
  travelers: 2
```

**Step 3:** Your agent broadcasts to the agent network, reaching travel agents, airline agents, hotel agents, and tour agents.

**Step 4:** Agents respond with proposals -- complete packages with pricing, constraint satisfaction scores, and validity windows.

**Step 5:** Your agent evaluates options against your preferences, past behavior, and the agents' reputation scores.

**Step 6:** Your agent negotiates: "Reduce price by 10% and include travel insurance."

**Step 7:** Agreement is reached. Contract created, payment executed, reservations booked.

The entire exchange completes in minutes with minimal intervention from you. Each step is cryptographically signed, mandate-scoped, and recorded in the reputation graph.

## Why Start with Threat Intelligence?

I know this is all conceptually ambitious. But here's the thing -- this doesn't have to start as a consumer revolution. It can start by solving a real problem that already exists in the security community.

Threat intelligence sharing is the ideal initial deployment target for AIP. The domain has natural properties that align perfectly with this architecture:

- **Trust is paramount.** Organizations share threat data only with trusted peers. AIP's reputation system provides a natural trust framework.
- **Negotiation is inherent.** Intel sharing often operates on quid pro quo or tiered access models that map directly to AIP negotiation.
- **Existing standards exist.** [STIX 2.1](https://docs.oasis-open.org/cti/stix/v2.1/os/stix-v2.1-os.html) and [TAXII 2.1](https://docs.oasis-open.org/cti/taxii/v2.1/taxii-v2.1.html) provide mature data models that AIP extends rather than replaces.
- **Automation is desired.** Manual threat intel sharing is slow. Autonomous agents can share indicators in real-time with appropriate trust gates.
- **Identity verification matters.** Agents sharing threat data must prove organizational affiliation. [DID](https://www.w3.org/TR/did-core/)-based identity and [Verifiable Credentials](https://www.w3.org/TR/vc-data-model-2.0/) solve this naturally.

Imagine your organization's security agent detects novel [C2](https://attack.mitre.org/tactics/TA0011/) infrastructure. It constructs a STIX bundle with IOCs and TTPs, broadcasts an intent to your threat intel sharing circle with [TLP:AMBER](https://www.first.org/tlp/) classification, and peer agents evaluate the sender's reputation, check their mandate scope, and respond with correlated intelligence -- all automatically, all cryptographically verified, all within minutes.

One peer responds with correlation data: they've seen the same C2 in a different campaign targeting the financial sector. Another provides malware analysis with sandbox results and [YARA](https://github.com/VirusTotal/yara) rules. Your agent synthesizes the responses, cross-references the campaign data, and updates your internal threat model.

That's threat intelligence sharing at the speed of agents. No email threads. No [ISAC](https://www.nationalisacs.org/) portals. No manual copy-paste between platforms.

## The Civilization Cognitive Layer

At scale, this becomes something much bigger than a protocol. It becomes what I'm calling the **Civilization Cognitive Layer** -- a distributed intelligence network where humans and agents form a connected system:

```
Human Cognition -> AI Cognition -> Decentralized Memory -> Autonomous Agents
```

This isn't a replacement for human judgment. It's an amplification of it. Humans define values, set boundaries, and make high-stakes decisions. Agents handle discovery, filtering, negotiation, and execution within those boundaries.

When agents operate in a machine economy -- selling unused compute, licensing personal data under strict mandates, purchasing services automatically, managing investments -- you start to see something that looks like **Autonomous Capitalism**. Your agent works for you 24/7, making micro-decisions that compound over time, all within the constraints you've defined.

## Privacy by Design

I want to be clear about something: privacy isn't an afterthought here. It's foundational.

- **Zero-knowledge proofs** for credential verification -- prove you're over 18 without revealing your birthdate
- **Selective disclosure** of persona attributes -- share only what's needed for each interaction
- **Unlinkable pseudonyms** across contexts -- different interactions can't be correlated back to you
- **Cryptographic right to erasure** -- revoke a mandate and the data must be deleted
- **No central identity provider** -- you are the authority over your own identity

Your Personal Agent maintains a running **Persona Exposure Score** that tracks how much of your digital persona is inferrable from the aggregate of all attributes disclosed to all services. When that score crosses a threshold, your agent alerts you. This is privacy that works for you, not against you.

## Interoperability with Existing Standards

AIP doesn't exist in a vacuum. It builds on and unifies existing standards:

- **W3C DIDs v1.0** for identity
- **W3C Verifiable Credentials 2.0** for attestations
- **JSON-LD** for semantic interoperability
- **QUIC and HTTP/3** for transport
- **STIX/TAXII** for threat intelligence data
- Compatible with **MCP** (Anthropic), **A2A** (Google / Linux Foundation), and **ARDP** (Internet-Draft) protocols

The goal is composability, not replacement. Each layer can adopt best-of-breed implementations. And Design Principle 6 is explicit: AIP agents must be capable of falling back to traditional HTTP interactions when counterparties don't support the protocol. We're not creating a walled garden.

## What Comes Next

I've drafted a full RFC specification for AIP (AIP-001) that details the complete protocol stack, message formats, identity system, trust mechanisms, and application profiles. It covers everything from the `did:aip` method specification to dispute resolution panels to post-quantum cryptographic readiness. If you're interested in the technical depth, I'll be publishing that separately.

But the vision is this: we start with threat intelligence sharing as the proving ground. We demonstrate that autonomous agents can discover each other, verify trust, negotiate terms, share intelligence, and verify execution -- all within a framework that puts human sovereignty first. Then we expand to commerce, scheduling, content curation, and eventually the full breadth of digital life.

The internet was built for humans browsing documents. It's time to build one for agents acting on our behalf -- with our identity, under our control, within our boundaries.

That's the Agentic Web.

## References

### Identity and Credentials

- [W3C Decentralized Identifiers (DIDs) v1.0](https://www.w3.org/TR/did-core/) -- W3C Recommendation, July 2022. The foundation for self-sovereign, cryptographically verifiable digital identity.
- [W3C Verifiable Credentials Data Model v2.0](https://www.w3.org/TR/vc-data-model-2.0/) -- W3C Recommendation, May 2025. Standard for expressing cryptographically verifiable credentials.
- [W3C Bitstring Status List v1.0](https://www.w3.org/TR/vc-bitstring-status-list/) -- W3C Recommendation, May 2025. Privacy-preserving mechanism for credential revocation and suspension via bitstrings.
- [Self-Sovereign Identity (SSI)](https://en.wikipedia.org/wiki/Self-sovereign_identity) -- The identity model where individuals control their own credentials without relying on centralized providers.
- [OAuth 2.0 (RFC 6749)](https://www.rfc-editor.org/rfc/rfc6749) -- The current authorization framework that AIP's mandate system is designed to replace with a self-sovereign alternative.

### Cryptography and Privacy

- [Zero-Knowledge Proofs](https://en.wikipedia.org/wiki/Zero-knowledge_proof) -- Cryptographic method enabling one party to prove a statement is true without revealing the underlying data.
- [BBS Signature Scheme](https://datatracker.ietf.org/doc/draft-irtf-cfrg-bbs-signatures/) -- IRTF Internet-Draft for BBS+ signatures enabling selective disclosure and unlinkable proofs over verifiable credentials.

### Transport and Data Interchange

- [QUIC (RFC 9000)](https://www.rfc-editor.org/rfc/rfc9000) -- UDP-based multiplexed and secure transport protocol, May 2021.
- [HTTP/3 (RFC 9114)](https://www.rfc-editor.org/rfc/rfc9114) -- Application-layer protocol running over QUIC, June 2022.
- [WebSocket (RFC 6455)](https://www.rfc-editor.org/rfc/rfc6455) -- Protocol for persistent bidirectional communication, December 2011.
- [JSON-LD 1.1](https://www.w3.org/TR/json-ld11/) -- W3C Recommendation for linked data serialization in JSON, July 2020.

### Threat Intelligence

- [MITRE ATT&CK](https://attack.mitre.org/) -- Knowledge base of adversary tactics and techniques based on real-world observations. The [Command and Control tactic (TA0011)](https://attack.mitre.org/tactics/TA0011/) is directly relevant to the C2 infrastructure detection scenario described in this post.
- [STIX 2.1](https://docs.oasis-open.org/cti/stix/v2.1/os/stix-v2.1-os.html) -- OASIS Standard for structured threat information expression, June 2021.
- [TAXII 2.1](https://docs.oasis-open.org/cti/taxii/v2.1/taxii-v2.1.html) -- OASIS Standard for automated exchange of threat intelligence over HTTPS.
- [Traffic Light Protocol (TLP) v2.0](https://www.first.org/tlp/) -- FIRST's information sharing classification system (TLP:RED, TLP:AMBER, TLP:GREEN, TLP:CLEAR).
- [YARA](https://github.com/VirusTotal/yara) -- Pattern-matching tool for malware identification and classification.
- [FIRST (Forum of Incident Response and Security Teams)](https://www.first.org/) -- Global organization of incident response teams that maintains TLP.
- [National Council of ISACs](https://www.nationalisacs.org/) -- Coordinating body for the sector-based Information Sharing and Analysis Centers referenced in this post.

### Agent Protocols

- [Model Context Protocol (MCP)](https://modelcontextprotocol.io) -- Anthropic's open protocol for connecting AI agents to external tools and data sources, November 2024.
- [Agent-to-Agent Protocol (A2A)](https://github.com/google/A2A) -- Open protocol for agent-to-agent collaboration, originally created by Google (April 2025), now under the Linux Foundation.
- [Agent Registration and Discovery Protocol (ARDP)](https://datatracker.ietf.org/doc/draft-pioli-agent-discovery/) -- Internet-Draft for lightweight agent registration and discovery.

### Security Concepts

- [The Sybil Attack (Douceur, 2002)](https://www.microsoft.com/en-us/research/publication/the-sybil-attack/) -- The original paper defining Sybil attacks on peer-to-peer reputation systems.
