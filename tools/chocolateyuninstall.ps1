$ErrorActionPreference = 'Stop';

if (-not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    throw "This script must be run as Administrator"
}

$installPath = "$env:ProgramFiles\Railway_Operation_Simulator"

$packageArgs = @{
  packageName = $env:ChocolateyPackageName
  zipFileName = "Release.$env:ChocolateyPackageVersion.zip"
}

Uninstall-ChocolateyZipPackage @packageArgs
Remove-Item -Recurse $installPath
Remove-Item "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Railway Operation Simulator.lnk"

#Remove from Path
$Environment = [System.Environment]::GetEnvironmentVariable("Path", "User")
$Environment = $Environment.Replace("$installPath\Railway", "")
[System.Environment]::SetEnvironmentVariable("Path", $Environment, "User")