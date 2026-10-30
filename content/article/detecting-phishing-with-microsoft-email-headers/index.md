---
title: "Detecting Phishing with Microsoft Email Headers"
date: 2026-01-19T10:00:00-06:00
draft: true

categories: [security,phishing,detection]
tags: [email-security,microsoft-365,office-365,spf,dkim,dmarc,headers,threat-detection,MQL,sublime-security]
author: "Josh Rickard"
original_url: "https://sublime.security/blog/getting-started-with-microsoft-email-headers-for-security/"
---

> I also wrote a companion post on the Sublime Security blog: [Getting started with Microsoft email headers for security](https://sublime.security/blog/getting-started-with-microsoft-email-headers-for-security/). It covers these headers with hunts written for Sublime's MQL. A copy of the original post is archived at the bottom of this page.


## Original Post: Getting started with Microsoft email headers for security

*Originally published August 27, 2026 on the [Sublime Security blog](https://sublime.security/blog/getting-started-with-microsoft-email-headers-for-security/). Archived here in case the original is removed.*

Whether you're a SOC analyst or a detection engineer, understanding Microsoft email infrastructure is advantageous for investigating and resolving email-based threats. If you're working at a Microsoft shop, you may have already seen Microsoft's recent [Phishing actors exploit complex routing and misconfigurations to spoof domains](https://www.microsoft.com/en-us/security/blog/2026/01/06/phishing-actors-exploit-complex-routing-and-misconfigurations-to-spoof-domains/) blog. That post gives a great overview of how adversaries are taking advantage of misconfigurations that can happen when a SEG (secure email gateway) is placed in front of Microsoft, as we can see from this line:

> The phishing attack vector covered in this blog post does not affect customers whose Microsoft Exchange mail exchanger (MX) records point to Office 365; these tenants are protected by native built-in spoofing detections.

That post mentions a lot of topics you may have read about on our blog before, like [Tycoon2FA PhaaS](https://sublime.security/blog/tycoon-2fa-credential-phishing-with-cloned-internal-employee-login/), [Direct Send](https://sublime.security/blog/direct-send-abuse-on-microsoft-365-just-another-failed-authentication/), [AITM](https://sublime.security/blog/aitm-phishing-with-russian-infrastructure-and-detection-evasion-from-a-lapsed-domain/), [fake invites](https://sublime.security/blog/youve-been-invited-to-join-a-meta-for-business-scam/), and more. After reading that post, though, we decided we wanted to talk about some of the ways attacks can be detected using information in typical Microsoft email headers. This blog will have some overlap with their blog, but will extend it by focusing on phishing detection within these headers.

While this will get in the weeds about email infrastructure, this post isn't being written for email experts. It's for anyone that wants to know more about how Microsoft headers could be used during investigations, like IT admins, Exchange admins, security folks, the overwhelmed help desk analyst at a 10 person company, and if you've made it this far, you too.

In each section, we'll look at:

- A brief summary of what the header field is
- Why it can be useful to IT and security teams
- An example threat hunt in MQL. [Start your free account](https://sublime.security/start) if you want to try it out.

### TL;DR on headers

Headers are data and metadata in email that helps a message get from outbox to inbox. They can include:

- Sender
- Recipient
- Content type
- Transport info
- Authentication and more

Aside from getting a message delivered, headers can also provide valuable information in IT troubleshooting and security investigations. In this post, we'll mostly be looking at Microsoft-specific headers, but we're going to start with an authentication header that spans all providers.

### Authentication-Results header

One of the most common headers, no matter if you're using Microsoft or not, is the `Authentication-Results` header. When it comes to detecting spoofing, authentication issues, sender account compromise, and more, this is the main header you will reference.

This header is used to verify and validate that a message was not forged and that it did not fail authentication along its path to your inbox. We're going to look at a few of the important pieces of this header so that you can understand what to look for when investigating emails.

The three main authentication standards used in this header are:

- SPF (Sender Policy Framework): A record in DNS that specifies which mail servers are authorized to send email on behalf of your domain, helping receiving servers detect forged sender addresses.
- DKIM (DomainKeys Identified Mail): A cryptographic signature on outgoing emails that receiving servers can verify against a public key in your DNS, proving the message wasn't tampered with in transit.
- DMARC (Domain-based Message Authentication, Reporting & Conformance): A record in DNS that evaluates both SPF and DKIM and then passes a status and a handling recommendations along to the receiving server. When an email fails those checks, DMARC sends a failure report to help monitor a domain's email activity.

Here is an example of the typical authentication header and its fields:

```text
spf=pass (sender IP is ####:f8b0:4864:20::112d)
 smtp.mailfrom=gmail.com; dkim=pass (signature was verified)
 header.d=gmail.com;dmarc=pass action=none header.from=gmail.com;compauth=pass
 reason=100
```

This header usually starts with `spf=[value]` and then has a few other keys and values. When it comes to security, we care mostly about the later half of the string where it states `dmarc=pass action=none` and `compauth=pass reason=100`. These pieces of information give us several detection opportunities.

#### SPF overview

SPF authentication looks at the `MAIL FROM` envelope value to verify that an email is sent from an email server authorized to send emails for that domain. To configure SPF, organizations set up a TXT record in their domain's DNS that explicitly states where a domain's email should be sent from. The format looks like:

```text
v=spf1 <mail sources> <rule>all
```

In human terms, this record is saying: Only Microsoft 365 mail servers (`spf.protection.outlook[.]com`) are authorized to send email for this domain. Fail anything else (`-`).

On the recipient side, there is an [Administrative Management Domain (ADMD)](https://datatracker.ietf.org/doc/html/rfc5598) where handling is configured. This determines what happens to emails based on their SPF status. For example, an ADMD could allow soft failed messages to arrive into a quarantine rather than go to an inbox. In a very strict environment, they could outright reject soft failures.

##### Security scope

For security, we don't care too much about `pass` (not spoofed) or `none` (not configured), but we do care about `fail`, `softfail,` and `temperror` (rare), as these indicate something went wrong when trying to validate SPF.

In general, SPF is not often used for detections. Instead, practitioners will look at the DMARC status, since it is created by evaluating both SPF and DKIM. We'll look at that shortly.

#### DKIM overview

DKIM is used to validate that content within an email (EML file) has not been altered in transit. DKIM does this by using a public and private key pair. The sender email admin will generate a key pair and store the `public` key in a TXT DNS record (never the `private` key). This key is then used for a digital signature on delivery. To get in the weeds about DKIM, [check out this doc from Microsoft](https://learn.microsoft.com/en-us/defender-office-365/email-authentication-dkim-configure).

Here's the format of a DKIM TXT record:

```text
// Note: There can be two different domains below, but only the first selector1_ is used.

Hostname: selector1._domainkey
Points to address or value: selector1-{yourdomain}-com._domainkey.{tenant}.onmicrosoft.com

Hostname: selector2._domainkey
Points to address or value: selector2-{yourdomain}-com._domainkey.{yourdomain}.com
```

##### Security scope

Just like with SPF, security practitioners generally do not build detection mechanisms around DKIM, just DMARC.

#### DMARC overview

While the first two methods verify that the email is from the correct `MAIL FROM` and that it hasn't been tampered with, they don't address `From:` spoofing. DMARC does, though. In order for DMARC to pass (a.k.a. DMARC alignment), it looks at SPF, DKIM, and the `From:` header.

DMARC first looks at the status of SPF and DKIM. If either pass, it will then verify that the domain of the sending server for the passing authentication method matches the domain of the `From:` address.

- If SPF passes, DMARC will verify that the `MAIL FROM` domain matches the `From:` domain.
- If DKIM passes, DMARC will verify that the DKIM `d=` domain matches the `From:` domain.

If either of those methods pass AND the sending domain matches the `From:` domain, then DMARC passes. Even if SPF passes and DKIM fails, DMARC passes.

On the flip side, even when both SPF and DKIM pass, if neither can match the `From:` domain to the sending domain, then DMARC fails.

For security teams, DMARC is the best option for detecting spoofing. For IT teams, DMARC also comes with failure reporting, so you can see when attackers are attempting to spoof you. Just like with SPF, the admin will create a TXT record for DMARC. Here's an example showing some of the available fields:

```text
v=DMARC1; p=reject; sp=quarantine; rua=mailto:dmarc-reports@example.com; ruf=mailto:dmarc-failures@example.com; pct=100
```

- `v`: version of DMARC
- `p`: policy for failures on the domain level (reject, quarantine, none)
- `sp`: policy for failures on the subdomain level (reject, quarantine, none)
- `pct`: percentage of messages to apply the policy to
- `ruf`: where to send per-message failure reports
- `rua`: where to send aggregate failure report

You may be looking at the `pct` field and wonder why anyone would set this below 100. Generally, this value is adjusted during implementation testing and will be set to 100 in production.

Unfortunately, many organizations do not set up SPF, DKIM, and DMARC correctly or enforce `reject` within their policies. This leaves a security gap that is very easy to resolve. If you're not sure if SPF, DKIM, and DMARC are configured properly, we'd recommend looking into it ASAP.

##### Security scope

DMARC results are useful in investigations of attacks that come from generally trusted senders. For example:

- Account spoofing: If DMARC is not aligned, it could be a solid indicator of a spoofed email. In these attacks, the email address may look legitimate, but the infrastructure it's sent from is not authorized, indicating the spoof.
- Account compromise/BEC: If DMARC is aligned, but the email shows other clear indicators of malicious intent, it's a strong signal that the (typically trusted) account has been compromised. In this case, a larger investigation would be required, including potentially reaching out to the security team for the compromised sender.

Now that we've covered these important authentication headers, let's dig into some Microsoft-specific types. These headers provide insights into behavior with your mail infrastructure as well as opportunities for detection.

### compauth: Microsoft Composite Authentication

Taking authentication validation a bit further, Microsoft offers `compauth`. If you are a Microsoft shop, you will likely use `compauth` as your authoritative means of validating authentication, as it goes beyond DMARC by using SPF, DKIM, DMARC, ARC (Authenticated Received Chain), spoof intelligence, sender reputation, and behavioral signals to do implicit authentication. Then, for each message received, a numeric reason code is provided which indicates success, failure, or neither, along with some explanation.

`compauth` gives organizations more security granularity, as well as more flexibility. This flexibility means Microsoft 365 can be configured to override statuses that you would assume would cause a failure. For example, `compauth` could be configured to pass even if DMARC fails (ex: ARC pass overrides a DMARC fail). This opens up the door for attackers who can find a way to sneak past certain configurations.

A [full list of compauth reason codes can be found here](https://learn.microsoft.com/en-us/defender-office-365/message-headers-eop-mdo#composite-authentication-reason-codes), but here are some we think are valuable from a security standpoint.

#### 108: DKIM fails, `compauth` passes

This code will arise when a message fails DKIM because of a modification to a message, but `compauth` still passes because the modification was made by trusted infrastructure (configured by the email admin). As an example, a `108` will likely occur when an SEG adds a banner to an email.

For security and IT teams, a `108` status can be used to identify compromised infrastructure. If an attacker has compromised a trusted piece of infrastructure, they could send a spoofed attack, slightly modify it with the compromised server so it gets a `108` reason code assigned, and then have it land in a target inbox. In this scenario, since attack will be coded as a `108` it will pass `compauth`.

To use these messages to identify compromised servers, threat hunters can search for all messages flagged as `malicious` that also have a `108` status. Here's an example hunt:

```javascript
type.inbound
and any(filter(headers.hops, .index == 1),
        any(filter(.fields, .name == "Authentication-Results"),
            (
              regex.contains(.value, 'dmarc=(fail|none)\saction=none')
              or regex.contains(.value,
                                'spf=(fail|softfail|temperror)\s\(sender\sIP\sis\s'
              )
            )
            and (
              // message failed DKIM due to the body being modified.
              // For example, the message body was modified in the organization's on-premises email environment.
              strings.contains(.value, 'reason=108')
            )
        )
)
```

#### Reason 451: Complex routing bypasses `compauth`

Reason `451` is specifically cited in the [blog linked at the start](https://www.microsoft.com/en-us/security/blog/2026/01/06/phishing-actors-exploit-complex-routing-and-misconfigurations-to-spoof-domains/) of this post as an example of a "complex routing situation." Complex routing could happen a few ways, like an MX routing that goes to a SEG first, or something as simple as the attacker using a distribution list (or Microsoft 365 group) to deliver the message. In that example, even though DMARC failed, `compauth` was bypassed due to route complexity, and a configuration on that server ended up sending it to spam via an `oreject` (override reject action). As a note, all `4xx` reasons indicate that `compauth` has been [bypassed entirely](https://learn.microsoft.com/en-us/defender-office-365/message-headers-eop-mdo#composite-authentication-reason-codes) (`compauth=none`).

Because `compauth` is completely bypassed by a `451`, it offers up a threat hunting opportunity. The below threat hunt catches authentication failures that "slipped through" due to policy configuration choices, meaning messages that should have been blocked, but were instead kicked over to spam. These represent potential spoofing attempts against domains without strict enforcement. Using this MQL with other suspicious indicators could help locate attacks that should have been quarantined (never reaches inbox), not marked as spam (reaches inbox). Remember that for attackers, the primary goal is to get through security, not hit an inbox. If they reach a spam folder, there is still a chance for success.

```javascript
type.inbound
and any(filter(headers.hops, .index == 1),
        any(filter(.fields, .name == "Authentication-Results"),
            (
              regex.contains(.value, 'dmarc=(fail|none)\saction=none')
              or regex.contains(.value,
                                'spf=(fail|softfail|temperror)\s\(sender\sIP\sis\s'
              )
            )
            and (
              // MX record points to on-premises Exchange environment
              // or third-party service before reaching Microsoft 365
              // but message delivered to spam folder
              strings.contains(.value, 'reason=451')
            )
            and not (
              // exclude passes
              regex.contains(.value, 'spf=(pass)\s\(sender\sIP\sis\s')
              // ignore proper action type when dmarc fails
              or regex.contains(.value, 'dmarc=fail\saction=oreject')
              // excluding properly configured dmarc failures
              // failed explicit email authentication
              or strings.contains(.value, 'reason=000')
              // failed implicit email authentication
              or strings.contains(.value, 'reason=001')
            )
        )
)
```

#### Reason 601: Identifying spoofing attempts

Reason `601` indicates DMARC/SPF failures where the attacker attempted to spoof your own domain. While a `601` can be a direct indicator of domain spoofing attacks targeting internal trust, they can also happen when a third-party app isn't properly configured to send from your domain.

In the case of an attack, an external sender tried to impersonate someone within your organization, but failed implicit authentication. "Implicit" authentication includes evaluating things like IP reputation, sender history, etc., and is used when "explicit" authentication (DMARC, SPF, etc.) isn't correctly configured.

Hunting down `601` messages can be helpful to security and IT alike. Security teams can use it to find spoofing attempts, and IT can use it to find improperly configured third-party apps, relays, legacy tools, and more. Here's an MQL hunt for finding them:

```javascript
type.inbound
and any(filter(headers.hops, .index == 1),
        any(filter(.fields, .name == "Authentication-Results"),
            (
              regex.contains(.value, 'dmarc=(fail|none)\saction=none')
              or regex.contains(.value,
                                'spf=(fail|softfail|temperror)\s\(sender\sIP\sis\s'
              )
            )
            and (
              // tried to impersonate within same domain but failed authentication
              strings.contains(.value, "reason=601")
            )
            and not (
              // exclude passes
              regex.contains(.value, 'spf=(pass)\s\(sender\sIP\sis\s')
              // ignore proper action type when dmarc fails
              or regex.contains(.value, 'dmarc=fail\saction=oreject')
              // excluding properly configured dmarc failures
              // failed explicit email authentication
              or strings.contains(.value, 'reason=000')
              // failed implicit email authentication
              or strings.contains(.value, 'reason=001')
            )
        )
)
```

#### Reason 905: Enforcement bypass

Reason `905` occurs when DMARC authentication failures bypass enforcement due to tenant allow policies for an "on-premises Exchange environment or a non-Microsoft service" that sits between the sender and Microsoft 365. An example of a "non-Microsoft service" would be an SEG.

In the case of a `905`, messages that failed authentication were delivered anyway because an admin policy explicitly permitted them. This could indicate overly permissive allow-lists being exploited by attackers spoofing "trusted" domains. This is similar to `451`, but since it's a different reason code, it presents another threat hunting opportunity.

```javascript
type.inbound
and any(filter(headers.hops, .index == 1),
        any(filter(.fields, .name == "Authentication-Results"),
            (
              regex.contains(.value, 'dmarc=(fail|none)\saction=none')
              or regex.contains(.value,
                                'spf=(fail|softfail|temperror)\s\(sender\sIP\sis\s'
              )
            )
            and (
              // MX record points to on-premises Exchange environment
              // or third-party service before reaching Microsoft 365
              strings.contains(.value, 'reason=905')
            )
            and not (
              // exclude passes
              regex.contains(.value, 'spf=(pass)\s\(sender\sIP\sis\s')
              // ignore proper action type when dmarc fails
              or regex.contains(.value, 'dmarc=fail\saction=oreject')
              // excluding properly configured dmarc failures
              // failed explicit email authentication
              or strings.contains(.value, 'reason=000')
              // failed implicit email authentication
              or strings.contains(.value, 'reason=001')
            )
        )
)
```

### X-Forefront-Antispam-Report

`X-Forefront-Antispam-Report` is a Microsoft-specific header that's applied by Microsoft Exchange Online Protection (EOP). This header tells you a great deal about how a message was handled by EOP. Here's an example `X-Forefront-Antispam-Report` and what the fields mean:

```text
X-Forefront-Antispam-Report: CIP:###.0.113.20; CTRY:US; LANG:en;
SCL:5; SFV:SPM; IPV:NLI; SFP:; PTR:mail.example.com;
CAT:SPOOF; SFTY:9.19; SRV
```

`CIP`, `CTRY`, and `LANG` are self-explanatory, but the handling information is right after that ([full list here](https://learn.microsoft.com/en-us/defender-office-365/message-headers-eop-mdo#x-forefront-antispam-report-message-header-fields)):

- `SCL`: Spam confidence level from `-1` (not checked) to `9` (very likely spam).
- `SFV`: Spam filter verdict
  - `SKS`: marked as spam before filtering
  - `SPM`: marked as spam
  - `SKN`: bypassed filtering via a transport rule
  - `SFE`: safe, not filtered
  - `SKI`: skipped filtering because the source IP was in the connection-filter IP Allow List
- `CAT`: Verdict category
  - `SPM`: spam
  - `PHSH`: phish
  - `SPOOF`: spoof
  - `BULK`: bulk mail
  - `MALW`: malware
  - `GIMP`/`UIMP`: impersonation
- `SFTY`: Safety indicator. Here are some examples for spoofing and phishing:
  - `9.19`: domain impersonation
  - `9.20`: user impersonation
  - `9.25`: first contact safety tip triggered
- `PTR`: reverse DNS of the connecting IP

These values can be useful for threat hunting. Similar to `451` threat hunting, we can use spam labeling as a signal along with other malicious signals to see if attacks have been mislabeled. Here's an example hunt:

```javascript
type.inbound
and any(filter(headers.hops, .index == 0),
        any(filter(.fields, .name == "X-Forefront-Antispam-Report"),
            (
              // High confidence spam
              strings.contains(.value, "CAT:HSPM")
              // Outbound spam
              or strings.contains(.value, "CAT:OSPM")
              // General spam
              or strings.contains(.value, "CAT:SPM")
              // spam because it matched a sender in the blocked senders list
              // or blocked domains list in an anti-spam policy.
              or strings.contains(.value, "SFV:SKB")
              // The message was marked as spam before processing by spam filtering.
              or strings.contains(.value, "SFV:SKS")
              // The message was marked as spam by spam filtering.
              or strings.contains(.value, "SFV:SPM")
              // identified as bulk by spam filtering
              // and the bulk complaint level (BCL) threshold
              or strings.contains(.value, "SRV:BULK")
            )
            and not (strings.contains(.value, "CAT:NONE;"))
        )
)
```

#### Impersonation hunting

Beyond spam, we can use this header to find impersonation attempts. These emails aren't necessarily in a spam folder and their location is dependent on configuration choices:

```javascript
type.inbound
and any(filter(headers.hops, .index == 0),
        any(filter(.fields, .name == "X-Forefront-Antispam-Report"),
            (
              // Mailbox intelligence impersonation policy applied
              strings.contains(.value, "CAT:GIMP")
              // identified as phishing but intra org impersonation
              or strings.contains(.value, "SFTY:9.11")
              // identified as phishing and domain impersonation
              or strings.contains(.value, "SFTY:9.19")
              // identified as phishing and User impersonation.
              or strings.contains(.value, "SFTY:9.20")
              // identified as phishing but cross domain spoofing
              or strings.contains(.value, "SFTY:9.22")
              // SPOOF
              or strings.contains(.value, "CAT:SPOOF")
              // User impersonation
              or strings.contains(.value, "CAT:UIMP")
            )
            and not (strings.contains(.value, "CAT:NONE;"))
        )
)
```

#### Phish hunting

Just like with impersonation hunting, we can do the [same for phish](https://learn.microsoft.com/en-us/defender-office-365/anti-phishing-protection-spoofing-about). The below hunt will find any emails labeled as phish and can be used with other malicious signals to find attempts that haven't been quarantined:

```javascript
type.inbound
and any(filter(headers.hops, .index == 0),
        any(filter(.fields, .name == "X-Forefront-Antispam-Report"),
            (
              //  High confidence phishing
              strings.contains(.value, "CAT:HPHISH")
              // identified as phishing but intra org impersonation
              or strings.contains(.value, "SFTY:9.11")
              // identified as phishing and domain impersonation
              or strings.contains(.value, "SFTY:9.19")
              // identified as phishing and User impersonation.
              or strings.contains(.value, "SFTY:9.20")
              // identified as phishing but cross domain spoofing
              or strings.contains(.value, "SFTY:9.22")
              // First contact safety tip
              or strings.contains(.value, "SFTY:9.25")
            )
            and not strings.contains(.value, "CAT:NONE;")
        )
)
```

#### Misconfiguration hunting (this one's for IT)

There are other ways we can use this data, especially when wanting to identify misconfigurations within an environment. Using the below threat hunt along with the spam hunt, you can find messages that reached a user's mailbox even though they were on a Block Senders list:

- Skipped spam filtering
- Released from quarantine
- On user's Blocked Senders list

```javascript
type.inbound
and any(filter(headers.hops, .index == 0),
        any(filter(.fields, .name == "X-Forefront-Antispam-Report"),
            (
              // skipped spam filtering since source IP was in allow list
              strings.contains(.value, "IPV:CAL")
              // released from quarantine & sent to the intended recipients
              or strings.contains(.value, "SFV:SKQ")
              // Filtering skipped and was blocked because it was sent
              // from an address in a user's Blocked Senders list.
              or strings.contains(.value, "SFV:BLK")
            )
            and not (strings.contains(.value, "CAT:NONE;"))
        )
)
```

### X-MS-Exchange-Organization-* headers

The following `X-MS-Exchange-Organization-*` family of headers are unique, as they are considered internal to Microsoft and they are stamped by Exchange during transport by EOP. This also means these headers are actually stripped/added at organization boundaries. We're going to look at a few of these headers. For length, we won't include hunts for every header.

#### X-MS-Exchange-Organization-InternalOrgSender

The `InternalOrgSender` header has a boolean value which indicates whether the sender is marked as internal or not. Typically a sender is marked internal based on whether it is a tenant mailbox, an authorized hybrid on-premises server, or a properly configured inbound connector.

The `InternalOrgSender` header works in conjunction with the `MessageDirectionality` and `AuthAs` headers to determine if a sender is considered internal or external. We'll cover those two headers later in this post.

From a spoofing perspective, the most important combination to be aware of for this header is:

- `InternalOrgSender` is `True`
- `AuthAs` is `Anonymous`
- `MessageDirectionality` is `Incoming`

What this combination means is that the message is from within your organization, but it's being sent anonymously, and somehow is coming from outside your organization. Generally speaking, internal messages are `internal`, not `anonymous` and directionality is `originating`, not `incoming`. This could be benign, but it could also be indicative of a spoofed message or an infrastructure misconfiguration. In any case, it is worth investigating further. The below hunt can be used to find these messages:

```javascript
type.inbound
and any(filter(headers.hops, .index == 0),
        // the sender claims to be internal
        any(filter(.fields,
                   .name == "X-MS-Exchange-Organization-InternalOrgSender"
            ),
            strings.icontains(.value, "true")
        )
        // the sender did not authenticate when sending the message
        and any(filter(.fields, .name == "X-MS-Exchange-Organization-AuthAs"),
                strings.contains(.value, "Anonymous")
        )
        // where the message was received from
        and any(filter(.fields,
                       .name == "X-MS-Exchange-Organization-MessageDirectionality"
                ),
                strings.contains(.value, "Incoming")
        )
)
```

Here's a full list of combinations and what they could mean:

| InternalOrgSender | MessageDirectionality | AuthAs | Meaning |
| --- | --- | --- | --- |
| True | Incoming | Internal | Cross-prem mail treated as internal (e.g., hybrid on-prem → Exchange Online (EXO) over the org connector). Legit in hybrid; if unexpected, check for connector abuse. |
| True | Originating | Internal | Normal internal/outbound mail. Authenticated tenant mailbox or properly configured hybrid on-prem server. If malicious: compromised account or insider. |
| True | Incoming | Anonymous | Should not occur / red flag. Internal-sender flag on unauthenticated inbound mail means header firewall failure or a misconfigured inbound connector granting org permissions. |
| True | Originating | Anonymous | Contradictory; should not occur. Anonymous submissions get org headers stripped (header firewall). If seen: header injection or broken connector permissions. |
| False | Incoming | Internal | Trusted partner/third-party connector mail (certificate- or IP-scoped) carrying external senders. Normal for partner flows, mail filters in front of EXO. |
| False | Originating | Internal | Authenticated submission but sender not resolved as org sender (e.g., app/service using SMTP AUTH or a connector with a non-accepted-domain From). Uncommon; worth review. |
| False | Incoming | Anonymous | Standard external internet mail. If the From domain is internal here → intra-org spoofing / Direct Send abuse signal. |
| False | Originating | Anonymous | Contradictory/rare. Originating implies org origin. Likely misconfiguration if observed. |

#### X-MS-Exchange-Organization-MessageDirectionality

The `MessageDirectionality` header provides context as it relates to how the message arrived in the environment. This header is an internal header that is applied/stamped by EOP based on the transport rule that was applied to the message, thus indicating directionality:

- Originating: The message originated inside the org: an Exchange Online mailbox, or on-premises Exchange arriving over an inbound connector of type `OnPremises` (hybrid). These messages are less scrutinized for internal to internal validation like SPF validation, spoof verdicts, phishing detection, and anti-impersonation controls.
- Incoming: The message arrived at an accepted domain without matching an `OnPremises` connector; treated as external, full EOP filtering applies.

From a security perspective, message directionality is something that can be trusted. This value can't be spoofed, so if a message says it's from an internal sender but has an `incoming` directionality, you can treat that message as suspicious. It's a great signal to use in a hunt, which we've used in a few of the different samples above and below.

#### X-MS-Exchange-Organization-ASDirectionalityType

This header has a numeric value which indicates its directionality (similar to `MessageDirectionality`), but is provided by Microsoft's anti-spam pipeline in EOP. It's what the anti-spam service uses to track directionally. It has three possible values:

- `1`: incoming from outside the organization
- `2`: outgoing to outside the organization
- `3`: intra-organization

This is different from the `MessageDirectionality`, but the two should always align (just from different perspectives and independent of each other). If you're using one, you likely don't need to use the other.

#### X-MS-Exchange-Organization-AuthSource

`AuthSource` is the [FQDN of the Exchange server](https://learn.microsoft.com/en-us/exchange/header-firewall-exchange-2013-help#organization-x-headers-and-forest-x-headers-in-exchange) that authenticated the incoming message. This value is useful for security purposes when used in conjunction with `AuthAs: Internal`. Since `AuthSource` should be an internal server, `AuthAs` should be `Internal`. If it's not, it is an indication of spoofing. Here's an example threat hunt:

```javascript
type.inbound
and any(filter(headers.hops, .index == 0),
        // This means that the authsource is not an approved org domain
        any(filter(.fields, .name == "X-MS-Exchange-Organization-AuthSource"),
            all($org_domains, not strings.icontains(..value, .))
        )
)
```

#### X-MS-Exchange-Organization-AuthAs

`AuthAs` is a straight forward header that is helpful for identifying internal spoofing. It has two values: `Anonymous` and `Internal`. If a message gets the value `Anonymous`, that means it was sent from a mailbox outside of your org (ie. not authenticated internally). As covered earlier, this in combination with `X-MS-Exchange-Organization-MessageDirectionality` is an indicator that either that a message is a spoof of an internal sender or there is a misconfiguration. As a note, this header is similar to `X-MS-Exchange-CrossTenant-AuthAs` and can be used in lieu.

As covered above, the values for `X-MS-Exchange-Organization-MessageDirectionality` are `Originating` and `Incoming`. See the table below for more details on the different scenarios:

| AuthAs | MessageDirectionality | Meaning |
| --- | --- | --- |
| Anonymous | Incoming | Normal external email; no authentication required. |
| Anonymous | Originating | Potential misconfiguration; unauthenticated message marked as originating internally. |
| Internal | Incoming | Redirect scenario, potential hybrid configuration, potential misconfiguration; verify hop domain consistency. |
| Internal | Originating | Normal internal email; authenticated and originating from within the organization. |

We already used these fields for a security hunt up above, so for IT teams, we can use the below hunt to look for possible misconfigurations. In this case, we'll find unauthenticated messages marked as originating internally that have [bypassed the spam filter check](https://learn.microsoft.com/en-us/exchange/content-filtering-exchange-2013-help).

```javascript
type.inbound
and any(filter(headers.hops, .index == 0),
        // the sender did not authenticate when sending the message
        any(filter(.fields, .name == "X-MS-Exchange-Organization-AuthAs"),
            strings.contains(.value, "Anonymous")
        )
        // the sender is external
        and any(filter(.fields,
                       .name == "X-MS-Exchange-Organization-MessageDirectionality"
                ),
                strings.contains(.value, "Incoming")
        )
        // bypassed spam filters
        and any(filter(.fields, .name == "X-MS-Exchange-Organization-SCL"),
                strings.contains(.value, "-1")
        )
)
```

#### Critical: MessageDirectionality > AuthAs

When `X-MS-Exchange-Organization-MessageDirectionality: Incoming` is present, the message came from outside the organization, regardless of what `X-MS-Exchange-Organization-AuthAs` says. This scenario occurs when:

- Mail is redirected internally from an external message
- Complex routing causes Microsoft to stamp internal auth on inbound mail
- Hybrid Exchange environments produce conflicting header signals

From a security perspective, messages with `AuthAs: Internal` + `MessageDirectionality: Incoming` should be treated with heightened scrutiny, as they represent a conflict between trust signals and spoofing signals. Here's a hunt for that:

```javascript
type.inbound
and any(filter(headers.hops, .index == 0),
        // the sender did authenticate when sending the message
        any(filter(.fields, .name == "X-MS-Exchange-Organization-AuthAs"),
            strings.contains(.value, "Internal")
        )
        // the sender is external
        and any(filter(.fields,
                       .name == "X-MS-Exchange-Organization-MessageDirectionality"
                ),
                strings.contains(.value, "Incoming")
        )
)
```

#### X-MS-Exchange-Organization-SCL

We looked at this briefly at the start of this section, but `SCL` provides insight into the EOP [spam confidence level](https://learn.microsoft.com/en-us/exchange/antispam-and-antimalware/antispam-protection/antispam-stamps?view=exchserver-2019#the-spam-confidence-level-stamp) determination for a message. The hunt below can used to surface the messages EOP has flagged as mid to high confidence spam in order to see if you need determine if SCL policies should be adjusted at all:

```javascript
type.inbound
and any(filter(headers.hops, .index == 0),
        // highest spam confidence level
        any(filter(.fields, .name == "X-MS-Exchange-Organization-SCL"),
            regex.contains(.value, '[5-9]')
        )
)
```

#### X-MS-Exchange-Organization-PCL

`PCL` is the [phishing confidence level](https://learn.microsoft.com/en-us/exchange/antispam-and-antimalware/antispam-protection/antispam-stamps?view=exchserver-2019#the-phishing-confidence-level-stamp). You can use it the same way you'd use the `SCL` level.

> PCL is a legacy Exchange/Content-Filter construct, effectively deprecated in Exchange Online (modern signals are CAT/SFTY/compauth).

```javascript
type.inbound
and any(filter(headers.hops, .index == 0),
        // The message content is likely to be phishing.
        any(filter(.fields, .name == "X-MS-Exchange-Organization-PCL"),
            regex.contains(.value, '[4-8]')
        )
)
```

### X-Microsoft-Antispam

`X-Microsoft-Antispam` is a broad name for a (currently) narrow header. As of publication, this header is used for assigning a `BCL` ([bulk complaint value](https://learn.microsoft.com/en-us/defender-office-365/anti-spam-bulk-complaint-level-bcl-about)) level. The value assigned correlates to the amount of complaints received for a type of bulk mail (ie. marketing spam). Microsoft uses unsubscribe, send to spam, and other actions to aggregate sender infrastructure data to calculate this value. Here's a hunt that can be used similar to the `PCL` and `SCL` hunts:

```javascript
type.inbound
and any(filter(headers.hops, .index == 0),
        // bulk sender that generates a high number of complaints
        any(filter(.fields, .name == "X-Microsoft-Antispam"),
            regex.contains(.value, 'BCL:[8-9]')
        )
)
```

### X-Microsoft-Antispam-Mailbox-Delivery

The `X-Microsoft-Antispam-Mailbox-Delivery` header tells you where a message ended up – inbox, junk folder, quarantine, or delete – and why it ended up there. Here's an example:

```text
ucf:0;jmr:0;auth:0;dest:J;OFR:SpamFilterAuthJ;ENG:(910005)(944490095)(944506478)(944626604)(4710137)(4715077)(4999163)(920097)(930201)(3100021)(140003);RF:JunkEmail;
```

As of publishing, this header is not well documented, so here is a table of values that we find helpful:

| Field | Value | Description |
| --- | --- | --- |
| auth | 0 | Authentication failed |
| auth | 1 | Authentication passed |
| ucf | 1 | User controlled filtering (yes) |
| jmr | 0 | Junk mail filtering (no) |
| dest | J | Server-side decision to deliver to Junk Mail |
| dest | I | Server-side decision to deliver to Inbox |
| dest | C | Server-side decision to deliver to user-specified (custom) folder |
| OFR | CustomRules | Outlook rule determined delivery of this message |
| OFR | SpamFilterAuthJ | Exchange determined delivery of this message, possibly using mailbox spam rules |
| wl | 1 | Sender or recipient on white list and considered safe |
| wl | 0 | Sender is not on white list |
| pcwl | - | Sender or recipient on policy controlled white list |
| rwl | 1 | Recipient on recipient white list |
| abwl | 1 | Auto-block white lists |
| iwl | - | IP white list |
| dwl | 1 | Domain white list |
| dkl | - | Domain kill list |
| RF | JunkEmail | Reason failure |

The contents of this header can be very useful for hunts. For example, using these values, we can see which emails have been allowlisted so they reach a user's inbox instead of spam. With that info, an admin could adjust the `SCL` for mail that's set to spam that users actually want.

This header is also good for identifying messages flagged as malicious that are getting through because of a white list configuration. For example:

```javascript
type.inbound
and any(filter(headers.hops, .index == 0),
        any(filter(.fields, .name == "X-Microsoft-Antispam-Mailbox-Delivery"),
            (
              // Sender or recipient on white list and considered safe
              strings.contains(.value, "wl:1")
              // Sender or recipient on policy controlled white list
              or strings.contains(.value, "pcwl:1")
              // Recipient on recipient white list
              or strings.contains(.value, "rwl:1")
              // sender on Auto-block white lists
              or strings.contains(.value, "abwl:1")
              // Sender on domain white list
              or strings.contains(.value, "dwl:1")
            )
            // server side delivered the message to the users mailbox
            and strings.contains(.value, "dest:I;")
            // and the message was delivered (e.g. not delivered to junk mail)
            and not (
              // Server-side decision to deliver to Junk Mail
              strings.contains(.value, "dest:J;")
            )
        )
)
```

We can also find messages that are delivered to a user's custom folder based on a user controlled filter. This is indicative of a few things like a custom mail rule or content filter based on the user preferences:

```javascript
type.inbound
and any(filter(headers.hops, .index == 0),
        any(filter(.fields, .name == "X-Microsoft-Antispam-Mailbox-Delivery"),
            // User controlled filter was set to True
            strings.contains(.value, "ucf:1")
            // server side delivered the message to custom folder
            and strings.contains(.value, "dest:C;")
            // and the message was delivered (e.g. not delivered to junk mail)
            and not (
              // Server-side decision to deliver to Junk Mail
              strings.contains(.value, "dest:J;")
            )
        )
)
```

### Conclusion

This has been just a small sampling of a much larger Microsoft header ecosystem, but these are all headers we've found useful for threat hunting. More often than not, we use them in tandem with other signals to refine our hunts.

We hope this blog helps you understand a little bit about the nuances and specifics around Microsoft email headers, especially if you are investigating, troubleshooting, or hunting for threats in environments. If there are any headers we didn't mention that you use regularly, reach out on X or LinkedIn (linked below) and let us know. Happy hunting!
