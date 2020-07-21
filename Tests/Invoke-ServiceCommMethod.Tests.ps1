if (-not $env:BHProjectPath) {
    Set-BuildEnvironment -Path $PSScriptRoot\.. -Force
}
Remove-Module $env:BHProjectName -ErrorAction SilentlyContinue
Import-Module (Join-Path $env:BHProjectPath $env:BHProjectName) -Force

Describe 'Invoke-ServiceCommMethod' {

    BeforeAll {
        $MessageMocks = ConvertFrom-Json (Get-Content -Path "$env:BHProjectPath\Tests\TestData\MockMessages.json" -Raw ) 
    }

    It 'Invokes the given method' {
        Mock Invoke-WebRequest { return $MessageMocks } -ModuleName 'PSServiceComm'
        Mock ConvertFrom-Json { return $MessageMocks.Content } -ModuleName 'PSServiceComm'

        (Invoke-ServiceCommMethod -Method '/ServiceComms/Messages').Count | Should -Be $MessageMocks.Content.Value.Count
    }

}