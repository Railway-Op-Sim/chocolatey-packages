$ErrorActionPreference = 'Stop';
$packageName  = "railwayopsim"
$installPath = "$env:ProgramFiles\RailwayOperationSimulator"

$packageArgs = @{
  packageName = $packageName
  zipFileName = "Release.v2.11.1.zip"
}

Uninstall-ChocolateyZipPackage @packageArgs
Remove-Item $installPath

#Remove from Path
$Environment = [System.Environment]::GetEnvironmentVariable("Path", "User")
$Environment = $Environment.Replace("$installPath\Railway", "")
[System.Environment]::SetEnvironmentVariable("Path", $Environment, "User")