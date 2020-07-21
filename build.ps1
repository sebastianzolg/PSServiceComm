[CmdletBinding()]
param (
    [parameter(Position = 0)]
    [ValidateSet('Default','Init','Test','Build','Deploy')]
    $Task = 'Default'
)

# Grab nuget bits, install modules, set build variables, start build.
Get-PackageProvider -Name NuGet -ForceBootstrap | Out-Null

# https://devblogs.microsoft.com/powershell/powershell-gallery-tls-support/
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12 
Install-Module PowerShellGet -RequiredVersion 2.2.4.1 -SkipPublisherCheck

Install-Module Psake -Scope CurrentUser 
Install-Module PSDeploy -Scope CurrentUser
Install-Module BuildHelpers -AllowClobber -Scope CurrentUser
Install-Module Pester -RequiredVersion 5.0.2 -Scope CurrentUser -SkipPublisherCheck
Import-Module Psake, BuildHelpers

Set-BuildEnvironment -ErrorAction SilentlyContinue

Invoke-psake -buildFile $ENV:BHProjectPath\psake.ps1 -taskList $Task -nologo
exit ( [int]( -not $psake.build_success ) )