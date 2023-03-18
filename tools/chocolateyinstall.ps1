
$ErrorActionPreference = 'Stop';
$checksum_64 = "E97FD3EA92E360C50858C62F5DF57A9FA17380F3ED895EA6293303085F17E2E0"
$checksum_32 = "CBFD0FC80314A3EDEE0127495FB1CD53025E36E472B01309F4066BAC7CCF535B"
$repository = "AlbertBall/railway-dot-exe"

Write-Host "Fetching version '$env:ChocolateyPackageVersion'"

$download_url_32 = "https://github.com/$repository/releases/download/v$env:ChocolateyPackageVersion/RailOS32.v$env:ChocolateyPackageVersion.zip"
$download_url_64 = "https://github.com/$repository/releases/download/v$env:ChocolateyPackageVersion/RailOS64.v$env:ChocolateyPackageVersion.zip"
$toolsDir = "$env:ProgramFiles\Railway_Operation_Simulator"

$packageArgs = @{
  packageName    = $env:ChocolateyPackageName
  unzipLocation  = $toolsDir
  url            = $download_url_32
  url64bit       = $download_url_64
  softwareName   = 'Railway Operation Simulator'
  checksum       = $checksum_32
  checksum64     = $checksum_64
  checksumType   = 'sha256'
  checksumType64 = 'sha256'
  validExitCodes= @(0, 3010, 1605, 1614, 1641)
}

$binaryDirectory = "$toolsDir\Railway"
Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyPath -PathToInstall $binaryDirectory -PathType "User"
Get-WebFile -Url "https://raw.githubusercontent.com/AlbertBall/railway-dot-exe/master/railway_Icon.ico" -FileName $binaryDirectory\railway.ico
Install-ChocolateyShortcut -ShortcutFilePath "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Railway Operation Simulator.lnk" -TargetPath "$binaryDirectory\railway.exe" -IconLocation $binaryDirectory\railway.ico
Update-SessionEnvironment