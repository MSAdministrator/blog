---
title: "From APIs to Intents: The End of Procedural Machine Communication"
date: 2026-04-09T23:45:00-04:00
draft: true

categories: [llm]
tags: [agent, llm, api, intent, architecture, aip, mcp, a2a, future]
author: "Josh Rickard"
---

I've spent years building integrations. REST APIs, SOAP endpoints, gRPC services, GraphQL queries, webhook receivers, message queues, etc. If two systems needed to talk, I've probably wired them together at some point. And every single time, the pattern is the same: I read the docs, I learn the endpoints, I map the parameters, I handle the auth, I write the glue code, and I pray the vendor doesn't push a breaking change on a Friday afternoon.

This is how machine-to-machine communication has worked for decades. The caller must know **exactly** what to ask for, **exactly** how to ask for it, and **exactly** where to send the request. It works. But I believe we're at the beginning of a fundamental shift -- one where machines stop speaking in rigid procedures and start speaking in **intents**.

This post is a deep dive into that shift. I'm going to trace the evolution of API paradigms, show you where LLMs have already started changing the game, introduce the concept of intent-based communication, walk through the emerging protocol landscape, and give you an honest critical analysis of where this breaks down. This isn't a prediction about next quarter. This is about the architectural trajectory of how systems will communicate over the next decade.

## The API Evolution: A Pattern of Increasing Abstraction

Every major API paradigm shift has followed the same pattern: abstract away more implementation detail from the caller. Let's trace it.

### SOAP and XML-RPC

SOAP was enterprise software's first serious attempt at standardized machine-to-machine communication. You had WSDLs that defined exact operations, XML schemas that described every parameter type, and envelope formats that wrapped every request in ceremony. The caller had to know the exact method signature, the exact XML structure, and the exact endpoint.

If you've ever worked with SOAP, you know the pain. The schemas were rigid, the payloads were bloated, and debugging a malformed XML envelope at 2AM is something I wouldn't wish on anyone. But SOAP gave us something important: a contract between systems. Both sides agreed on a structure, and the tooling enforced it.

### REST

REST stripped away the ceremony. Resources instead of methods. HTTP verbs instead of SOAP actions. JSON instead of XML. Stateless interactions instead of session-bound conversations. Roy Fielding's dissertation gave us an architectural style that became the dominant paradigm for web APIs, and for good reason -- it was simpler, more flexible, and mapped naturally to HTTP.

But REST still requires the caller to know a lot. You need to know the resource URIs (`/api/v2/users/123`), the supported HTTP methods, the parameter names and formats, the authentication mechanism, the pagination scheme, and the error response structure. You're still writing procedural code that says "send this exact request to this exact endpoint with these exact parameters."

### GraphQL

GraphQL was the first meaningful step toward declarative data access. Instead of the server dictating what data you get back (REST's over-fetching and under-fetching problem), the client declares what data it wants:

```graphql
{
  user(id: "123") {
    name
    email
    recentOrders {
      total
      status
    }
  }
}
```

This is significant. The client is expressing **what** it wants, not **how** to get it. It doesn't know or care whether `user` and `recentOrders` come from the same database, different microservices, or a cache layer. The server resolves the query. This is already a move toward intent -- "give me this shape of data" rather than "call these three endpoints and assemble the results."

But GraphQL still requires schema knowledge. You need to know the types, the fields, the arguments, and the relationships. The abstraction is over data shape, not over purpose.

### gRPC

gRPC optimized for performance with Protocol Buffers, strong typing, and bidirectional streaming. It's excellent for service-to-service communication in microservice architectures. But from an abstraction standpoint, gRPC is actually a step backward -- callers must know exact service definitions, exact method signatures, and exact protobuf message structures. The trade-off is performance and type safety for tight coupling.

| As a side note, I still [believe](https://github.com/modelcontextprotocol/modelcontextprotocol/discussions/1144) we should have used gRPC over the existing MCP model.

### The Pattern

Here's what matters: **SOAP abstracted the transport. REST abstracted the protocol. GraphQL abstracted the data shape.** Each generation removed a layer of implementation detail from the caller. The next logical step in this progression is to abstract away the **entire call sequence** -- to move from "call this endpoint with these parameters" to "here's what I'm trying to accomplish."

That's the intent paradigm.

## LLMs Already Changed the Game (You Just Didn't Notice)

Here's the thing -- if you've used function calling or tool use with any major LLM provider, you've already experienced proto-intent-based communication. You just might not have framed it that way.

When OpenAI launched function calling in June 2023, they introduced a pattern that fundamentally changed how APIs get consumed. Instead of a developer writing procedural code to call an API, you describe what tools are available (using JSON Schema), and the model decides **when** and **how** to use them based on the user's natural language request.

Anthropic, Google, and others followed with their own implementations. The pattern is the same across all of them:

1. You define tools with descriptions and parameter schemas
2. A user expresses what they want in natural language
3. The LLM interprets the **intent** behind the request
4. The LLM decomposes the request into one or more structured tool calls
5. Your application executes the calls and feeds results back
6. The LLM synthesizes a response

Read that flow again. The human never specifies an endpoint. The human never writes a query parameter. The human expresses what they want to accomplish, and the LLM figures out which tools to call, in what order, with what parameters. The LLM is acting as an intent resolution layer between the human and the API.

This is already a massive shift from traditional API consumption. But it has a critical limitation: the LLM is mediating between a human and a set of pre-defined tools within a single application. The tools are hard-coded. The endpoints are known in advance. The LLM is doing intent resolution, but within a closed system.

The question is: what happens when we generalize this pattern across systems, across organizations, across the entire network?

## What Intents Actually Are

Let me explain what I mean by "intent" because the term gets thrown around loosely.

A traditional API request tells the receiving system exactly what to do:

```
GET /api/flights?from=STL&to=LAX&date=2026-12-01&max_price=800
```

This requires the caller to know the endpoint path, the parameter names (`from`, `to`, `date`, `max_price`), the value formats (airport codes, ISO dates, numeric prices), and the service location. It encodes the how.

An intent tells the receiving system what the caller is trying to accomplish:

```yaml
intent:
  objective: purchase
  category: travel.flight
  constraints:
    hard:
      departure_city: STL
      arrival_city: LAX
      date_range: "2026-12-01 to 2026-12-03"
      price_max: 800
    soft:
      seat_preference: window  # priority: 0.8
      arrival_time: before 9AM  # priority: 0.6
```

The difference is not cosmetic. It's architectural. The intent separates **what** from **how** at the protocol level. The caller doesn't need to know the API endpoint, the parameter format, or even which service will handle the request.

It declares a desired outcome with constraints and preferences, and the receiving system (or network of systems) resolves it.

There are two categories of constraints, and this distinction matters:

* **Hard constraints** are non-negotiable. Violate any one of them and the response is invalid. The flight must depart from STL. It must arrive at LAX. It must cost less than $800.

* **Soft constraints** are preferences with priorities. A window seat is strongly preferred (0.8) but not required. Arriving before 9AM is moderately preferred (0.6) but negotiable. This allows the receiving system to rank solutions and make trade-offs -- something a traditional API request cannot express at all.

| Intents are semantically richer than API calls

They carry context, priorities, and flexibility that procedural requests simply cannot encode. And that context is exactly what autonomous agents need to negotiate, compare, and make decisions on your behalf.

## The Protocol Landscape: Where Things Stand Today

The idea of intent-based communication isn't theoretical anymore. Multiple protocols and standards are converging on this concept from different angles. Let me walk through the major ones and how they fit together.

### Model Context Protocol (MCP)

MCP solves the "integration" problem. MCP standardizes how AI agents connect to external tools and data sources using a client-server model over JSON-RPC 2.0.

MCP's primitives include **Tools** (executable functions), **Resources** (data sources), and **Prompts** (interaction templates). It was inspired by the Language Server Protocol (LSP), which standardized how IDEs interact with programming language tooling. The insight is the same: define a common protocol so that any client can work with any server.

MCP adoption is real. Claude Desktop, ChatGPT, VS Code with Copilot, Cursor, and many other tools support it. But MCP is fundamentally tool-centric, not intent-centric. It standardizes how an agent accesses tools, not how agents communicate desired outcomes to each other.

### Agent-to-Agent Protocol (A2A)

A2A was released as open-source in March of 2026 and tackles the agent-to-agent collaboration problem. Where MCP connects an agent to its tools, A2A connects agents to other agents.

A2A's core concepts include"

* Agent Cards - discovery documents describing capabilities
* Tasks - long-running collaborative workflows
* opacity principle - where agents collaborate without exposing internal state. 

It uses JSON-RPC 2.0 over HTTP with support for synchronous, streaming, and async communication.

A2A represents a meaningful step toward intent-based interaction. Agents discover each other through capability descriptions rather than hardcoded endpoints, and tasks are collaborative rather than procedural. But A2A's task model is still relatively structured -- it's closer to "delegate this task" than "resolve this intent."

### Intent-Based Agent Interconnection Protocol (IAIP)

IAIP a draft IETF [RFC](https://datatracker.ietf.org/doc/draft-sun-zhang-iaip/) is the most explicitly intent-focused protocol in the landscape. IOAIPO operates as a Gateway layer and introduces a three-layer intent model:

1. **Human intent** -- unstructured natural language ("I need a flight to LA")
2. **Task intent** -- abstract objectives with constraints
3. **Intent descriptors** -- machine-interpretable routing data with semantic vectors

IAIP draws directly from [Intent-Based Networking (IBN)](https://www.ibm.com/think/topics/intent-based-networking), a mature concept in network management where administrators declare desired outcomes ("ensure video traffic gets priority") and the system figures out the configuration. Cisco and Juniper have productized IBN for years. IAIP applies the same principle to agent communication.

### Natural Language Interaction Protocol (NLIP)

[ECMA-430](https://ecma-international.org/publications-and-standards/standards/ecma-430/) is the first formal international standard for natural language as an inter-agent communication protocol. [NLIP](https://nlip-project.org/#/) defines a protocol for AI-to-AI and human-to-AI communication using natural language as the primary medium.

This is notable because it formalizes something that the industry has been doing ad hoc: using natural language as a communication interface between systems. Whether NLIP gains traction alongside or instead of structured intent formats remains to be seen.

### How They Fit Together

Here's my mental model of the landscape:

```
MCP:   Agent <-> Tools (vertical integration)
A2A:   Agent <-> Agent (horizontal collaboration)
IAIP:  Intent routing and resolution (semantic layer)
NLIP:  Natural language as communication format
```

These aren't competing. They're complementary layers. MCP gives an agent its tools. A2A lets agents collaborate. IAIP routes intents to the right agents. NLIP standardizes the message format.

## Critical Systems Thinking: Where This Breaks Down

I would be doing you a disservice if I presented this as a smooth, inevitable transition. The move from procedural APIs to intent-based communication has real, hard, unsolved problems. Let me walk through them honestly.

### The Reliability Problem

This is the biggest one. Current LLMs fail to select the correct tool roughly half the time in unconstrained scenarios, according to LangChain's analysis of production agent deployments. Even Gorilla, a research project specifically fine-tuned for API calling, demonstrated that GPT-4 "hallucinates the wrong usage of an API call" with concerning frequency.

Intent-based systems compound this problem. A misinterpreted intent at the routing layer means the entire downstream execution is wrong. And unlike a procedural API call that either works or throws a clear error, a misrouted intent may produce a plausible-looking but incorrect result. You might not even know it failed.

For a traditional REST call, failure is binary: you get a 200 or you get an error. For an intent, failure can be **semantic** -- the system does something, but it's not what you meant. That's a fundamentally harder problem to detect, debug, and recover from.

### The Ambiguity Problem

Natural language is inherently ambiguous, and structured intents inherit some of that ambiguity. "Transfer $500" could mean a bank transfer, a file transfer, or a data migration depending on context. Even with structured intent objects, different agents may interpret the same constraints differently. What does "budget < $800" mean -- total including taxes and fees, or base price?

The IAIP draft addresses this with three-layer intent decomposition (human intent, task intent, intent descriptor), but the translation between layers is where errors creep in. Each layer of decomposition is an opportunity for semantic drift.

### The Determinism Problem

Traditional APIs are deterministic. The same input always produces the same output. This is critical for testing, auditing, compliance, and debugging. Intent-based communication is inherently stochastic -- the same natural language intent may be interpreted differently depending on context, model state, or available agents.

For regulated industries -- finance, healthcare, government -- this non-determinism is a potential dealbreaker without additional verification layers. If an auditor asks "why did your agent transfer $5,000 to this vendor?", you need a deterministic audit trail, not "the model interpreted the intent this way at that time."

This is solvable (deterministic guardrails around stochastic interpretation), but it adds complexity. You end up with hybrid architectures where the intent layer handles understanding and the execution layer enforces rules. That's a reasonable pattern, but it means intent-based systems aren't simpler than procedural ones -- they're differently complex.

### The Security Surface

Every layer of indirection is an attack surface. Intent-based routing introduces new vectors:

- **Prompt injection through intents**: Crafted intent objects that manipulate how receiving agents interpret the request
- **Capability spoofing**: Malicious agents advertising capabilities they don't have to intercept intents
- **Intent replay**: Re-submitting captured intents to trigger unauthorized actions
- **Semantic confusion attacks**: Crafting intents that are interpreted differently by different layers

The MCP specification itself acknowledges this directly: tool descriptions "should be considered untrusted, unless obtained from a trusted server." If you can't trust the tool descriptions, you certainly can't trust arbitrary intent objects from unknown agents on an open network.

### The Agent Communication Trilemma

A research survey by Yang et al. (April 2025) identifies a fundamental constraint they call the **Agent Communication Trilemma**: you cannot simultaneously optimize for **versatility** (supporting diverse message types), **efficiency** (minimizing computational costs), and **portability** (ease of implementation).

Intent-based protocols that support rich, flexible message types (high versatility) will be computationally expensive (low efficiency) and hard to implement (low portability). This isn't a solvable engineering problem -- it's a fundamental trade-off. Different domains will make different choices along this triangle, which is why I don't think a single intent protocol will rule them all.

### The Latency and Cost Problem

Intent interpretation adds a computational layer that pure API calls don't have. Every intent must be parsed, semantically matched, and routed -- operations that involve LLM inference or at minimum heavyweight vector similarity computation. For high-throughput, low-latency systems (trading, real-time telemetry, streaming data pipelines), intent-based routing may never be appropriate.

The future likely involves hybrid architectures: intent-based communication handles novel, complex, or ambiguous requests while traditional APIs handle known, high-frequency, deterministic patterns. The intent layer is the thinking layer. The API layer is the doing layer. Knowing when to use which is an architectural judgment call.

### The Standardization Race

As of early 2026, there are at least 17 competing agent protocols at various maturity levels. The XKCD "Standards" comic applies perfectly -- every new standard meant to unify previous ones just adds another standard. The merger of IBM's Agent Communication Protocol (ACP) into A2A under the Linux Foundation is a positive signal toward consolidation, but MCP and A2A remain separate ecosystems with different governance models. Add in IAIP, NLIP, ANP, Agora, and others, and you have a fragmented landscape that may slow adoption.

## The "AI-API Gap" and Why It Matters Now

Postman's 2025 State of the API report surfaced a data point that crystallizes where we are in this transition: **89% of developers use AI tools, but only 24% design APIs with AI agents in mind**.

That gap is the story. We're in a transition period where APIs are still designed for human developers to consume procedurally, even as AI agents are rapidly becoming the primary consumers. OpenAI alone commands 56% of AI API traffic at 4.2 million calls annually, with Gemini and Llama growing at 3x and 7x respectively.

If you're designing an API today and you're not thinking about how an LLM agent will consume it, you're designing for yesterday's users. This doesn't mean you abandon REST or GraphQL. It means you invest heavily in rich, semantic descriptions of what your endpoints do, clear capability boundaries, and unambiguous parameter documentation. The tool/function schemas used by OpenAI, Anthropic, and Google are effectively a new API description format optimized for LLM consumption -- and they need to be treated with the same rigor as your OpenAPI spec.

Anthropic's own research on building effective agents (December 2024) makes this explicit: "Treat tool design with equivalent rigor to prompt engineering." That's not a throwaway line. It's a design principle for a world where your API's primary consumer is a model, not a developer.

## Where This Is Heading

Let me lay out what I think the trajectory looks like over the next few years.

**Near-term (now - 2027):** Hybrid architectures dominate. Traditional APIs handle known, high-frequency interactions. LLM-mediated tool use handles novel or complex requests within closed systems. MCP and A2A gain adoption for tool integration and agent collaboration. API designers start adding richer semantic descriptions to existing endpoints. The "AI-API gap" starts closing.

**Medium-term (2027 - 2030):** Intent-based routing emerges for specific high-value domains -- threat intelligence sharing, travel booking, procurement, scheduling. These are domains where negotiation, trust, and flexibility matter more than raw throughput. IAIP-style semantic routing gets deployed in production. The protocol landscape consolidates around 2-3 major standards. Agent discovery becomes as routine as DNS resolution.

**Long-term (2030+):** Intent-based communication becomes the default for novel interactions between unfamiliar systems. Traditional APIs remain for high-frequency, well-defined, performance-critical paths. The boundary between the two blurs as systems learn to dynamically switch between procedural and intent-based communication based on context. Personal agents (as described in the [Agentic Web concept](/article/agentic-web/)) begin to emerge, initially in enterprise settings.

The critical insight is that **this isn't a replacement -- it's a new layer**. Just like REST didn't eliminate databases and GraphQL didn't eliminate REST, intent-based communication won't eliminate procedural APIs. It adds a semantic layer on top that handles the messy, ambiguous, negotiation-heavy interactions that procedural APIs were never designed for.

## What This Means for Practitioners

If you're building integrations today, here's what I'd focus on:

**Design APIs for machine consumption.** Your tool descriptions, parameter documentation, and capability boundaries are now as important as your endpoint design. Write them like a contract, not an afterthought.

**Invest in semantic richness.** The more context your API exposes about what it does and what it expects, the better LLM agents can use it. Don't just document the parameters -- document the purpose, constraints, and expected outcomes.

**Build for composability.** The MCP pattern of servers-as-clients creating capability graphs is going to become a dominant architecture. Design your services to be both providers and consumers of capabilities.

**Watch the protocol landscape.** You don't need to bet on one standard yet. But understanding MCP, A2A, and the intent-based protocols coming out of the IETF will inform your architectural decisions.

**Don't abandon determinism.** For anything touching money, compliance, or safety, keep deterministic guardrails around stochastic intent interpretation. The thinking layer can be probabilistic. The execution layer must be verifiable.

**Start with high-value, negotiation-heavy domains.** If you're in threat intelligence, procurement, scheduling, or any domain where interactions involve preferences, trade-offs, and multi-party negotiation, intent-based communication will provide the most immediate value. That's where procedural APIs are weakest and intents are strongest.

The shift from APIs to intents isn't happening overnight. But the trajectory is clear, the protocols are emerging, and the LLM capabilities that make it possible are improving rapidly. The question isn't whether this shift happens. It's whether you're designing for it.
