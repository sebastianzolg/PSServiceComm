function Connect-ServiceComm {
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
        $BaseUrl = 'https://manage.office.com/api/v1.0'
    )

    $authResult = Get-ServiceCommToken @PSBoundParameters

    $Script:BaseUrl = $BaseUrl
    $Script:TenantId = $TenantId
    $Script:AuthResult = $authResult
}