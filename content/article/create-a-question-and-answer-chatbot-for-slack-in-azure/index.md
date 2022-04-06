---
title: "Create a Question and Answer Chatbot for Slack in Azure"
date: 2018-08-10T21:28:54-04:00
draft: false

categories: [azure]
tags: [bot,slack,chatbot]
author: "Josh Rickard"
---

Chatbots are all the rage right now, and they have proven to be extremely useful for organizations around the globe.  You can have simple bots that take lunch orders or tell you the weather in your location. You can also bots tht act as part of an [advanced distributed security alerting system](https://slack.engineering/distributed-security-alerting-c89414c992d6).  Whatever the reason, bots are not going anywhere anytime soon.

To create our chatbot we are going to use a few different services.  Please make sure that you have all the necessary access setup and ready to go before proceeding. Here is the list of services we will be using:

* [QnAMaker](https://qnamaker.ai/)
* (Azure Portal](https://portal.azure.com)
* [Microsoft Bot Framework](https://slack.botframework.com)
* [Slack](https://slack.com) (you will need your own Slack workspace)

You can find three posts below that walk you through creating this ChatBot:

* [Using QnAMaker to Create a ChatBot](../using-qnamaker-to-create-chatbot/)
* [Create a Web App Bot using Azure Bot Services](../create-a-web-app-bot-using-azure-bot-services/)
* [Connect Your Bot to Slack](../connect-your-bot-to-slack/)

Below I will break down why for two of the services above.  Both the Azure Portal and Slack should be obvious.

## QnAMaker

QnAMaker is a unique service provided by Microsoft that allows you to easily create, train, and deploy a FAQ bot based on your existing documentation.  This service allows you to visually train your bot and organize your dataset to respond to questions it receives.  These types of bots are perfect for customer service or a general FAQ service for your product or applications.  

One of the great benefits of this service is that it can ingest data in many differnet forms and locations.  For example, you can import information based on a URL or upload a PDF, Word Document, etc.  QnAMaker will attempt to parse source of your data as best as it can.  It works fairly well even when your document does not follow their suggested standards, but I recommend that you [follow their guidelines](https://docs.microsoft.com/en-us/azure/cognitive-services/qnamaker/concepts/data-sources-supported) to better results.

The training mode, as I will continue to explain the full posts, is definitely worth it's weight in `code`.  It easy to visualize your training results and allows you adjust live.  This is a really important feature, especially as you learn the in-and-outs of making Question & Answer bots.

## Microsoft Bot Framework

The Microsoft Bot Framework is the `meat` and `potatoes` of creating a FAQ or Question & Answer bot.  This framework is directly synced to Azure portal and provided the webhooks and traditional capabilities you need to create any type  of bot.  That being said, these blog posts will only be talking about creating an Question & Answer Bot using both Azure and Slack.  

Microsoft Bot Framework allows you to create bots that integrate with many different services like your eCommerce site, Facebook, Cortana, etc. etc.  The list goes on and on.

I hope you enjoy this series on creating your very own ChatBot using Azure and Slack!