if (-not $env:BHProjectPath) {
    Set-BuildEnvironment -Path $PSScriptRoot\.. -Force
}
Remove-Module $env:BHProjectName -ErrorAction SilentlyContinue
Import-Module (Join-Path $env:BHProjectPath $env:BHProjectName) -Force

Describe 'Get-ServiceCommMessages' {

    BeforeAll {
        $MessageMocks = ConvertFrom-Json (Get-Content -Path "$env:BHProjectPath\Tests\TestData\MockMessages.json" -Raw ) 
    }

    It 'Gets all Messages' {
        Mock Invoke-ServiceCommMethod { return $MessageMocks.Content.Value } -ModuleName 'PSServiceComm'

        (Get-ServiceCommMessages).Count | Should -Be $MessageMocks.Content.Value.Count
    }

    It 'Gets all Messages filterd by DaysToSync' {
        Mock Invoke-ServiceCommMethod { return $MessageMocks.Content.Value } -ModuleName 'PSServiceComm'

        (Get-ServiceCommMessages -DaysToSync 365).Count | Should -Not -Be 0
    }

    It 'Contains updated messages' {
        Mock Invoke-ServiceCommMethod { return $MessageMocks.Content.Value } -ModuleName 'PSServiceComm'

        @(Get-ServiceCommMessages | Where-Object {$_.IsUpdated() -eq $true}).Count | Should -Be 1
    }
}