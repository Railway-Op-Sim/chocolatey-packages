
$ErrorActionPreference = 'Stop';
$checksum_64 = "5e6a4f39ba3aebd73f88fe7d8893e11b749afb5aa76e271c9588871a05bae46f"
$checksum_32 = "c7d697f3057f3a0f624d06372adb19f8a9cd888853015e1d38771f74dbb8aa1f"
$checksum_icon = "51CC10FCC171AD1F6B9798A8B8C359EA6D37C2A6DF904004155BB65AB8979C45"
$repository = "AlbertBall/railway-dot-exe"

Write-Host "Fetching version '$env:ChocolateyPackageVersion'"

$download_url_32 = "https://github.com/$repository/releases/download/v$env:ChocolateyPackageVersion/RailOS32-v$env:ChocolateyPackageVersion.zip"
$download_url_64 = "https://github.com/$repository/releases/download/v$env:ChocolateyPackageVersion/RailOS64-v$env:ChocolateyPackageVersion.zip"
$toolsDir = "$env:ProgramFiles\Railway_Operation_Simulator"
$target_dir_32 = "$toolsDir\RailOS32-v$env:ChocolateyPackageVersion"
$target_dir_64 = "$toolsDir\RailOS64-v$env:ChocolateyPackageVersion"

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
$exe_path_32 = "$binaryDirectory\RailOS32.exe"
$exe_path_64 = "$binaryDirectory\RailOS64.exe"

Install-ChocolateyZipPackage @packageArgs

if("$env:ChocolateyForceX86") {
  Move-Item -Path "$target_dir_32\Railway" -Destination $binaryDirectory
  Remove-Item -LiteralPath $target_dir_32 -Force -Recurse
}
else {
  Move-Item -Path "$target_dir_64\Railway" -Destination $binaryDirectory
  Remove-Item -LiteralPath $target_dir_64 -Force -Recurse
}

Install-ChocolateyPath -PathToInstall $binaryDirectory -PathType "User"
Get-WebFile -Url "https://raw.githubusercontent.com/AlbertBall/railway-dot-exe/master/railway_Icon.ico" -FileName $binaryDirectory\railway.ico
Get-ChecksumValid -File $binaryDirectory\railway.ico -Checksum $checksum_icon -ChecksumType 'sha256'

# Need to set binary directory as writable because RailOS needs to be able to write session file during execution
# and we do not want the user to have to run the program with Admin rights
$ACL = Get-ACL -Path $binaryDirectory
$AccessRule = New-Object System.Security.AccessControl.FileSystemAccessRule($env:USERNAME,"Write","Allow")
$ACL.SetAccessRule($AccessRule)
$ACL | Set-Acl -Path $binaryDirectory

if([System.IO.File]::Exists($exe_path_32)) {
  $rail_os_exe = $exe_path_32
}
else {
  $rail_os_exe = $exe_path_64
}
Install-ChocolateyShortcut -ShortcutFilePath "$env:APPDATA\Microsoft\Windows\Start Menu\Programs\Railway Operation Simulator.lnk" -TargetPath "$rail_os_exe" -IconLocation $binaryDirectory\railway.ico
Update-SessionEnvironment