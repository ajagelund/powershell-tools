[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [string]
    $Path
)

if ((Test-Path -Path $Path) -eq $False) {
    Write-Error -Message "Path does not exist!" -ErrorAction Stop
}

$resolved = Resolve-Path $Path

$oldpath = (Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path
$newpath = "$oldpath;$resolved"
Set-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH -Value $newPath

(Get-ItemProperty -Path 'Registry::HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\Session Manager\Environment' -Name PATH).path