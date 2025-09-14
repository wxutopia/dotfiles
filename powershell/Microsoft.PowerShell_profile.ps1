Import-Module Terminal-Icons

Set-PSReadLineOption -EditMode Vi

# Set the prediction source to history records.
Set-PSReadLineOption -PredictionSource History
# Set the prediction view style to list view.
# Default option is inline view (InlineView).
Set-PSReadLineOption -PredictionViewStyle ListView

# Set menu complete key.
Set-PSReadlineKeyHandler -Key "tab" -Function MenuComplete
# Set menu complete key to "Tab".
Set-PSReadlineKeyHandler -Key "ctrl+z" -Function Undo

# Set history search backward key to "shift+tab"
# and move cursor to the end of line.
Set-PSReadLineKeyHandler -Key "ctrl+k" -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::HistorySearchBackward()
    [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
}
# Set history search forward key to "tab"
# and move cursor to the end of line.
Set-PSReadLineKeyHandler -Key "ctrl+j" -ScriptBlock {
    [Microsoft.PowerShell.PSConsoleReadLine]::HistorySearchForward()
    [Microsoft.PowerShell.PSConsoleReadLine]::EndOfLine()
}

# Set-PSReadlineKeyHandler -Key "ctrl+h" -Function BackwardChar
# Set-PSReadlineKeyHandler -Key "ctrl+l" -Function ForwardChar
# Set-PSReadlineKeyHandler -Key "ctrl+e" -Function NextWord
# Set-PSReadlineKeyHandler -Key "ctrl+b" -Function BackwardWord
# Set-PSReadlineKeyHandler -Key "ctrl+u" -Function BeginningOfLine
# Set-PSReadlineKeyHandler -Key "ctrl+o" -Function EndOfLine
# Set-PSReadlineKeyHandler -Key "ctrl+Delete" -Function KillWord
# Set-PSReadlineKeyHandler -Key "ctrl+Backspace" -Function BackwardKillWord
# Set-PSReadlineKeyHandler -Key "ctrl+a" -Function SelectAll

$Env:http_proxy="http://127.0.0.1:7890"
$Env:https_proxy="http://127.0.0.1:7890"

# Utilities
function which ($command) {
    Get-Command -Name $command -ErrorAction SilentlyContinue |
        Select-Object -ExpandProperty Path -ErrorAction SilentlyContinue
}

# Shell wrapper for yazi.
# The wrapper provides the current working directory when exiting yazi.
function y {
    $tmp = [System.IO.Path]::GetTempFileName()
    yazi $args --cwd-file="$tmp"
    $cwd = Get-Content -Path $tmp -Encoding UTF8
    if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
        Set-Location -LiteralPath ([System.IO.Path]::GetFullPath($cwd))
    }
    Remove-Item -Path $tmp
}

Invoke-Expression (&starship init powershell)

# Setup zoxide
$Env:YAZI_FILE_ONE="C:\Users\wangx\scoop\apps\git\current\usr\bin\file.exe"
Invoke-Expression (& { (zoxide init powershell | Out-String ) })
