if (-not $env:BHProjectPath) {
    Set-BuildEnvironment -Path $PSScriptRoot\.. -Force
}
Remove-Module $env:BHProjectName -ErrorAction SilentlyContinue
Import-Module (Join-Path $env:BHProjectPath $env:BHProjectName) -Force

InModuleScope 'PSServiceComm' {
    Describe 'Get-ServiceCommToken' {

        BeforeAll {
            $connectionArgs  = @{
                TenantId     = [GUID]::Empty
                ClientId     = [GUID]::Empty
                ClientSecret = 'SecureString' | ConvertTo-SecureString -AsPlainText -Force
            }
        }

        It 'Invokes the given method' {
            Mock Get-MsalToken {}
                        
            Get-ServiceCommToken @connectionArgs | Should -InvokeVerifiable Get-MsalToken
        }
    }
}
