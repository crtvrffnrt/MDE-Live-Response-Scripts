$global:FormatEnumerationLimit = -1
Write-Host "---- Microsoft Defender Preferences ----"
$mpPreferences = Get-MpPreference
# Display Microsoft Defender Preferences
$mpPreferences | Format-List
# Specifically handle exclusions to display full content
Write-Host "`n---- Exclusions ----"
Write-Host "Exclusion Paths:"
$mpPreferences.ExclusionPath | ForEach-Object { Write-Output $_ }
Write-Host "Exclusion Extensions:"
$mpPreferences.ExclusionExtension | ForEach-Object { Write-Output $_ }
Write-Host "Exclusion Processes:"
$mpPreferences.ExclusionProcess | ForEach-Object { Write-Output $_ }

Write-Host "---- Microsoft Defender Computer Status ----"
Get-MpComputerStatus
Write-Host "---- Microsoft Defender Firewall ----"
function Get-WindowsFirewallStatus {
    [CmdletBinding()]
    param ()

    # Get the firewall state for all profiles
    $firewallProfiles = Get-NetFirewallProfile

    # Display the firewall state for each profile
    foreach ($profile in $firewallProfiles) {
        $profileName = $profile.Name
        $firewallState = $profile.Enabled

        Write-Output "Firewall Profile: $profileName"
        Write-Output "State: $firewallState"
        Write-Output ""
    }
}
Write-Host "---- Microsoft Defender Firewall Details ----"
Get-WindowsFirewallStatus
# Retrieve Microsoft Defender preferences

Write-Host "---- Last 20 Defender Detections ----"
Get-WinEvent -LogName "Microsoft-Windows-Windows Defender/Operational" |
    Where-Object { $_.Id -eq 1116 } |  # Event ID 1116 indicates a detected threat
    Select-Object -First 20 |
    Format-Table TimeCreated, Id, Message

Write-Host "---- Currente AV Provider ----"
Get-CimInstance -Namespace "root\SecurityCenter2" -ClassName AntiVirusProduct
