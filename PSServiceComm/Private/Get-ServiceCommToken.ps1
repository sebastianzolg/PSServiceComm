function Get-ServiceCommToken {
    [CmdletBinding()]
    param (
        $TenantId,
        $ClientId,
        [Security.SecureString]
        $ClientSecret,
        $BaseUrl = 'https://manage.office.com/api/v1.0',
        $Scopes = 'https://manage.office.com/.default'
    )
    
    return Get-MsalToken -clientID $ClientID -clientSecret $ClientSecret -tenantID $TenantID -Scopes $Scopes
}