function Connect-ServiceComm {
    [CmdletBinding()]
    param (
        $TenantId,
        $ClientId,
        [Security.SecureString]
        $ClientSecret,
        $BaseUrl = 'https://manage.office.com/api/v1.0'
    )

    $authResult = Get-ServiceCommToken -clientID $ClientID -clientSecret $ClientSecret -tenantID $TenantID

    $Script:BaseUrl = $BaseUrl
    $Script:TenantId = $TenantId
    $Script:AuthResult = $authResult
}