---
lab:
    title: 'Lab 3: Connect to session hosts (Entra ID)'
    module: 'Module 3.2: Plan and implement user experience and client settings'
---

# Lab - Connect to session hosts (Entra ID)
# Student lab manual

## Lab dependencies

- An Azure subscription you will be using in this lab.
- A Microsoft Entra user account with the Owner or Contributor role in the Azure subscription you will be using in this lab and with the permissions sufficient to join devices to the Entra tenant associated with that Azure subscription.
- The lab *Deploy host pools and session hosts by using the Azure portal (Entra ID)* completed
- The lab *Manage host pools and session hosts by using the Azure portal (Entra ID)* completed

## Estimated Time

20 minutes

## Lab scenario

You have an existing Azure Virtual Desktop environment containing Entra joined session hosts. You need to validate their functionality by connecting to them from a Windows 11 client which is not Microsoft Entra-joined or registered.

## Objectives
  
After completing this lab, you will be able to:

- Validate the functionality of Microsoft Entra joined Azure Virtual Desktop session hosts by connecting to them from a Windows client which is not Microsoft Entra-joined or registered.

## Lab files

- None

## Instructions

### Exercise 1: Validate the functionality of Microsoft Entra joined Azure Virtual Desktop session hosts by connecting to them from a Windows 11 client
  
The main tasks for this exercise are as follows:

1. Adjust RDP properties of the Azure Virtual Desktop host pool
1. Install Microsoft Remote Desktop client on a Windows 11 computer
1. Subscribe to a Azure Virtual Desktop workspace
1. Test Azure Virtual Desktop apps

> **Note**  If you previously shut down the Azure VMs rin the following commannd.

1. In the **Cloud Shell** run the following to start Azure Virtual desktop session host Azure VMs you will be using in this lab:

  ```powershell
    Get-AzVM -ResourceGroup 'az140-21-RG' | Start-AzVM
  ```

#### Task 1: Adjust RDP properties of the Azure Virtual Desktop host pool

> **Note**: The RDP settings you implemented in the previous lab provide the optimal user experience (via support for single sign-on), however, this requires additional changes described in [Configure single sign-on for Azure Virtual Desktop using Microsoft Entra ID authentication](https://learn.microsoft.com/en-us/azure/virtual-desktop/configure-single-sign-on). Without these changes, by default, authentication is supported providing that the client computer satisfies one of the following criteria:

- It is Microsoft Entra joined to the same Microsoft Entra tenant as the session host
- It is Microsoft Entra hybrid joined to the same Microsoft Entra tenant as the session host
- It is Microsoft Entra registered to the same Microsoft Entra tenant as the session host

Since none of these criteria apply to the lab computer, it is necessary to add `targetisaadjoined:i:1` as a custom RDP property to the host pool.

1. If needed, from the lab computer, start a web browser, navigate to the Azure portal and sign in by providing credentials of a user account with the Owner role in the subscription you will be using in this lab.

    > **Note**: Use the credentials of the `User1`.

1. In the web browser displaying the Azure portal, on the **az140-21-hp1** Azure Virtual Desktop host pool page, in the in the vertical menu bar, in the **Settings** section, select the **RDP Properties** entry.
1. On the **az140-21-hp1 \| RDP Properties** page, select the **Advanced** tab. 
1. On the **Advanced** tab of the **az140-21-hp1 \| RDP Properties** page, in the **RDP Properties** text box, append the following string to the existing content (make sure to add a leading semicolon character (`;`) if needed to separate this string from the one which preceeds it:

    ```txt
    targetisaadjoined:i:1
    ```

1. In the **RDP Properties** text box, remove the following string (if present) from the existing content (with its trailing semicolon character):

    ```txt
    enablerdsaadauth:i:value
    ```

1. On the **az140-21-hp1 \| RDP Properties** page, select **Save**.

#### Task 2: Install Microsoft Remote Desktop client on a Windows 11 computer

1. From the lab computer, start a web browser, navigate to the [Whatt's new in Windows App](https://learn.microsoft.com/en-us/windows-app/whats-new?toc=admins%2Ftoc.json&tabs=windows) page, scroll down to the section **Download and install the Remote Desktop client (MSI)**, and select the [Windows 64-bit](https://go.microsoft.com/fwlink/?linkid=2262633) link. 
1. Open File Explorer, navigate to the **Downloads** folder, and launch the installation of the newly downloaded MSIX file. 
1. In the **Install Windows App** window,  click **Install**. At the new app page sign in with as User1 (with full upn).
1. You can advance through the pages or press skip.

   

#### Task 3: Connect to a Azure Virtual Desktop workspace

1. On the lab computer, switch to the **Windows App** , click the SessionDesktop icon to launch the session, if prompted supply user1 password and say yes to any allow remote desktop connection windows. .

   > **Note**: Select the user account which is the member of the Entra group with the **AVD-DAG** prefix.

1. In the Remote Desktop session window, verify that you have full administrative access within the session (for example, select the **Windows** logo icon in the taskbar and then select the **Windows PowerShell(Admin)** item from the pop-up menu.
   
1. Within the Remote Desktop session window, select the Windows logo icon in the taskbar, select the avatar icon representing the Microsoft Entra user account you used to sign in and, in the pop-up menu, select **Sign out**.

   > **Note**: This will automatically terminate the Remote Desktop session. 

1. If needed start the Windows App again from the start menu, on the top menu bar click user1 and on the submenu sign in with another account. Sign in as user2.

1. In the **Windows App** select Apps from the menu on the right.

1. Ensure that the **Apps** page displays four icons, including Command Prompt, Microsoft Word, Microsoft Excel, Microsoft PowerPoint. 

   > **Note**: This is expected, because the Microsoft Entra user account you selected was assigned in the first lab *Deploy host pools and session hosts by using the Azure portal (Entra ID)* to the **az140-21-hp1-Office365-RAG** and **az140-21-hp1-Utilities-RAG** application groups.

1. Click the Command Prompt icon. 
1. If prompted to sign in, in the **Windows Security** dialog box, enter the password of the second Microsoft Entra user account you used to connect to the target Azure Virtual Desktop environment and say yes to any allow remote desktop connection..
1. Verify that a **Command Prompt** window appears shortly afterwards. 
1. In the Command Prompt window, type **hostname** and press the **Enter** key to display the name of the computer on which the Command Prompt is running.

   > **Note**: Verify that the displayed name starts with the **sh1-** prefix.

1. At the Command Prompt, type **logoff** and press the **Enter** key to log off from the current Remote App session.
1. Click the remaining icons on the **Apps** page to launch Microsoft Word, Microsoft Excel, and Microsoft PowerPoint.
1. Close each session window.

> **Note** If you are not going straight onto the next lab run the following command to stop and deallocate the Azure VMs

   ```powershell
    Get-AzVM -ResourceGroup 'az140-21-RG' | Stop-AzVM -NoWait -Force
   ```

