function Get-DirectorySize {
    param(
        [Parameter(Mandatory=$true)]
        [ValidateScript({Test-Path $_ -PathType 'Container'})]
        [string]$Path
    )
    
    # Calculating total size of the directory and its subdirectories
    $totalSize = 0
    $totalFiles = 0
    $totalDirs = 0
    
    Get-ChildItem -Path $Path -Recurse | ForEach-Object {
        if ($_.PsIsContainer) {
            $totalDirs++
        } else {
            $totalFiles++
            $totalSize += $_.Length
        }
    }
    
    # Displaying the results
    Write-Host "Directory Size Analysis:"
    Write-Host "-----------------------"
    Write-Host "Directory Path: $Path"
    Write-Host "Total Size: $(Convert-Size $totalSize)"
    Write-Host "Number of Files: $totalFiles"
    Write-Host "Number of Subdirectories: $totalDirs"
}

# Helper function to convert bytes to a human-readable format
function Convert-Size {
    param([Parameter(Mandatory=$true)][int64]$Size)
    
    $unit = "B","KB","MB","GB","TB","PB"
    $i = 0
    while ($Size -ge 1KB) {
        $Size = $Size/1KB
        $i++
    }
    
    "{0:N2} {1}" -f $Size, $unit[$i]
}

# Prompting the user for directory path
$directoryPath = Read-Host "Enter the directory path:"

# Analyzing the directory
Get-DirectorySize -Path $directoryPath
