param(
    [string]$RepoRoot = (Split-Path -Parent $PSScriptRoot),
    [string]$UserHome = $env:USERPROFILE,
    [switch]$Backup
)

$ErrorActionPreference = 'Stop'

$configs = @(
    @{
        Name = 'komorebi.json'
        Source = Join-Path $RepoRoot 'komorebi.json'
        Destination = Join-Path $UserHome 'komorebi.json'
    },
    @{
        Name = 'komorebi.bar.json'
        Source = Join-Path $RepoRoot 'komorebi.bar.json'
        Destination = Join-Path $UserHome 'komorebi.bar.json'
    },
    @{
        Name = 'applications.json'
        Source = Join-Path $RepoRoot 'applications.json'
        Destination = Join-Path $UserHome 'applications.json'
    },
    @{
        Name = 'whkdrc'
        Source = Join-Path $RepoRoot '.config\whkdrc'
        Destination = Join-Path $UserHome '.config\whkdrc'
    }
)

foreach ($config in $configs) {
    if (-not (Test-Path $config.Source)) {
        Write-Warning "Source not found: $($config.Source)"
        continue
    }

    $destDir = Split-Path -Parent $config.Destination
    if (-not (Test-Path $destDir)) {
        New-Item -ItemType Directory -Path $destDir -Force | Out-Null
    }

    if ($Backup -and (Test-Path $config.Destination)) {
        $timestamp = Get-Date -Format 'yyyyMMdd_HHmmss'
        $backupPath = "$($config.Destination).backup.$timestamp"
        Copy-Item -Path $config.Destination -Destination $backupPath
        Write-Host "Backed up $($config.Name) to $backupPath"
    }

    Copy-Item -Path $config.Source -Destination $config.Destination -Force
    Write-Host "Updated $($config.Name) at $($config.Destination)"
}

Write-Host "Config update complete."
