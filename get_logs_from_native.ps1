# Define the remote server details
$remoteServer = "192.168.20.4"
$remoteUsername = "user"
$remotePrivateKey = "C:\User\Documents\private_key.pem"

# Define the remote paths and filenames
$remoteProgramPath = "/opt/Boosteroid/bin/boosteroid"
$remoteLogFilePath = "/opt/Boosteroid/bst_client.log"

# Define the local paths and filenames
$localLogFilename = "bst_client_stdout.log"
$localDesktopPath = [System.Environment]::GetFolderPath("Desktop") + "\" + $localLogFilename

# Run the program remotely and save its output to a log file
Invoke-Expression "wsl ssh -i $remotePrivateKey $remoteUsername@$remoteServer ""$remoteProgramPath > $remoteLogFilePath"""

# Copy the log file from the remote server to the local desktop
Invoke-Expression "wsl scp -i $remotePrivateKey $remoteUsername@$remoteServer:""$remoteLogFilePath"" ""$localDesktopPath"""

# Check if the file transfer was successful
if ($?) {
    Write-Host "Log file copied to your desktop: $localDesktopPath"
} else {
    Write-Host "Failed to copy the log file."
}
