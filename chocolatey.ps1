gci env:* | sort-object name

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))
New-NetFirewallRule -Profile @('Private','Public') -DisplayName "Allow Inbound TCP Port 9182 for Node Exporter" -Direction InBound -LocalPort '9182' -Protocol TCP -Action Allow
choco install -y prometheus-windows-exporter.install --params '"/EnabledCollectors:cpu,cs,logical_disk,net,os,memory,textfile,service"'
