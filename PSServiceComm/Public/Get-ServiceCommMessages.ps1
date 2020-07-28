function Get-ServiceCommMessages {
    [CmdletBinding(
        SupportsShouldProcess = $false)]

    param (
        [ValidateRange(1,365)]
        [int]
        $DaysToSync
    )

    $messages = Invoke-ServiceCommMethod -Method '/ServiceComms/Messages' | Sort-Object LastUpdatedTime -Descending

    If($PSBoundParameters.ContainsKey('DaysToSync')){

        $messages = $messages | Where-Object LastUpdatedTime -ge (Get-Date).AddDays(-$daysToSync).Date

    }

    $messages | Add-Member -MemberType ScriptMethod -Name "IsUpdated" -Value {

        ($this.LastUpdatedTime -ge ($this.StartTime).AddHours(1)) -and ($this.Title -match [Regex]::Escape('(Updated)'))
        
    } -Force

    return $messages
}