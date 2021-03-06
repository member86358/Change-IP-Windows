
param([switch]$Elevated, [string]$adapter, [string]$ip, [string]$netmask)
function Test-Admin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
if ((Test-Admin) -eq $false) {
    if ($elevated) {
        # tried to elevate, did not work, aborting
    } 
    else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
}
exit
}
  netsh interface ip set address name = $adapter source = 'static' $ip $netmask
  for ($i = 1; $i -le 100; $i++){
    Write-Progress -Activity "Setting static ip" -Status "$i% Complete:" -PercentComplete $i;
    sleep(0.4);
    }
ipconfig /all
