<#
.SYNOPSIS
An inline If implementation

.DESCRIPTION
Provides the ability to run inline if statements.

.PARAMETER Condition
The thing being tested.  Should evaluate to a boolean value

.PARAMETER IsTrue
The value to return if the condition is true.  This can also be a script block that will be run
if the condition is true

.PARAMETER IsFalse
The value to return if the conditition is false.  This can also be a script block that will be run
if the condition is false

.EXAMPLE
IIf (5 -gt 0) "Number is larger than 0" "Number is smaller than or equal to 0"

.EXAMPLE
IIf ($true) { Write-Output "Condition is true" } { Write-Output "Condition is false" }

#>
Function Compare-InlineIf {
    [CmdletBinding()]
    Param(
        [bool]$Condition,
        $IsTrue,
        $IsFalse
    )

    Write-Debug ("IIf condition: $Condition")

    If ($Condition -IsNot "Boolean") {$_ = $Condition}
    If ($Condition) {If ($IsTrue -is "ScriptBlock") { &$IsTrue } Else {$IsTrue}}
    Else {If ($IsFalse -is "ScriptBlock") { &$IsFalse } Else { $IsFalse }}
}
# Define an alias for Inline If
New-Alias -Name IIf -Value Compare-InlineIf -Description "Inline If implementation" -Force

<#
.SYNOPSIS
Starts a countdown timer for a determined number of seconds

.DESCRIPTION
Counts down a determined number of seconds sleeping in between each second.  A progress bar can
be optionally displayed

.PARAMETER Seconds
Number of seconds to count down from. Must be a positive number.

.PARAMETER ProgressBar
Switch that controls whether a progress bar is displayed.

.EXAMPLE
Start-Countdown -Seconds 5

Count down for 5 seconds with no progress information

.EXAMPLE
Start-Countdown -Seconds 10 -ProgressBar

Countdown for 10 seconds and display a progress bar
#>
Function Start-Countdown {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$true)][int]$Seconds,
        [switch]$ProgressBar
    )

    # Check that a valid countdown was supplied
    If ($Seconds -le 0)
    {
        Throw "Enter a positive value for the seconds"
        Break
    }

    $Activity = ("Countdown for {0} {1}" -f $Seconds, (IIf ($Seconds -eq 1) "second" "seconds"))
    Write-Verbose $Activity
    
    # Loop over the seconds
    ForEach($Second in ($Seconds..1)){

        $Status = ("{0} {1} remaining" -f $Second, (IIf ($Second -eq 1) "second" "seconds"))
        Write-Verbose $Status

        If ($ProgressBar) {
            Write-Progress -Activity $Activity -Status $Status -PercentComplete (($Seconds - $Second) / $Seconds * 100)
        }

        Start-Sleep -Seconds 1
    }

    Write-Verbose "Countdown complete"
}

Export-ModuleMember -Function *
Export-ModuleMember -Alias *