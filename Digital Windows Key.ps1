# Get Windows Product Key and update Gorelo custom field
try {
    # Get Windows Product Key using WMI
    $productKey = (Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey

    if ([string]::IsNullOrEmpty($productKey)) {
        # If OA3xOriginalProductKey is empty, try getting it from registry
        $regPath = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform'
        $regValue = 'BackupProductKeyDefault'
        $productKey = (Get-ItemProperty -Path $regPath -Name $regValue -ErrorAction SilentlyContinue).$regValue
    }

    if ([string]::IsNullOrEmpty($productKey)) {
        # If still empty, try another registry method
        $regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DigitalProductId"
        $digitalId = (Get-ItemProperty -Path $regPath).DigitalProductId
        
        # Convert Digital Product ID to Product Key
        $keyOffset = 52
        $isWin8 = ([math]::Floor($digitalId[66] / 6) -band 1)
        $productKey = ""
        $chars = "BCDFGHJKMPQRSTVWXY2346789"

        for ($i = 24; $i -ge 0; $i--) {
            $r = 0
            for ($j = 14; $j -ge 0; $j--) {
                $r = ($r * 256) -bxor $digitalId[$j + $keyOffset]
                $digitalId[$j + $keyOffset] = [math]::Floor($r / 24)
                $r = $r % 24
            }
            $productKey = $chars[$r] + $productKey
            if (($i % 5) -eq 0 -and $i -ne 0) {
                $productKey = "-" + $productKey
            }
        }
    }

    if (![string]::IsNullOrEmpty($productKey)) {
        # Update Gorelo RMM custom field
        GoreloAction -SetCustomField -Name '$gorelo:asset.WindowsProductKey' -Value $productKey
    #   Write-Output "Successfully updated Windows Product Key in Gorelo"
    } else {
        Write-Error "Could not retrieve Windows Product Key"
      #  exit 1
    }
} catch {
    Write-Error "Error: $($_.Exception.Message)"
    # Get Windows Product Key and update Gorelo custom field
try {
    # Get Windows Product Key using WMI
    $productKey = (Get-WmiObject -query 'select * from SoftwareLicensingService').OA3xOriginalProductKey

    if ([string]::IsNullOrEmpty($productKey)) {
        # If OA3xOriginalProductKey is empty, try getting it from registry
        $regPath = 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform'
        $regValue = 'BackupProductKeyDefault'
        $productKey = (Get-ItemProperty -Path $regPath -Name $regValue -ErrorAction SilentlyContinue).$regValue
    }

    if ([string]::IsNullOrEmpty($productKey)) {
        # If still empty, try another registry method
        $regPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\DigitalProductId"
        $digitalId = (Get-ItemProperty -Path $regPath).DigitalProductId
        
        # Convert Digital Product ID to Product Key
        $keyOffset = 52
        $isWin8 = ([math]::Floor($digitalId[66] / 6) -band 1)
        $productKey = ""
        $chars = "BCDFGHJKMPQRSTVWXY2346789"

        for ($i = 24; $i -ge 0; $i--) {
            $r = 0
            for ($j = 14; $j -ge 0; $j--) {
                $r = ($r * 256) -bxor $digitalId[$j + $keyOffset]
                $digitalId[$j + $keyOffset] = [math]::Floor($r / 24)
                $r = $r % 24
            }
            $productKey = $chars[$r] + $productKey
            if (($i % 5) -eq 0 -and $i -ne 0) {
                $productKey = "-" + $productKey
            }
        }
    }

    if (![string]::IsNullOrEmpty($productKey)) {
        # Update Gorelo RMM custom field
      #  GoreloAction -SetCustomField -Name '$gorelo:asset.WindowsProductKey' -Value $productKey
        Write-Output "Successfully updated Windows Product Key in Gorelo $productKey"
        Write-Output $productKey
    } else {
        Write-Error "Could not retrieve Windows Product Key"
        exit 1
    }
} catch {
    Write-Error "Error: $($_.Exception.Message)"
    #exit
}
}
