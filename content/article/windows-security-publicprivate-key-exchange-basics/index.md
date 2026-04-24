---
title: "Windows Security Publicprivate Key Exchange Basics"
date: 2018-08-07T20:44:20-04:00
draft: false

categories: []
tags: [archive]
author: "Josh Rickard"
---
My wife and I saw CITIZENFOUR yesterday during a secret screening.  If you have not had the chance to see this movie, please do so as soon as you can - it's a great documentary!  The only complaint I have about the film is that they do not explain Cryptography or Encryption for the "normal" folks.  When the film ended, I looked around and their were many non-technical people (including older individuals).  I remember hearing someone say "well I guess I'm not going to be using email anymore".  This sentiment is not what the film is about, and I believe the director should have explained this very technical methodology to not confuse the non-techie people.

With all that being said, I'm going to try to explain Public/Private Key Exchange in the simplest form I can......

Imagine that you (mother) are wanting to send an email to someone (son), but you want the contents to be secure from prying eyes.  In order to do this, you need to use a form of encryption that it is secure.  The most common form of encryption is based on a certificate.

You may be asking, what the hell is a certificate?  Think about your college degree or your highschool diploma, you received this certificate from your high school or university. This certificate is really nothing special, just a printed piece of paper, but the one thing that makes this certificate unique is that it's yours.  Additionally, your certificate is unique because it has your name on it, the year you graduated, the school you went to and it possibly has an issue number.  All of these things make your certificate unique, this is similar to a certificate we use for encryption.

The only difference between a certificate you received for your graduation and one you use for encryption is that your certificate for encryption is digital.  Your digital certificate is typically unique because it comes from trusted source, it's made specifically for you, and well it means that this is me - you can trust me.

So you have your unique certificate and within your certificate is a public key and a private key.  As you can imagine, your private key should always be kept private.  This private key is the key (pun intended) to all of your encryption.  This means that you do not want to store this private key just anywhere - keep it on a thumb drive in a safe (and buried in the backyard) :)  Seriously, keep it as safe as the data you are trying to encrypt needs to be protected.

The other half of your certificate is your public key.  Your public key will be, well, public and we (the son) will use this public key to encrypt their data.  You may be asking at this point, well okay I have my certificate, I have my public and private key, and my data is now encrypted by my public key, NOW WHAT?  Well, once (your) the data is encrypted with your public key then you are the only one that can decrypt the data.

That's right, your private key is used to decrypt data that has been encrypted by your public key!

Now let's get to a real world example.  Now, back to my example above - Mother wants to send data that's secure to her son.  For the mother to send data securely she first needs to get a certificate.  Depending on where the mother lives, she can purchase a certificate from a Certificate Authority (CA) or receive one from her work's CA.  Once the mother has a certificate, she installs into her web browser or email client (for example).

Now that the certificate is installed, the public key (sometimes the private key as well) is installed on her computer and can be used to encrypt her data.  Since the mother has a public key, it's now in the public and is sent with most communication on the web.  That's okay, remember this is your public key. The mother then sends her public key to her son (by sending an email).  Once her son has his mothers public key, he can now communicate with his mother securely.  Anything that is sent by the son to the mother can be decrypted by the mother because her private key is the only one that can decrypt the message - which is sent encrypted by the mothers public key.

Below is a great graphical explanation of the Public/Private Key Exchange:

<a href="https://msadministrator.files.wordpress.com/2014/10/gpg-schema.jpg"><img class="alignnone size-medium wp-image-292" src="https://msadministrator.files.wordpress.com/2014/10/gpg-schema.jpg?w=300" alt="GPG-SChema" width="300" height="142" /></a>

This post explains the basics of public/private key exchange and does not go into the details surrounding the multitude of different technologies (i.e. Diffie-Hellman, symmetric and asymmetric key exchanges, etc).  I hope this post has helped people understand the absolute basics of encryption.
