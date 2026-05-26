param(
    [string]$SourceRepository = 'https://github.com/LGUG2Z/komorebi-application-specific-configuration.git',
    [string]$SourceBranch = 'main',
    [string[]]$DestinationPaths = @(
        (Join-Path $PSScriptRoot '..\applications.json'),
        (Join-Path $env:USERPROFILE 'applications.json')
    )
)

$ErrorActionPreference = 'Stop'

function Resolve-TargetPath {
    param(
        [Parameter(Mandatory)]
        [string]$Path
    )

    $resolvedPath = [System.IO.Path]::GetFullPath($Path)
    $parentDirectory = Split-Path -Parent $resolvedPath

    if (-not (Test-Path $parentDirectory)) {
        New-Item -ItemType Directory -Path $parentDirectory -Force | Out-Null
    }

    return $resolvedPath
}

$temporaryDirectory = Join-Path ([System.IO.Path]::GetTempPath()) ("komorebi-apps-{0}" -f ([guid]::NewGuid().ToString('N')))

try {
    git clone --depth 1 --branch $SourceBranch $SourceRepository $temporaryDirectory | Out-Null

    $sourceFile = Join-Path $temporaryDirectory 'applications.json'

    if (-not (Test-Path $sourceFile)) {
        throw "Expected applications.json at $sourceFile, but it was not found."
    }

    foreach ($destinationPath in $DestinationPaths) {
        $resolvedDestination = Resolve-TargetPath -Path $destinationPath
        Copy-Item -Path $sourceFile -Destination $resolvedDestination -Force
        Write-Host "Synced applications.json to $resolvedDestination"
    }
}
finally {
    if (Test-Path $temporaryDirectory) {
        Remove-Item -Path $temporaryDirectory -Recurse -Force
    }
}