---
title: "Connect Your Bot to Slack"
date: 2018-08-10T22:28:08-04:00
draft: false

categories: [azure,slack]
tags: [bot,slack,chatbot]
author: "Josh Rickard"
---
In my previous two posts we created a knowledge base of questions and answers using QnAMaker and we created our Web App Bot in the Azure Portal.  Now that we have a bot created and it is responding as we intended, we can interact with our bot directly through our web browser (or embed it into a website) or we can integrate into our Slack workspace.  

Please make sure you have a Slack workspace created and you have access to create a Slack application.  [Login to your Slack workspace API](https://api.slack.com/apps) and select Create New App in the top right-hand corner.  You will need to give your new application a name and select the appropriate workspace to create your new application.

After your New App is created, select OAuth & Permissions and select Add.  Enter the following Redirect URL: [https://slack.botframework.com](https://slack.botframework.com) and click Save.

Next, go to Bot Users and select Add a Bot.  Give your bot a username and toggle the Always Show My Bot as Online button so that it says On.
  
Go to Events Subscription and select Enable Events.  Once there, enter the following URL and replace the {botname} with the name of your bot.

https://slack.botframework.com/api/Events/{botname}

If you are unsure of your bot’s name, you can find it under the My Bots section at [https://slack.botframework.com](https://slack.botframework.com).

Lastly, you will need to subscribe to (at minimum) the following bot events.

* member_joined_channel
* member_left_channel
* message.channels
* message.groups
* message.im
* message.mpim

Click Save.

<img src="add_a_request_url_and_subscribe_to_bot_events.png" style="max-width:100%;" alt="Add a Request URL and subscribe to bot events">

Select the Basic Information section scroll down until you see the App Credentials.  You will need to gather the following information to allow your Azure Web App Bot to be integrated into your Slack workspace.

* Client ID
* Client Secret
* Verification Token

<img src="Save your Slack Credentials to integrate into your new Azure Web App Bot.png" style="max-width:100%;" alt="Save your Slack Credentials to integrate into your new Azure Web App Bot">

Now that you have this information, head back over to your Azure Portal and your Web App Bot.  Once you are back there, select the Channels setting. 

I want to point out that you can integrate your bot with many other services besides Slack, and there are several built-in options for doing this with many popular services.  This article will only talk about integrating your bot with Slack.


<img src="select_channels_within_your_web_app_bot_resource_page_and_then_select_slack_to_integrate_your_bot_with_slack.png" style="max-width:100%;" alt="Select Channels within your Web App Bot resource page and then select Slack to integrate your bot with Slack">


Enter Application Credentials information from our Slack workspace into the Slack channel integration page on your Web App Bot Resource in the Azure Portal.  You only need to fill out the Client ID, Client Secret, and Verification Token fields.  Click Save.

You should be presented with a Verification page authorizing your bot to interact with your Slack workspace.

NOTE: If you run into an issue, you may need to ensure that you are still authorized/logged in by visiting [https://slack.botframework.com](https://slack.botframework.com).  

All you have to do now is login to your Slack workspace and your new bot should be available and ready to answer any and all of your questions! 

<img src="your_very_own_qna_bot_is_now_integrated_into_your_slack_workspace.png" style="max-width:100%;" alt="Your very own QnA Bot is now integrated into your Slack workspace">