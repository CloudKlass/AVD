---
lab:
    title: 'Lab: Implement and manage Azure Virtual Desktop profiles (Entra ID only)'
    module: 'Module: Custom File share lab'
---


# Lab - Implement and manage Azure Virtual Desktop profiles (Entra ID only). This is a QA lab and may be removed or replaced when this course is updated
# Student lab manual

## Lab dependencies

- An Azure subscription you will be using in this lab.
- A Microsoft Entra user account with the Owner role in the Azure subscription you will be using in this lab and with the permissions sufficient to join devices to the Entra tenant associated with that Azure subscription.

## Estimated Time

45 minutes

## Lab scenario

You need to create a file share in Azure to use with FXLogix for user profiles .

## Objectives
  
After completing this lab:

You have a Microsoft Azure subscription. You need to setup a file share and FXLogix to use with user profile.

## Lab files

- None

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
    |Resource group|create a new resource group called **az140-22-RG**|
    |Storage account name|any globally unique name between 3 and 15 in length consisting of lower case letters and digits, starting with a letter|
    |Region|the name of an Azure region hosting the Azure Virtual Desktop lab environment|
    |Preferred storage type|Azure Blob Storage or Azure Data Lake Storage|
    |Redundancy|Geo-redundant storage (GRS)|
    |Make read access to data available in the event of regional unavailability|enabled|

1. On the Basics tab of the Create storage account blade, select Review + Create, wait for the validation process to complete, and then select Create.

1. Once the storage account is deployed click go to resource.

1. On the overview page of the storage account under the File Service section next to Identity-based access select the link that say **Not configured**

1. On the File share page select the link that says **Not configured** next to Identity-based access.

1. On the Identity based access page click setup in the Microsoft Kerberos Entra section.

1. Select the tick box on the tab, leave the other section blank and press save.

1. Back on the Identity based access page under the Set share-level permissions section select **Enable permissions for all authenticated users and groups** Set share-level permissions, in the drop down menu to **Storage File Data SMB Share Contributor** then press save.

1. Navigate back to the file share page.

1. On the file share page click the + Classic file share button, on the basic tab enter the name **fxlogix**

1. On the backup tab clear the Enable backup tick up.

> **Note**: In a working environment you would backup the share for training purposes we will leave this off.

1.  Select Review + Create, wait for the validation process to complete, and then select Create.

#### Task 3: Configure Microsoft Entra ID App Registration.

1. In the Azure portal, search for and select Microsoft Entra ID

1. In Microsoft Entra ID under the Mange setion select App registrations, on the App registration blade section All appilcations, From the list select the storage account you created earlier.

1. Under the Mange section select API permissions, click the Grant admin consent link and then select yes from the pop up window.

1. Navigate to Manifest under the Mange section, find the item '"tags": [],' normally line 28. Enter **"kdc_enable_cloud_group_sids"** including the quote marks between the brackets, then save the file.
> **Note**: You will need to type the code in it will not accept cut and paste

#### Task 4: Preparing the AVD Hosts part 1.

1. In the Azure portal, search for and select Virtual Machine.

1. Select the first VM that has a name starting SH1, under the Operations section select Run command, select RunPowerShellScript, enter and run the following command

  ```powershell
    reg add HKLM\SYSTEM\CurrentControlSet\Control\Lsa\Kerberos\Parameters /v CloudKerberosTicketRetrievalEnabled /t REG_DWORD /d 1
  ```
1. Repeat this for the remaining host VMs

#### Task 4: Complete the setup on the file share to enable user permissions.

1. In the Azure portal, search for and select Storage accounts.

1. From the list select the storage account you created earlier, under the Data storage section select File share then select the share fxlogix.

1. On the fxlogix page select browse, then select the + Add directory link, enter the name Profiles in the box and press ok.

1. On the fxlogix page select the elipse next to the Profiles folder and then select Manage access,on the Manage access page leave the Creator owner and then remove all the other users and groups. In the display pane press the edit pencil next to the Creator owner, set the following permissions then press done.

   |Setting|Value|
   |---|---|
   |Applies to|Applies to Subfolders and Subfiles|
   |Permissions|Allow Modify|

   1. On the Manage access page select Add Entra User/Group, from the list select AVD-DAG and AVD-RemoteApp the press select, back on the Manage access page apply the follow permission using the edit button for each group. When completed press save.
  
      AVD-DAG
  
      |Setting|Value
      |---|---|
      |Applies to|Applies to Subfolders and Subfiles|
      |Permissions|Allow Full Control|

      AVD-RemoteApp

      |Setting|Value|
      |---|---|
      |Applies to|Applies tothis folder|
      |Permissions|Allow Modify|

 #### Task 5: Preparing the AVD Hosts part 2.

   1.  In the Azure portal, search for and select Virtual Machine.

1. Select the first VM that has a name starting SH1, under the Operations section select Run command, select RunPowerShellScript, enter the following command

  ```powershell
    $profilePath = "\\[Replace with your storage account name].core.windows.net\fxlogix\Profiles" 
    Set-ItemProperty -Path "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "VHDLocations" -Value $profilePath
    Set-ItemProperty -Path "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "Enabled" -Value 1 -Type DWord
    Set-ItemProperty -Path "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "DeleteLocalProfileWhenVHDShouldApply" -Value 1 -Type DWord
    Set-ItemProperty -Path "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "SizeInMBs" -Value 30000 -Type DWord
    Set-ItemProperty -Path "HKLM:\SOFTWARE\FSLogix\Profiles" -Name "FlipFlopProfileDirectoryName" -Value 1 -Type DWord

  ```
1. Repeat this for the remaining host VMs

> **Note**: Parts 1 and 2 of the host setup could be done by Intune or be built into the base image that you deploy.

##### Task 6: Test the file share.

1. You have already connected to the AVD environment in a previous lab, navigate to the Virtual Desktop app on the lab pc, launch the remote desktop session and connect as user1, 

1. Navigate to the storage account and browse to the profiles folder where you should now see a profile for user1.

> **Note** You could launch the Virtual Desktop app logged in as User2 to test that a new profile is created for that user. 
    
> **Note** If you are not going straight onto the next lab run the following command to stop and deallocate the Azure VMs

   ```powershell
    Get-AzVM -ResourceGroup 'az140-21-RG' | Stop-AzVM -NoWait -Force
   ```
