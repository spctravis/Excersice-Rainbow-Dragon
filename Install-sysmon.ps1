function Install-Sysmon {
<#
.SYNOPSIS 
Uses existing PS-Sessions to move a file to C$ admin share
.DESCRIPTION
This command takes a source filepath and uses C$ admin share to add it to all open PS-Sessions. It will make the filepath if it is not on the remote computer.
.PARAMETER DestinationFilePath
The C:\File Path you want your file to go
.PARAMETER SourcePath
The Source Filepath your file is on your local computer
#>
    [CmdletBinding()]
    Param(
    #Set the Sysmon File Path
        [Parameter(Mandatory=$True,
        ValueFromPipelineByPropertyName=$True)]
        [ValidateNotNull()]
        [String]$SysmonPath,

    #Full Path to Config File
        [Parameter(Mandatory=$True,
        ValueFromPipelineByPropertyName=$True)]
        [ValidateNotNull()]
        [String]$SysmonconfigPath

    ) 

$session = Get-PSSession 

$session | ForEach-Object { 
    $currentsession = $_
    $ComputerName = ($currentsession).ComputerName
        if (!(Invoke-Command -Session $currentsession -ScriptBlock {Test-Path 'C:\Program Files\Sysmon'})) {
        Invoke-Command -Session $currentsession -ScriptBlock { New-Item -ItemType Directory -Path 'C:\Program Files\' -Name 'Sysmon' }
        } #end if

    Copy-Item -Path $SysmonPath -Destination 'C:\Program Files\Sysmon' -Force -ToSession $currentsession
    Copy-Item -Path $SysmonconfigPath -Destination 'C:\Program Files\Sysmon' -Force  -ToSession $currentsession

       

Invoke-Command -Session $currentsession -ScriptBlock {

    & "C:\Program Files\Sysmon\sysmon.exe" -accepteula -i "C:\Program Files\Sysmon\Sysmonconfig.xml" -n -l


    # Create the new service.
#    New-Service -name Sysmon -DisplayName Sysmon -BinaryPathName "C:\Program Files\Sysmon\sysmon.exe"
#    Start-Sleep -Seconds 5

    # Attempt to set the service to delayed start using sc config.
#    Try {
#      Start-Process -FilePath sc.exe -ArgumentList 'config Sysmon start=auto'
#    }
#    Catch { Write-Host "An error occured setting the service to delayed start." -ForegroundColor Red }
    
#    Start-Sleep -Seconds 10
#    Get-Service -DisplayName Sysmon | Start-Service

 
    } # End Invoke
     } # End Foreach
} #End Function