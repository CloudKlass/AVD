---
lab:
    title: 'Lab: Implement and manage Azure Virtual Desktop profiles (Entra ID only)'
    module: 'Module 08: 'Custom File share lab'
---

# Lab - Lab: Implement and manage Azure Virtual Desktop profiles (Entra ID only).
# Student lab manual

## Lab dependencies

- An Azure subscription you will be using in this lab.
- A Microsoft Entra user account with the Owner role in the Azure subscription you will be using in this lab and with the permissions sufficient to join devices to the Entra tenant associated with that Azure subscription.

## Estimated Time

? minutes

## Lab scenario

You need to create a file share in Azure to use with FXLogix for users profiles .

## Objectives
  
After completing this lab:

You have a Microsoft Azure subscription. You need to setup a file share and FXLogix to use with users profile.

## Lab files

- ???.ps1

## Instructions

### Exercise 1: Implement FSLogix based profiles for Azure Virtual Desktop
  
The main tasks for this exercise are as follows:

1. Configure FSLogix-based profiles on Azure Virtual Desktop session host VMs
1. Test FSLogix-based profiles with Azure Virtual Desktop


#### Task 1: Configure FSLogix-based profiles on Azure Virtual Desktop session host VMs.

1. From the lab computer, start a web browser, navigate to the Azure portal at [https://portal.azure.com](https://portal.azure.com) and sign in by providing the credentials of a user account with the Owner role in the subscription you will be using in this lab.

  
1. In the Azure portal, start a PowerShell session in the Azure Cloud Shell.

    > **Note**: If prompted, in the **Getting started** pane, in the **Subscription** drop-down list, select the name of the Azure subscription you are using in this lab and then select **Apply**.

1.In the **Cloud Shell** run the following to start Azure Virtual desktop session host Azure VMs you will be using in this lab:

  ```powershell
    Get-AzVM -ResourceGroup 'az140-21-RG' | Start-AzVM
  ```
#### Task 2: Create a file share and configure Microsoft Entra Kerberos.

1. In the Azure portal, search for and select Storage accounts and, on the Storage accounts blade, select + Create.

1. On the Basics tab of the Create storage account blade, specify the following settings (leave others with their default values):

    |Settings|Value|
    |---|---|
    |Subscription|the name of the Azure subscription you are using in this lab|
    |Resource group|create a new resource group called az140-22-RG|
    |Storage account name|any globally unique name between 3 and 15 in length consisting of lower case letters and digits, starting with a letter|
    |Region|the name of an Azure region hosting the Azure Virtual Desktop lab environment|
    |Preferred storage type|Azure Blob Storage or Azure Data Lake Storage|
    |Redundancy|Geo-redundant storage (GRS)|
    |Make read access to data available in the event of regional unavailability||enabled|

1. On the Basics tab of the Create storage account blade, select Review + Create, wait for the validation process to complete, and then select Create.

1. Once the storage account is deploy click go to resource.

1. On the overview page of the storage account under the File Service section next to Identity-based access select the link that say **
Not configured**

1. On the File share page select the lnk that says **Not configured** next to Identity-based access.

1. On the Identity based access page click setup in the Microsoft Kerberos Entra section.

1. Select the tick box on the tab, leave the other section blank and press save.

1. Back on the Identity based access page under the Set share-level permissions section select Set share-level permissions, in the drop down menu select **Set share-level permissions** then press save.

1. Navigate back to the file share page.

1. On the file share page click the + Classic file share button, on the basic tab enter the name **fxlogix**

1. On the backup tab clear the Enable backup tick up.

> **Note**: In a working environment you would backup the share for training purposes we will leave this off.

1.  Select Review + Create, wait for the validation process to complete, and then select Create.


