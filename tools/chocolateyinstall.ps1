
$ErrorActionPreference = 'Stop';
$checksum = "5A4E22A8EEC1F64EA91F3323E5FF1672E0466C7EDCC13D6F05B0629E3105BED6"
$repository = "AlbertBall/railway-dot-exe"

Write-Host "Fetching version '$env:ChocolateyPackageVersion'"

$download_url = "https://github.com/$repository/releases/download/v$env:ChocolateyPackageVersion/Release.v$env:ChocolateyPackageVersion.zip"
$toolsDir = "$env:ProgramFiles\Railway_Operation_Simulator"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  url            = $download_url
  specificFolder = "Release v$env:ChocolateyPackageVersion"
  softwareName   = 'Railway Operation Simulator'
  checksum       = $checksum
  checksumType   = 'sha256'
  validExitCodes= @(0, 3010, 1605, 1614, 1641)
}

$binaryDirectory = "$toolsDir\Release v$env:ChocolateyPackageVersion\Railway"
Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyPath -PathToInstall $binaryDirectory -PathType "User"
Get-WebFile -Url "https://raw.githubusercontent.com/AlbertBall/railway-dot-exe/master/railway_Icon.ico" -FileName $binaryDirectory\railway.ico
Install-ChocolateyShortcut -ShortcutFilePath "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Railway Operation Simulator.lnk" -TargetPath "$binaryDirectory\railway.exe" -IconLocation $binaryDirectory\railway.ico
Update-SessionEnvironment