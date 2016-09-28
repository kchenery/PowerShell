@{
    RootModule = "PsUtilities.psm1"
    ModuleVersion = "1.0.0.0"
    GUID = "fdd9bc8a-8699-466c-b094-06af2da85224"
    Author = "Kent Chenery"
    CompanyName = "N/A"
    Description = "PowerShell utilities"
    FunctionsToExport = @(  "Compare-InlineIf",
                            "Start-Countdown",
                            "Start-Beep",
                            "Get-Uptime",
                            "New-Guid")
    VariablesToExport = "*"
    AliasesToExport = @(    "IIf",
                            "Beep")
    FileList = @("PsUtilities.psm1")
    RequiredModules = @()
    PrivateData = @{}
    HelpInfoUri = ""
}