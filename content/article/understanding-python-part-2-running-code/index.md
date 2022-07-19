---
title: "Understanding Python - Part 2: Running Code"
date: 2022-07-14T12:45:00-04:00
draft: false

categories: [python]
tags: [python,basics]
author: "Josh Rickard"
---

## Introduction

Whether you are new to Python or not, ensuring you understand the basics will help you along the way to becoming a Python expert.

Please see the first post titled [Python vs Powershell Part 1: Versioning](). This first post was written in 2018 but still applies. The remaining blog posts are a continuation of this series. Lets get started!

## Installation

You may have Python already installed. To check, open your terminal and type:

```console
$ python -V
```

If Python is installed, you should see a version displayed below that command. If not, you may receive a `command not found` type of error (or something to that effect).

Depending on your operating system, you can install the Python executable from [python.org](https://python.org). Additionally, you could use a package manager like [brew.sh](https://brew.sh) or [chocolatey](https://chocolately.org) or some other variant. Either way, you must have Python installed within your environment.

> There are other methods like using [pyenv](https://realpython.com/intro-to-pyenv/) you can use to install different versions of python on top of each other but that is out of scope for this blog post.

## Installation Check

Once Python has been installed, we should open a new terminal and type:

```console
python -V
# or 
python3 -V
```

Your version of Python should be **3.7 or greater**.

## Python & Pip

Before we dive into using Python, we need to understand that we actually installed two executables (there are more but for this discussion we installed two); Python & pip. The Python executable (`python.exe`) is used to execute code, but there are several different ways to execute that code. We will go through the most common ones below.

By simply entering `python` in your terminal, you will run the Python interactive shell.

## Interactive Shell

When in the interactive shell, we need to understand that it is basically a live session where code is run. Whatever you enter here is considered Python code; whether it's accurate or not. Again, you gain access to the interactive shell by typing the following in your terminal:

```console
python
# or
python3
```

Once in this shell, you can utilize any of the built-in functions. For example:

```python
print
type
input
exit
# etc.
```

> We will go into more details soon about these functions and more.

Each of these functions (above) are built-in to the Python language and are accessible by simply typing them. You don't need to import them or do anything fancy to use them. 

To exit the interactive shell, type:

```console
exit()
```

Since we were in an interactive shell, we needed to call the `exit` function in order to return to our console (or exit the shell).

## -c

Next, lets run some python directly within our console. To do this, we can use the `-c` parameter on the `python` executable.

```console
python -c ''
# or 
python3 -c ''
```

The `-c` parameter allows us to run strings of code directly in our terminal/shell. For example:

```console
python -c 'print("Hello World!")'
```

This should output `Hello World` in your console. Later on, this becomes extremely useful for quick snippets of code or grabbing data. For example:

```console
python -c "import requests; print(requests.get('https://bitly.com/98K8eH'))"
# or 
python -c "import os; print(os.path.isdir('.'))"
```

In the next few posts, I will explain those examples in more detail.

## Running Scripts

Even though we have ran our code in our console, the most common way will be using a scripts. Scripts allow us to run our code, or someone else's, to obtain our desired outcomes. These scripts are essentially just text files, ending in `.py` extension, to control the flow our outcome.

Like most languages, Python is processed from top to bottom. 

To run a Python script, we use the Python executable as well as the path to our script file.

```console
python test_script.py
```

Lets go ahead and create a file called `test_script.py` in your current directory. Next, open it in Visual Studio Code.

> If you don't have Visual Studio Code, please [install it](https://code.visualstudio.com/download).

Open up our new Python script `test_script.py` and add in the following:

```python
print("Checkout the blog https://letsautomate.it.")
```

Now save our file and run it by calling our script:

```console
python test_script.py
```

It should output the following to your console:

```output
Checkout the blog https://letsautomate.it
```

Look at you! You just ran your first Python script - you are a programmer now.

## What's Next?

In the next post in this series, I will dive into the built-in primitives and methods in more detail.
