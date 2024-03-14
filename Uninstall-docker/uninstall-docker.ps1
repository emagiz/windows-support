# Stop Docker containers
try {
    $containers = docker ps -q
    if ($containers) {
        $containers | ForEach-Object {
            docker stop $_
        }
    }
} catch {
    Write-Output "Error stopping Docker containers: $_"
}

# Stop Docker service
try {
    Stop-Service -Name docker -ErrorAction Stop
} catch {
    Write-Output "Error stopping Docker service: $_"
}

# Unregister Docker service
try {
    & dockerd --unregister-service
    Write-Output "Docker service unregistered successfully."
} catch {
    Write-Output "Error unregistering Docker service: $_"
}

# Check if Docker service is uninstalled
$service = Get-Service -Name "docker" -ErrorAction SilentlyContinue
if ($service -eq $null) {
    Write-Output "Docker is uninstalled successfully"
} else {
    Write-Output "Could not uninstall Docker"
}