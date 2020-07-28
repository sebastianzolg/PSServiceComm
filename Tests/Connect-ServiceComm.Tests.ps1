if (-not $env:BHProjectPath) {
    Set-BuildEnvironment -Path $PSScriptRoot\.. -Force
}
Remove-Module $env:BHProjectName -ErrorAction SilentlyContinue
Import-Module (Join-Path $env:BHProjectPath $env:BHProjectName) -Force

InModuleScope 'PSServiceComm' {

    Describe 'Connect-ServiceComm' {

        BeforeAll {
            $connectionArgs = @{
                TenantId     = [GUID]::Empty
                ClientId     = [GUID]::Empty
                ClientSecret = 'SecureString' | ConvertTo-SecureString -AsPlainText -Force
                BaseUrl = 'https://manage.office.com/api/v1.0'
            }
        }

        It 'Should Connect' {
            Mock Get-ServiceCommToken { 
                return @{ AccessToken = "token" } }

            { Connect-ServiceComm @connectionArgs } | Should -Not -Throw

            $AuthResult.AccessToken | Should -Be "token"
            $BaseUrl | Should -Be $connectionArgs.BaseUrl
            $TenantId | Should -Be $connectionArgs.TenantId
        } 

        It 'Should try to aquire a token' {
            Mock Get-ServiceCommToken {}

            Connect-ServiceComm @connectionArgs | Should -Invoke Get-ServiceCommToken -Exactly 1

        } 
    }
}