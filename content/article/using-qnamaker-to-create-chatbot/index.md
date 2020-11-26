---
title: "Using Qnamaker to Create Chatbot"
date: 2018-08-10T21:55:42-04:00
draft: false

categories: [azure]
tags: [bot,qnamaker,chatbot]
author: "Josh Rickard"
---
<script async src="//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js"></script>
<script>
  (adsbygoogle = window.adsbygoogle || []).push({
    google_ad_client: "ca-pub-1514695391372140",
    enable_page_level_ads: true
  });
</script>

The first thing we need to do is login to [QnAMaker](https://qnamaker.ai).  QnA Maker is a Microsoft service that allows you to easily generate a bot using either existing documentation for a product (or service) or you can create your own questions and answers – hence the name QnA Maker.  

Login to QnAMaker and navigate to the Create a knowledge base tab.  You will need to walkthrough 5 steps to create your knowledge base.  Luckily, Microsoft has provided clear instructions to make this as simple as possible.

<img src="follow_the_5_steps_provided_by_microsoft_to_create_your_knowledge_base_bot.png" style="max-width:100%;" alt="Follow the 5 steps provided by Microsoft to create your knowledge base bot">

The 5 steps you will need to follow are:

* Create a QnA service in Microsoft Azure
* Connect to QnA service to you KB
* Name your KB
* Populate your KB
* Create your KB

## Step 1: Create a QnA service in Microsoft Azure

You will need to have access to a Microsoft Azure account to continue from this point.  If you do not have an Azure account, you can [get a free trial](https://azure.microsoft.com/en-us/offers/ms-azr-0044p/) ($200 Azure Credits).  On step 1, click the Create a QnA service button.  You should be directed [here](https://portal.azure.com/#create/Microsoft.CognitiveServicesQnAMaker).

Once logged in, you will need to provide some information to create the new QnA service.  Once you have filled out the required fields then click Create.  You will be redirected to your Azure Portal dashboard while the service is being created.

<img src="create_your_new_qna_maker_service_by_filling_out_the_required_fields.png" style="max-width:100%;" alt="Create your new QnA Maker service by filling out the required fields">

## Step 2: Connect to QnA service to you KB

Navigate back to your previous tab (qnamaker.ai) and scroll down to Step 2.  You will need to select, from the next three dropdown menu’s, the appropriate resources to use.  For me, step 2 looks like the following screenshot.

<img src="select_your_microsoft_azure_account,_subscription_name,_and_the_recently_created_qna_service.png" style="max-width:100%;" alt="Select your Microsoft Azure account, subscription name, and the recently created QnA service">

If for some reason your QnA service is NOT listed in the dropdown, you will need to reload the website to get it to populate correctly.

## Step 3: Name your KB

This step is really straightforward; name your knowledge base.  

## Step 4: Populate your KB

There are several different ways to populate your knowledge base (KB).  You can point QnAMaker to a URL or upload a document that contains information you would like your bot to use as your questions and answers.  

For my example, I am going to be using a FAQ markdown page provided by the PowerShell team.  [Here is the full URL](https://github.com/PowerShell/PowerShell/blob/master/docs/FAQ.md)

<img src="populate_your_knowledge_base_with_either_a_url,_document,_or_manually.png" style="max-width:100%;" alt="Populate your knowledge base with either a URL, document, or manually">

## Step 5: Create your KB

After you have selected to populate your knowledge base by a URL, uploaded document, or decided to wait to manually add your knowledge base data, you should now select the Create your KB button.  

Depending on how you chose to populate your knowledge base, this may take no time at all or a few minutes.  

<img src="loading_screen_while_your_knowledge_base_is_created.png" style="max-width:100%;" alt="Loading screen while your knowledge base is created">

Once your knowledge base is created, you should be presented with a screen that looks similar to the following screenshot (depending on your knowledge base source).  QnAMaker does a really decent job of parsing input to create your knowledge base “key value pair” (e.g. database).  If you want to add, delete, or modify any of the existing questions and answers you can do so now.

<img src="your_knowledge_base_is_a_generated_list_of_key_value_pairs.png" style="max-width:100%;" alt="Your knowledge base is a generated list of key value pairs">

At the top of your knowledge base you have several tabs.  Once you have modified your questions and answers, you should select Save and train.  Again, depending on the changes you made this may take no time or a few minutes.  

Once you have saved, you can either go ahead and Publish your QnA knowledge base or you can test it out.  If you select Test it will provide a chat window to test out our bots’ questions and answer’s capabilities.  

<img src="Example of QnAMaker bot using an exact match.gif" alt="Example of QnAMaker bot using an exact match" style="max-width:100%;">

<img src="Example of QnAMaker using a similar match.gif" alt="Example of QnAMaker using a similar match" style="max-width:100%;">

<img src="type_in_a_message_to_determine_if_qna_maker_is_working_as_you_desire.png" alt="Type in a message to determine if QnA Maker is working as you desire" style="max-width:100%;">

If you enter a question and do NOT receive the expected response, you can modify both the answer and add an alternative question to help train the QnAMaker bot.  

<img src="You can inspect a response and make changes to both the expected answer and add an alternative quesiton.gif" alt="You can inspect a response and make changes to both the expected answer and add an alternative quesiton" style="max-width:100%;">

Now, go ahead and select Save and train.  Finally, let’s select Publish to publish our knowledge base to be used by our bot service.

<img src="you_will_need_some_information_from_the_sample_http_request_section_on_this_page.png" alt="You will need some information from the Sample HTTP request section on this page" style="max-width:100%;">

Once completed, you should be redirected to a Success! Your service has been deployed page with some crucial information you will need for the next few steps.