<#
    This Script Creates 2 Entra ID Groups (AVD-DAG and AVD-RemoteApp).
    Creates User1 as a Global Admin and Subscription Owner and a member of AVD-DAG.
    Creates User2 as a standard user and member of AVD-RemoteApp.
    Both users are NOT required to change password ("Pa55w.rd1234abc") at first logon
#>

#Connect to AzureAD to run AzureADCommands
#Connect-AzureAD

#Create Groups
$AVDDAG=New-AzureADGroup -DisplayName AVD-DAG -MailEnabled $false -MailNickName AVD-DAG -SecurityEnabled $true
$AVDRemoteApp=New-AzureADGroup -DisplayName AVD-RemoteApp -MailEnabled $false -MailNickName AVD-RemoteApp -SecurityEnabled $true

# Create permanent Password 
$PasswordProfile = New-Object -TypeName Microsoft.Open.AzureAD.Model.PasswordProfile
$PasswordProfile.Password = "Pa55w.rd1234abc"
$PasswordProfile.ForceChangePasswordNextLogin = $false

#Get Domain Details for UPN
$verifiedDomain = (Get-AzureADTenantDetail).VerifiedDomains.Name

#Create User Accounts
$User1=New-AzureADUser -DisplayName "User1" `
                -UserPrincipalName user1@$verifiedDomain `
                -AccountEnabled $true `
                -PasswordProfile $PasswordProfile `
                -MailNickName user1

$User2=New-AzureADUser -DisplayName "User2" `
                -UserPrincipalName user2@$verifiedDomain `
                -AccountEnabled $true `
                -PasswordProfile $PasswordProfile `
                -MailNickName user2

# Assign the Subscription Owner role to User1
New-AzRoleAssignment -ObjectId $User1.ObjectId -RoleDefinitionName "Owner" -Scope "/subscriptions/$($(Get-AzSubscription).id)"

#Add Global Admin role to User1
$role = Get-AzureADDirectoryRole | Where {$_.displayName -eq 'Global Administrator'}
Add-AzureADDirectoryRoleMember -ObjectId $role.ObjectId -RefObjectId $user1.objectID

# Add Group Members
Add-AzureADGroupMember -ObjectId $AVDDAG.ObjectId -RefObjectId $User1.ObjectId 
Add-AzureADGroupMember -ObjectId $AVDRemoteApp.ObjectId -RefObjectId $User2.ObjectId 
