$check_file = "chocolatey.complete"
if ((Test-Path -Path $Env:temp\$check_file -PathType Leaf)) {
   Write-Host "chocolatey.ps1 already ran through to completion"
   exit 0
}


gci env:* | sort-object name

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

New-Item -Name $check_file -ItemType File -Path $Env:temp
