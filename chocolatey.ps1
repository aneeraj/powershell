gci env:* | sort-object name

Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://community.chocolatey.org/install.ps1'))

$DVD_Drive = Get-WmiObject win32_volume -filter 'DriveType = "5"'
$DVD_Drive.DriveLetter = "A:"
$DVD_Drive.Put()
Get-Disk | Where partitionstyle -eq 'raw' | Initialize-Disk -PartitionStyle GPT 
New-Partition -DiskNumber 2 -UseMaximumSize -DriveLetter N -GptType "{ebd0a0a2-b9e5-4433-87c0-68b6b72699c7}"
Format-Volume -DriveLetter N
New-Partition -DiskNumber 3 -UseMaximumSize -DriveLetter F -GptType "{ebd0a0a2-b9e5-4433-87c0-68b6b72699c7}"
Format-Volume -DriveLetter F

New-NetFirewallRule -Profile @('Private','Public') -DisplayName "Allow Inbound TCP Port 9090-9097 for IDS" -Direction InBound -LocalPort '9090-9097' -Protocol TCP -Action Allow
New-NetFirewallRule -Profile @('Private','Public') -DisplayName "Allow Inbound TCP Port 9182 for Node Exporter" -Direction InBound -LocalPort '9182' -Protocol TCP -Action Allow

choco install -y  azcopy10 ojdkbuild8 unzip
choco install -y prometheus-windows-exporter.install --params '"/EnabledCollectors:cpu,cs,logical_disk,net,os,memory,textfile,service"'
# Enable .Net 3.5
Enable-WindowsOptionalFeature -Online -FeatureName "NetFx3" -All
# Install Powershell 7.x
wget https://github.com/PowerShell/PowerShell/releases/download/v7.1.4/PowerShell-7.1.4-win-x64.msi -o PowerShell-7.1.4-win-x64.msi
msiexec.exe /package PowerShell-7.1.4-win-x64.msi /quiet ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1 ENABLE_PSREMOTING=1 REGISTER_MANIFEST=1
