# PSServiceComm

[![Build status](https://ci.appveyor.com/api/projects/status/960b29qw8fvq3kp3/branch/master?svg=true)](https://ci.appveyor.com/project/sebastianzolg/psservicecomm/branch/master)

**PSServiceComm** is a quick and dirty PowerShell Core Module to talk to the [Office 365 Service Communication API](https://docs.microsoft.com/en-us/office/office-365-management-api/office-365-service-communications-api-reference), e.g. reading Messages from the Message Center (aka Admin Center).

## Prerequisites

This PowerShell Module requires an App Registration in your target tenant with **Application Permission** Scope **ServiceHealth.Read** for the **Office 365 Management APIs**.
Note down *TenantId*, *ClientId* and *ClientSecret* while creating the App Registration.

## Getting started

Install the PSServiceComm module from: https://www.powershellgallery.com/packages/PSServiceComm

```PowerShell
Install-Module -Name PSServiceComm
```

To authenticate with the Office 365 Service Communication API:

```PowerShell
# Use the settings from your app registration
$tenantId = "00000000-0000-0000-0000-000000000000"
$clientId = "00000000-0000-0000-0000-000000000000"
$clientSecret = "ClientSecret" | ConvertTo-SecureString -AsPlainText

Connect-ServiceComm -TenantId $tenantId -ClientId $clientId -ClientSecret $clientSecret
```

## Example usage

### Retrieving Messages from Message Center

Get all Messages:

```PowerShell
$messages = Get-ServiceCommMessages
```

Get all Messages with a LastUpdatedTime < 5 Days:

```PowerShell
$messages = Get-ServiceCommMessages -DaysToSync 5
```

Get all updated Messages

```PowerShell
$messages = Get-ServiceCommMessages
$messages | Where-Object { $_.IsUpdated() }
```

The API and its documentation don't provide a proper explanation on how to detect updated messages. We consider Messages as updated when the following criteria are met:

- `Title contains '(Updated)'`
- `LastUpdatedTime > StartTime + 1 Hour`
