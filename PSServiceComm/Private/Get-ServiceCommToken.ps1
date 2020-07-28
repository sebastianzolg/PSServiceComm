function Get-ServiceCommToken {
    [CmdletBinding(DefaultParameterSetName = 'ClientCredFlowParameterSet',
        SupportsShouldProcess = $false)]
        
    param (
        [Parameter(Mandatory = $true,
            ParameterSetName = 'ClientCredFlowParameterSet')]
        [ValidateNotNullOrEmpty()]
        [string]        
        $TenantId,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'ClientCredFlowParameterSet')]
        [ValidateNotNullOrEmpty()]
        [string]   
        $ClientId,

        [Parameter(Mandatory = $true,
            ParameterSetName = 'ClientCredFlowParameterSet')]
        [ValidateNotNull()]
        [Security.SecureString]
        $ClientSecret,
        $BaseUrl = 'https://manage.office.com/api/v1.0',
        $Scopes = 'https://manage.office.com/.default'
    )

    return Get-MsalToken -clientID $ClientID -clientSecret $ClientSecret -tenantID $TenantID -Scopes $Scopes
}