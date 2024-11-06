# Define the path to the CLI program
$PublishPath = "D:\Path\To\Your\Program\Release\"
$logDir = "$PublishPath\logs"
$dateTime = (Get-Date).ToString("yyyyMMdd_HHmmss")  # Current date and time format
$logFile = "$logDir\log_$dateTime.txt"
$app = 'YourApplication.exe'  # Replace with your executable name

# Verify the full path to the executable
$exePath = Join-Path $PublishPath $app
Write-Output "Executable path: $exePath"

# Check if the executable exists
if (-not (Test-Path $exePath)) {
    Write-Error "Executable not found at: $exePath"
    exit
}

# Check if the log path exists
if (-not (Test-Path $logDir)) {
    Write-Error "Log path not found: $logDir"
    New-Item -ItemType Directory -Path $logDir -Force
    Write-Host "Created log path: $logDir"
}

cd $PublishPath

# Simulate key presses (test)
Add-Type -AssemblyName 'System.Windows.Forms'
[System.Windows.Forms.SendKeys]::SendWait("test")
[System.Windows.Forms.SendKeys]::SendWait("{ENTER}")

# Start the application and redirect output to the log file
Start-Process -FilePath "$exePath" -RedirectStandardOutput "$logFile" -NoNewWindow -Wait

# Monitor the log file in real-time
Start-Process powershell.exe -ArgumentList "-NoExit", "-Command", "Get-Content '$logFile' | Out-Host"