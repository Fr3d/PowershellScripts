<#

#
# Press 'F5' to run this script. Running this script will load the ConfigurationManager
# module for Windows PowerShell and will connect to the site.
#
# This script was auto-generated at '1/21/2019 8:47:48 AM'.

# Uncomment the line below if running in an environment where script signing is 
# required.
#Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope Process

# Site configuration
$SiteCode = "ps1" # Site code 
$ProviderMachineName = "cm01" # SMS Provider machine name

# Customizations
$initParams = @{}
#$initParams.Add("Verbose", $true) # Uncomment this line to enable verbose logging
#$initParams.Add("ErrorAction", "Stop") # Uncomment this line to stop the script on any errors

# Do not change anything below this line

# Import the ConfigurationManager.psd1 module 
if((Get-Module ConfigurationManager) -eq $null) {
    Import-Module "$($ENV:SMS_ADMIN_UI_PATH)\..\ConfigurationManager.psd1" @initParams 
}

# Connect to the site's drive if it is not already present
if((Get-PSDrive -Name $SiteCode -PSProvider CMSite -ErrorAction SilentlyContinue) -eq $null) {
    New-PSDrive -Name $SiteCode -PSProvider CMSite -Root $ProviderMachineName @initParams
}

# Set the current location to be the site code.
Set-Location "$($SiteCode):\" @initParams

#>

#http://www.scconfigmgr.com/2017/08/11/using-powershell-for-cleaning-up-packages-and-applications/

#$ApplicationName = 'Google Chrome-copy'
#$Application = Get-CMApplication -Name $ApplicationName
#$TaskSequences = Get-CMTaskSequence #| Where-Object { $_.References -ne $null }
#$TaskSequences | Where-Object {$_.References.Package -eq $Application.ModelName}

#$TaskSequences.References

$DependentTSList = $null

$InvalidApplications = Get-CMApplication | Where-Object {$_.NumberOfDependentTS -gt 0 -and $_.NumberOfDeploymentTypes -eq 0}
$TaskSequences = Get-CMTaskSequence | Where-Object { $_.References -ne $null }
ForEach($Application in $InvalidApplications) {
    $DependentTSList = 
    $DependentTS = $TaskSequences | Where-Object {$_.References.Package -eq $Application.ModelName} | $DependentTSList +=

    Write-Host "Application: $($Application.LocalizedDisplayName)"
    Write-Host "TaskSequence: $($Application.LocalizedDisplayName)"
    
}

$DependentTSList | Select-Object Name



