---
title: "Adding a Dlls Certificate to a Trusted Store"
date: 2018-08-08T23:08:02-04:00
draft: false

categories: [powershell]
tags: [certificate, cryptography, .NET]
author: "Josh Rickard"
---

Yesterday I was asked to help with streamling a manual process that some QA folks were running into.  They had a debug release of an applicaiton that was signed with a test code signing certificate.  Part of the process was that they needed to select a DLL, view the certificate, and then install the certificate into the machines trusted certificate store.  

This is a extremely simple task, but it was just an annoyance, so I wrote a few lines of code to autoamte this for them.

```powershell
$certificate = [System.Security.Cryptography.X509Certificates.X509Certificate]::CreateFromSignedFile('C:\some\path\to\a\file.dll')
$cert2 = [System.Security.Cryptography.X509Certificates.X509Certificate2]::new($certificate)

$certStore = [System.Security.Cryptography.X509Certificates.X509Store]::new([System.Security.Cryptography.X509Certificates.StoreName]::Root, [System.Security.Cryptography.X509Certificates.StoreLocation]::LocalMachine)

$certStore.Open([System.Security.Cryptography.X509Certificates.OpenFlags]::ReadWrite)
$certStore.Add($cert2)
$certStore.Close()
```

To break this down further, the first thing that we do is call a the `CreateFromSignedFile` method.  THis method takes a filepath as a parameter and will create a `$certificate` object with information stored in the dll.  The next thing is that we now need to take that object and create a new `Certificate2` from that existing `$certificate` metadata.

Next, we create a `X509Store` object by specifying the `StoreName` we want to store the certiicate in.  Depending on where you want to store this certificate, your value may be different, but for this example we are storing the certificate in our Trusted Root Publishers store.  We also need to pass in if we want to store this in the `LocalMachine` or `User` portion of our certificate store.

Lastly, we simply open our certificate store with the `ReadWrite` permissions. After this, we then simply add our created certificate into the store using the `$certStore.Add()` method.  

Once we are done, we simply close the store and go on our mary little way.

I hope this helps breakdown how to recreate a DLLs signed certificate and store it in local certificate store.