####################
#PRC Engineeing AB (C)
#Author: DRA
####################
param([switch]$Elevated)

function Test-Admin {
  $currentUser = New-Object Security.Principal.WindowsPrincipal $([Security.Principal.WindowsIdentity]::GetCurrent())
  $currentUser.IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
}
if ((Test-Admin) -eq $false)  {
    if ($elevated) 
    {
        # tried to elevate, did not work, aborting
    } 
    else {
        Start-Process powershell.exe -Verb RunAs -ArgumentList ('-noprofile -file "{0}" -elevated' -f ($myinvocation.MyCommand.Definition))
}
exit
}
"____________________________________
Program to toggle Dynamic/Static ip
____________________________________
Possible Commands:
    *dhcp*        
    *static*
    *about*
    *quit*
____________________________________"

#[char]::ConvertFromUtf32(0x00C4) = Ä
[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
$path = "C:\Users\A482457\OneDrive - AF\Desktop\Change-IP-Windows"
write-host($path)
# if([System.IO.File]::Exists($path+ "\userinput.txt")){
#   Remove-Item –path $path\"userinput.txt"  
# }

do{  #repetera loopen tills användaren skrivit dhcp eller static
$args = read-host 

#Skapa konfigurationsfil om det inte redan finns
if(-not [System.IO.File]::Exists($path + "\userinput")){
  do{
    New-Item -Path $path -Name "userinput" -Item "file"
    Start-Sleep -s 2
    $userinput = [Microsoft.VisualBasic.Interaction]::InputBox($msg, "Välj interface")
    write-host($msg)
    }
    until(-not [string]::IsNullOrEmpty($userinput))
  Add-Content -path $path\userinput -value $userinput
}
$EthernetAdapter = Get-Content -Path $path\userinput
write-host($EthernetAdapter)
if ($args -eq "dhcp"){
            netsh interface ip set address name = $EthernetAdapter source = $args           
            $a = "quit"  
        }
elseif ($args -eq "static"){
        do{
          "Enter IP in format: xxx.xxx.xxx.xxx (only numbers)"
          $newIp = Read-Host
        }
        until($newIp -ne '' -or $newIp -eq 'quit')
        if ($newIp -eq 'quit'){
          exit
        }
        "Enter Submask in format: xxx.xxx.xxx.xxx (only numbers) or press enter for 255.255.255.0"
        $newSubMask = read-host
        if ($newSubMask -eq "") {
            $newSubMask = "255.255.255.0"
        }
        if ($newSubMask -eq 'quit'){
          exit
        }
      try{ 
      netsh interface ip set address name= $EthernetAdapter source = $args $newIp $newSubMask  
      } 
      catch [System.Exception]{
        #$ErrorMessage = $_.Exception.Message
        Start-Sleep -Seconds 2
        exit
      }
                      
		$a = "quit"
    } 
    elseif ($args -eq "quit"){
        exit    
    }
    elseif ($args -eq "about"){
        "############################################"
        "Author: David Ragnarsson"
        "############################################"
        $a = "continue"
    }
else{ 
        "Write dhcp or static"
          $a = "continue"   
    }
}
    
until ($a –eq "quit")

if(-not [string]::IsNullOrEmpty($ErrorMessage))
{
  #write-host = $ErrorMessage
  Start-Sleep -Seconds 3
  exit
}
else {
  for ($i = 1; $i -le 100; $i++){
    Write-Progress -Activity "Aktiverar konfiguration" -Status "$i% Complete:" -PercentComplete $i;
}
  Start-Sleep -Seconds 1
  netsh interface ipv4 show config $EthernetAdapter
  Start-Sleep -Seconds 3
  exit
}
exit




 





    
