import-module AU

$latest_release_uri = "https://api.github.com/repos/AlbertBall/railway-dot-exe/releases/latest"
$download_link_prefix = "https://github.com/AlbertBall/railway-dot-exe/releases/download/"

function global:au_BeforeUpdate() {
    $Latest.Checksum32 = Get-RemoteChecksum $Latest.Url32
}

function global:au_GetLatest {
    $latest_release_req = Invoke-RestMethod -Uri $latest_release_uri
    $latest_release = $latest_release_req.tag_name
    $version = ($latest_release -split 'v' | Select-Object -Last 1)
    $download_link = "$download_link_prefix/$latest_release/Release.$latest_release.zip"
    @{ Version = $version; URL32 = $download_link}
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyinstall.ps1" = @{
            "(^[$]url\s*=\s*)('.*')" = "`$1'$($Latest.URL32)'"
            "(^[$]checksum\s*=\s*)('.*')" = "`$1'$($Latest.Checksum32)'"
        }
        ".\tools\chocolateyuninstall.ps1" = @{
            "(^[$]zipFileName\s*=\s*)('.*')" = "`$1'Release.v$($Latest.Version).zip'"
        }
    }
}

update -ChecksumFor 32