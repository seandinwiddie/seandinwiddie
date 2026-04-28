# Fish Shell Setup Script for WSL (run after reboot)
# This script installs Fish shell and Starship inside WSL Ubuntu,
# then deploys your config files.

Write-Host "=== Fish Shell WSL Setup ===" -ForegroundColor Cyan

# Check if WSL Ubuntu is available (handle UTF-16 output from wsl --list)
$wslList = wsl --list --quiet 2>&1 | Out-String
$wslList = $wslList -replace "`0", ""  # Strip null bytes from UTF-16
if ($wslList -notmatch "Ubuntu") {
    Write-Host "ERROR: Ubuntu is not installed in WSL. Run 'wsl --install -d Ubuntu' first." -ForegroundColor Red
    exit 1
}

Write-Host "Installing Fish shell in WSL Ubuntu..." -ForegroundColor Yellow
wsl -d Ubuntu -- bash -c "sudo apt-get update && sudo apt-get install -y fish"

Write-Host "Installing Starship in WSL Ubuntu..." -ForegroundColor Yellow
wsl -d Ubuntu -- bash -c "curl -sS https://starship.rs/install.sh | sh -s -- -y"

Write-Host "Setting up Fish config..." -ForegroundColor Yellow
# Create fish config directory in WSL
wsl -d Ubuntu -- bash -c "mkdir -p ~/.config/fish"

# Copy config.fish via /mnt/c/ to preserve UTF-8 encoding (Nerd Font glyphs)
$repoRoot = (Split-Path $PSScriptRoot -Parent)
$wslRepoRoot = "/mnt/c" + ($repoRoot -replace "^C:", "" -replace "\\", "/")
wsl -d Ubuntu -- bash -c "cp '$wslRepoRoot/fish/config.fish' ~/.config/fish/config.fish && sed -i 's/\r//' ~/.config/fish/config.fish"

Write-Host "Setting up Starship config..." -ForegroundColor Yellow
# Copy starship.toml via /mnt/c/ to preserve UTF-8 encoding (Nerd Font glyphs)
wsl -d Ubuntu -- bash -c "cp '$wslRepoRoot/starship/starship.toml' ~/.config/starship.toml && sed -i 's/\r//' ~/.config/starship.toml"

Write-Host "Setting Fish as default shell in WSL..." -ForegroundColor Yellow
wsl -d Ubuntu -u root -- chsh -s /usr/bin/fish $(wsl -d Ubuntu -- whoami)

Write-Host ""
Write-Host "=== Setup Complete! ===" -ForegroundColor Green
Write-Host "You can now run 'wsl' to enter Fish shell with Starship prompt." -ForegroundColor Green
Write-Host "Or run 'wsl -d Ubuntu -- fish' to launch Fish directly." -ForegroundColor Green
