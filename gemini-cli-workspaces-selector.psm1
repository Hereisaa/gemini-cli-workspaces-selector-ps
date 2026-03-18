function Get-GeminiConfigPath {
    if ($Global:GeminiWorkspaceConfig) { return $Global:GeminiWorkspaceConfig }
    return Join-Path $PSScriptRoot "workspaces.json"
}

function Get-Workspaces {
    $path = Get-GeminiConfigPath
    if (Test-Path $path) {
        try {
            $content = Get-Content $path -Raw -Encoding UTF8
            if ([string]::IsNullOrWhiteSpace($content)) { return @() }
            $parsed = $content | ConvertFrom-Json
            if ($null -eq $parsed) { return @() }
            return $parsed
        } catch { return @() }
    }
    return @()
}

function Save-Workspaces($list) {
    $path = Get-GeminiConfigPath
    $list | ConvertTo-Json | Set-Content $path -Encoding UTF8
}

function Show-WsHelp {
    Write-Host "`n--- Gemini Workspace Selector (GWS) Help ---" -ForegroundColor Cyan
    Write-Host "Usage: ws <command> [parameters]`n"
    Write-Host "Commands:"
    Write-Host "  add <path>  Add a path to the list (use '.' for current directory)"
    Write-Host "  remove      Select and remove a path from the list"
    Write-Host "  list        Show all saved workspace paths"
    Write-Host "  help        Show this help message`n"
    Write-Host "Core Features:"
    Write-Host "  gws         [Selector] Choose a workspace and launch Gemini CLI automatically`n"
}

function ws {
    param([string]$command, [string]$path)
    $list = @(Get-Workspaces)
    switch ($command) {
        "add" {
            if (-not $path) { Write-Host "Error: Please provide a path!" -ForegroundColor Red; return }
            try {
                $fullPath = Resolve-Path $path -ErrorAction Stop
                if ($list -notcontains $fullPath.Path) {
                    $list += $fullPath.Path
                    Save-Workspaces $list
                    Write-Host "Success: Added workspace: $($fullPath.Path)" -ForegroundColor Green
                } else {
                    Write-Host "Note: Path already exists in the list." -ForegroundColor Yellow
                }
            } catch { Write-Host "Error: Path does not exist!" -ForegroundColor Red }
        }
        "remove" {
            if ($list.Count -eq 0) {
                Write-Host "Note: Workspace list is empty." -ForegroundColor Gray
                return
            }

            Write-Host "`n--- Select a Workspace to Remove ---" -ForegroundColor Yellow
            for ($i = 0; $i -lt $list.Count; $i++) {
                Write-Host "[$i] $($list[$i])"
            }
            Write-Host "[q] Cancel"

            $choice = Read-Host "`nEnter selection index to remove"
            if ($choice -eq 'q' -or [string]::IsNullOrWhiteSpace($choice)) { return }
            
            if ($choice -match '^\d+$' -and [int]$choice -lt $list.Count) {
                $removedPath = $list[[int]$choice]
                # Filter out the selected path
                $newList = $list | Where-Object { $_ -ne $removedPath }
                Save-Workspaces $newList
                Write-Host "Success: Removed workspace: $removedPath" -ForegroundColor Green
            } else {
                Write-Host "Error: Invalid selection." -ForegroundColor Red
            }
        }
        "list" {
            if ($list.Count -gt 0) { 
                Write-Host "`nCurrent Workspaces:" -ForegroundColor Cyan
                $list | ForEach-Object { Write-Host "- $_" }
                Write-Host ""
            }
            else { Write-Host "Note: Workspace list is empty." -ForegroundColor Gray }
        }
        "help" { Show-WsHelp }
        default { Show-WsHelp }
    }
}

function gws {
    $list = @(Get-Workspaces)
    if ($list.Count -eq 0) {
        Write-Host "Note: No workspaces found. Use 'ws add' to get started." -ForegroundColor Yellow
        return
    }

    Write-Host "`n--- Select a Workspace to Launch ---" -ForegroundColor Cyan
    for ($i = 0; $i -lt $list.Count; $i++) {
        Write-Host "[$i] $($list[$i])"
    }
    Write-Host "[q] Quit"

    $choice = Read-Host "`nEnter selection index"
    if ($choice -eq 'q' -or [string]::IsNullOrWhiteSpace($choice)) { return }
    if ($choice -match '^\d+$' -and [int]$choice -lt $list.Count) {
        $selected = $list[[int]$choice]
        Set-Location -Path $selected
        Write-Host "Switched to: $selected" -ForegroundColor Green
        gemini
    } else {
        Write-Host "Error: Invalid selection." -ForegroundColor Red
    }
}

Export-ModuleMember -Function ws, gws
