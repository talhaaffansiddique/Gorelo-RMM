# Uninstall the packages forcefully without prompting
if (Get-Package -Name 'GoreloInstaller' -ErrorAction Ignore) {
    Uninstall-Package -Name "GoreloInstaller" -Force -ErrorAction Ignore -Confirm:$false;
}

if (Get-Package -Name 'GoreloAgent' -ErrorAction Ignore) {
    Uninstall-Package -Name "GoreloAgent" -Force -ErrorAction Ignore -Confirm:$false;
}

# Stop processes forcefully without prompting
$processes = @("Gorelo.Rmm.Installer", "Gorelo.Rmm.Installer.Handler", "Gorelo.RemoteManagement.Shell", "Gorelo.RemoteManagement.Agent", "TrayApp")
foreach ($process in $processes) {
    Stop-Process -Name $process -Force -ErrorAction Ignore;
}

# Delete services without prompting
if (Get-Service -Name gorelo.rmm.installer -ErrorAction Ignore) {
    sc.exe delete gorelo.rmm.installer -ErrorAction Ignore;
}

if (Get-Service -Name gorelo.rmm.shell -ErrorAction Ignore) {
    sc.exe delete gorelo.rmm.shell -ErrorAction Ignore;
}

# Remove the folder recursively and forcefully without prompting
Remove-Item -path "$Env:ProgramFiles\Gorelo" -Recurse -Force -ErrorAction Ignore -Confirm:$false;
Remove-Item -Path "Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Gorelo" -Recurse;
