# Intro2Terraform
This is a basic introduction to AWS terraform and how it can be used for cybersecurity
Terraform is an infrastructure as code tool that lets you build, change, and version infrastructure safely and efficiently. This includes low-level components like compute instances, storage, and networking; and high-level components like DNS entries and SaaS features.
Simply Put, Its like CIsco Packet Tracer but with code. However, unlike Cisco Packet tracer, It has multiple providers that has an infrastructure within it. Something like AWS, Azure, Digital Ocean, Red Hat and son on. It allows you to build infrastructures with code.
It was written in Hashicorp configuration language which is a programming language custom made by Hashicorp. It has a .tf extension which we will get to later on. You can decide whether to compile the script in .json or .yaml depending on your choice
Why is this good for us hackers you ask? Because we can use this to automatically setup our own virtual machine and we can also write and edit custom configurations that can be used to access an organization's network. I want to document this Journey of how I learnt this framework.
First of all, I had to install the Hashicorp terraform on my Windows machine and add it to system variables. Next, I went to vscode extension to install the Hashicorp Terraform extension. 
