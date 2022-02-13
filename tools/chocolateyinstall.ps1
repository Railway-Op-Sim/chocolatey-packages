
$ErrorActionPreference = 'Stop';
$url        = 'https://github.com/AlbertBall/railway-dot-exe/releases/download/v2.11.1/Release.v2.11.1.zip'
$toolsDir = "$env:ProgramFiles\RailwayOperationSimulator"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = $url
  softwareName  = 'Railway Operation Simulator'
  checksum      = 'F54DDA284BFD46AA3BEC19F710C73937CBFE09DECE5B3672C8494009C5156432'
  checksumType  = 'sha256'
  validExitCodes= @(0, 3010, 1605, 1614, 1641)
}

Install-ChocolateyZipPackage @packageArgs
Install-ChocolateyPath -PathToInstall "$toolsDir\Railway" -PathType "User"
Update-SessionEnvironment