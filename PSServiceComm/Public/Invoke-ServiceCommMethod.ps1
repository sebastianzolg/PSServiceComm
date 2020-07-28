function Invoke-ServiceCommMethod {
    [CmdletBinding(
        SupportsShouldProcess = $false)]

    param (
        [Parameter(Mandatory = $true,
            Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string]
        $Method
    )

    # Read service messages posts and get ones of Type MessageCenter
    # https://docs.microsoft.com/en-us/office/office-365-management-api/office-365-service-communications-api-reference

    $headers = @{}
    $headers.Add('Authorization', 'Bearer ' + $AuthResult.AccessToken)
    $headers.Add('Content-Type', "application/json")

    $uri = "{0}/{1}/{2}?`$filter=MessageType eq Microsoft.Office365ServiceComms.ExposedContracts.MessageType'MessageCenter'" -f  $BaseUrl, $TenantId, $Method.Trim('/')
    $response = Invoke-WebRequest -Uri $uri -Method Get -Headers $headers -UseBasicParsing -ErrorAction Stop
    $responseContent = $response.Content | ConvertFrom-Json
    $content = $responseContent.Value

    return $content
}