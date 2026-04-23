# Fish Shell Setup Script for WSL (run after reboot)
# This script installs Fish shell and Starship inside WSL Ubuntu,
# then deploys your config files.

Write-Host "=== Fish Shell WSL Setup ===" -ForegroundColor Cyan

# Check if WSL Ubuntu is available
$wslList = wsl --list --quiet 2>&1 | Out-String
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

# Copy config.fish from the dotfiles repo
$fishConfig = Get-Content "$PSScriptRoot\config.fish" -Raw
$fishConfig = $fishConfig -replace "`r`n", "`n"
$fishConfig | wsl -d Ubuntu -- bash -c "cat > ~/.config/fish/config.fish"

Write-Host "Setting up Starship config..." -ForegroundColor Yellow
# Copy starship.toml
$starshipConfig = Get-Content "$PSScriptRoot\..\starship\starship.toml" -Raw
$starshipConfig = $starshipConfig -replace "`r`n", "`n"
$starshipConfig | wsl -d Ubuntu -- bash -c "cat > ~/.config/starship.toml"

Write-Host "Setting Fish as default shell in WSL..." -ForegroundColor Yellow
wsl -d Ubuntu -- bash -c "sudo chsh -s /usr/bin/fish \$(whoami)"

Write-Host ""
Write-Host "=== Setup Complete! ===" -ForegroundColor Green
Write-Host "You can now run 'wsl' to enter Fish shell with Starship prompt." -ForegroundColor Green
Write-Host "Or run 'wsl -d Ubuntu -- fish' to launch Fish directly." -ForegroundColor Green
