$ErrorActionPreference = 'Stop'

Function Is-RunAsAdmin {
    ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Is-RunAsAdmin)) {
    Write-Error 'Administrator authorization is required.'
    exit
}

choco -v
if ($? -eq $false) {
    # install chocolatey
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

choco -v
if ($? -eq $false) {
    Write-Error 'Failed install Chocolatey.'
    exit
}

# TODO: https://twinkletray.com/
# https://www.microsoft.com/ja-jp/p/twinkle-tray-brightness-slider/9pljwwsv01lk
# https://github.com/xanderfrangos/twinkle-tray/releases/download/v1.13.9/Twinkle.Tray.v1.13.9.exe

$choco_packages = @(
    '7zip',
    'adobereader',
    'audacity',
    'awscli',
    'chocolateygui',
    'cpu-z',
    'crystaldiskinfo',
    'crystaldiskmark',
    'discord',
    'eartrumpet',
    'epicgameslauncher',
    'ffmpeg',
    'firefox',
    'foobar2000',
    'gallery-dl',
    'gimp',
    'git',
    'github-desktop',
    'goggalaxy',
    'googlechrome',
    'handbrake',
    'honeyview',
    'line',
    'mkvtoolnix',
    'mp3tag',
    'nodejs.install',
    'paint.net',
    'powertoys',
    'procexp',
    'quicklook',
    'r.project',
    'r.studio',
    'shexview',
    'shellmenunew',
    'slack',
    'sourcetree',
    'steam-client',
    'teamviewer',
    'microsoft-windows-terminal',
    'xnconvert',
    'utorrent',
    'visualstudio-installer',
    'vlc',
    'vscode',
    'winrar',
    'yarn',
    'youtube-dl',
    'zoom'
)

$package_args = $choco_packages -join ' '
cinst -y $package_args
