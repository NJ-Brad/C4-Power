
# emulating the sample code at https://github.com/structurizr/dotnet


# Get-Host | Select-Object Version

# https://sharepoint.stackexchange.com/questions/164216/how-to-correctly-include-file-in-powershell
# https://xainey.github.io/2016/powershell-classes-and-concepts/
# https://devblogs.microsoft.com/scripting/powershell-5-create-simple-class/
# https://adamtheautomator.com/powershell-classes/
# https://www.sapien.com/blog/2016/03/16/inheritance-in-powershell-classes/
# https://c4model.com/
# https://stackoverflow.com/questions/27138483/how-can-i-re-use-import-script-code-in-powershell-scripts/27138623
# https://github.com/plantuml-stdlib/C4-PlantUML

#https://www.tutorialspoint.com/how-to-get-the-path-of-the-currently-executing-script-in-powershell*
$mypath = $MyInvocation.MyCommand.Path
#Write-Output "Path of the script : $mypath"

$mypath = $MyInvocation.MyCommand.Path
$scriptDir = Split-Path $mypath -Parent

try {
    . ("$($scriptDir)\C4-Power.ps1")
}
catch {
    Write-Host "Error while loading supporting PowerShell Scripts" 
}

# this is the original workspace
# this version will hide the output
#$null = Initialize-Workspace Container -Name "Container" -Title "A Container diagram" -Sketch $true -Legend $true -TopDown $true -Description "This is a longer description of what I am doing"

Initialize-Workspace Container -Name "Container" -Title "A Container diagram" -Sketch $true -Legend $true -TopDown $true -Description "This is a longer description of what I am doing"
New-Person "Brad"
New-ContainerBoundary "Boundary One"
New-System "System One"
Close-Boundary
New-System "System Two"

New-Connection "Brad" "System Two" -Label "First Connection" -Technology "who cares"
New-Connection "Brad" "System One" -Label "Second Connection" -Technology "I do"

Publish-View

#######################################################################################################################
# a sample from https://github.com/structurizr/dotnet
Initialize-Workspace Context -Name "Getting Started" -Title "This is a model of my software system." -Sketch $true -Legend $true -TopDown $true

New-Person "A user of my software system" "User"
New-System "My software system." "Software System"

New-Connection "User" "Software System" -Label "Uses"

Publish-View

# https://github.com/plantuml-stdlib/C4-PlantUML/blob/master/samples/C4_Context%20Diagram%20Sample%20-%20bigbankplc.puml
Initialize-Workspace Context -Name "Sample" -Title "System Context diagram for Internet Banking System" -Sketch $true -Legend $true -TopDown $true

New-Person "Personal Banking Customer" "customer" -Description "A customer of the bank, with personal bank accounts."
New-System "Internet Banking System" "banking_system" -Description "Allows customers to view information about their bank accounts, and make payments."

New-System "E-mail system" "mail_system" -Description "The internal Microsoft Exchange e-mail system." -External $true
New-System "Mainframe Banking System" "mainframe" -Description "Stores all of the core banking information about customers, accounts, transactions, etc." -External $true

New-Connection "customer" "banking_system" -Label "Uses"
New-Connection "mail_system" "customer"  -Label "Sends e-mails to"
New-Connection "banking_system" "mail_system" -Label "Sends e-mails" -Technology "SMTP"
New-Connection "banking_system" "mainframe" -Label "Uses"

Publish-View -ViewInEditor $true
