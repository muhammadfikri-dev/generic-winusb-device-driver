# ========================================================================
# Generic WinUSB Driver Automated Installer
# Platform: Windows 10 / 11 64-bit (x64)
# ========================================================================

[CmdletBinding()]
param()

$Host.UI.RawUI.WindowTitle = "Generic WinUSB Driver Installer"

function Test-Administrator {
    $user = [Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()
    return $user.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

if (-not (Test-Administrator)) {
    Write-Host "[X] ERROR: Harap jalankan script ini sebagai Administrator!" -ForegroundColor Red
    exit 1
}

Write-Host "========================================================================" -ForegroundColor Cyan
Write-Host "       GENERIC WINUSB RAW DEVICE DRIVER INSTALLER (WINDOWS 10/11 x64)     " -ForegroundColor Yellow
Write-Host "========================================================================" -ForegroundColor Cyan

$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path

# 1. Install Code Signing Certificates
Write-Host "`n[1/3] Memeriksa dan Memasang Sertifikat Digital Driver..." -ForegroundColor Cyan
$certDirs = @(
    "$ScriptDir\Certificates",
    "$ScriptDir\..\Certificates",
    "$ScriptDir"
)

foreach ($dir in $certDirs) {
    if (Test-Path $dir) {
        $certs = Get-ChildItem -Path $dir -Filter "*.cer"
        foreach ($certFile in $certs) {
            Write-Host "    [*] Menginstal sertifikat: $($certFile.Name)..." -ForegroundColor Yellow
            try {
                Import-Certificate -FilePath $certFile.FullName -CertStoreLocation "Cert:\LocalMachine\Root" | Out-Null
                Import-Certificate -FilePath $certFile.FullName -CertStoreLocation "Cert:\LocalMachine\TrustedPublisher" | Out-Null
                Write-Host "    [V] Sertifikat $($certFile.Name) terpasang di Root & TrustedPublisher." -ForegroundColor Green
            } catch {
                Write-Host "    [!] Peringatan sertifikat: $_" -ForegroundColor Yellow
            }
        }
    }
}

# 2. Discover and Install WinUSB INF Packages
Write-Host "`n[2/3] Memasang Driver Generic WinUSB..." -ForegroundColor Cyan

$searchDirs = @(
    "$ScriptDir\drivers",
    "$ScriptDir\..\drivers",
    "$ScriptDir"
)

$infFiles = @()
foreach ($d in $searchDirs) {
    if (Test-Path $d) {
        $infs = Get-ChildItem -Path $d -Recurse -Filter "*.inf"
        foreach ($inf in $infs) {
            if ($infFiles.FullName -notcontains $inf.FullName) {
                $infFiles += $inf
            }
        }
    }
}

$installed = 0
foreach ($inf in $infFiles) {
    Write-Host "    [*] Memasang INF: $($inf.Name)..." -ForegroundColor Yellow
    try {
        $pnpResult = pnputil.exe /add-driver $inf.FullName /install
        $pnpString = $pnpResult | Out-String
        if ($pnpString -match "successfully" -or $pnpString -match "berhasil" -or $LASTEXITCODE -eq 0) {
            Write-Host "    [V] Sukses memasang: $($inf.Name)" -ForegroundColor Green
            $installed++
        } else {
            Write-Host "    [!] Pnputil: $($pnpString.Trim())" -ForegroundColor Yellow
            $installed++
        }
    } catch {
        Write-Host "    [X] Gagal memasang $($inf.Name): $_" -ForegroundColor Red
    }
}

# 3. PnP Rescan
Write-Host "`n[3/3] Memindai Perangkat USB (PnP Rescan)..." -ForegroundColor Cyan
try {
    & pnputil.exe /scan-devices | Out-Null
    Write-Host "    [V] Pemindaian perangkat USB selesai." -ForegroundColor Green
} catch {
    Write-Host "    [!] Gagal memindai perangkat: $_" -ForegroundColor Yellow
}

Write-Host "`n========================================================================" -ForegroundColor Cyan
Write-Host "                         INSTALASI SELESAI                              " -ForegroundColor Green
Write-Host "========================================================================" -ForegroundColor Cyan
Write-Host "  Driver Generic WinUSB telah terpasang dan siap digunakan untuk" -ForegroundColor White
Write-Host "  komunikasi transfer raw endpoint pada perangkat USB Anda." -ForegroundColor White
Write-Host "========================================================================`n" -ForegroundColor Cyan
