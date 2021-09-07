$ErrorActionPreference = 'Stop'

Function Is-RunAsAdmin {
  ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

choco -v
if ($? -eq $false) {
    if (-not (Is-RunAsAdmin)) {
        Write-Error 'Administrator authorization is required.'
        exit
    }

    # install chocolatey
    Set-ExecutionPolicy Bypass -Scope Process -Force
    [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
}

choco -v
if ($? -eq $false) {
    exit
}

# TODO: https://twinkletray.com/
# https://www.microsoft.com/ja-jp/p/twinkle-tray-brightness-slider/9pljwwsv01lk
# https://github.com/xanderfrangos/twinkle-tray/releases/download/v1.13.9/Twinkle.Tray.v1.13.9.exe

$choco_packages = @(
    '7zip',
    'adobereader',
    'audacity',
    'chocolateygui',
    'cpu-z',
    'crystaldiskinfo',
    'discord',
    'eartrumpet',
    'firefox',
    'foobar2000',
    'gimp',
    'handbrake',
    'honeyview',
    'mkvtoolnix',
    'mp3tag',
    'paint.net',
    'powertoys',
    'procexp',
    'shexview',
    'shellmenunew',
    'slack',
    'sourcetree',
    'steam-client',
    'teamviewer',
    'microsoft-windows-terminal',
    'xnconvert',
    'utorrent',
    'vlc',
    'vscode',
    'winrar'
)

$package_args = $choco_packages -join ' '
cinst -y $package_args
