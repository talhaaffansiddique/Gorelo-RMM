# Get Hard Disk Information
$DiskInfo = Get-PhysicalDisk | Select-Object MediaType, Model, Size

# Get RAM Information
$RAMInfo = Get-CimInstance Win32_PhysicalMemory | Select-Object Manufacturer, Capacity, Speed, PartNumber

# Get Processor Information
$CPUInfo = Get-CimInstance Win32_Processor | Select-Object Name, Manufacturer, MaxClockSpeed, NumberOfCores, NumberOfLogicalProcessors

# Display Information
Write-Host "--- Hard Disk Information ---" -ForegroundColor Cyan
$DiskInfo | Format-Table -AutoSize

Write-Host "`n--- RAM Information ---" -ForegroundColor Green
$RAMInfo | Format-Table -AutoSize

Write-Host "`n--- Processor Information ---" -ForegroundColor Yellow
$CPUInfo | Format-Table -AutoSize
