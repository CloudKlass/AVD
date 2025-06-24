---
lab:
    title: 'Lab: Setup ready for AZ-140 Course(Entra ID)'
    module: 'Module 0.0: Setup'
---

# Lab - Setup ready for AZ-140 Course (Entra ID)
# Student lab manual

## Lab dependencies

- An Azure subscription you will be using in this lab.
- A Microsoft Entra user account with the Owner role in the Azure subscription you will be using in this lab and with the permissions sufficient to join devices to the Entra tenant associated with that Azure subscription.

## Estimated Time

5 minutes

## Lab scenario

You have a Microsoft Azure subscription. You need to create two users and two groups with the appropirate permissions .

## Objectives
  
After completing this lab:

- You will have setup your subscription ready for the AZ-140 course.

## Lab files

- Setup.ps1

## Instructions

### Exercise 1: Run the Powershell Scrpt to setup our subscription
  
The main tasks for this exercise are as follows:

1. Prepare the Azure subscription for deployment


#### Task 1: Prepare the Azure subscription for deployment.

1. From the lab computer, start a web browser, navigate to the Azure portal at [https://portal.azure.com](https://portal.azure.com) and sign in by providing the credentials of a user account with the Owner role in the subscription you will be using in this lab.

  
1. In the Azure portal, start a PowerShell session in the Azure Cloud Shell.

    > **Note**: If prompted, in the **Getting started** pane, in the **Subscription** drop-down list, select the name of the Azure subscription you are using in this lab and then select **Apply**.

1. In the PowerShell session in the Azure Cloud Shell pane, use the Manage files section to upload 'Setup.ps1.

  
1. At the prompt type 'Connect-AzureAD'.

1. Run the Powershell file by enerting './Setup.ps1'.

1. On completion of the script close the cloudshell.

1. Open Microosft Entra ID and check that there are two new users, User1 and User2 and there are two new Groups AVD-DAG and AVD-Remoteapp, check that User1 is a memeber of AVD-DAG and User2 is a member of AVD-RemoteApp.
 
