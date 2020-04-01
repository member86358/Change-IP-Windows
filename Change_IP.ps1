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

# function Showmenu {
#     param ([string]$Title = 'Menu')
#     cls
#     Write-Host "==============$Title=============="
#     Write-Host "1: Show IP"
#     Write-Host "2: Change IP."
#     Write-Host "Exit: Exits the Application"
# }

#     do {
#         Showmenu
#         $input = Read-Host "Please make a selection"
#         switch ($input)
#     {
#           '1'
#           {
#             Write-Host $input
#           } 
#           '2'
#           {
#             Write-Host $input
#           }
#         }
#     } until (input -eq 'q')

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
$path = "C:\Users\A482457\OneDrive - AF\Desktop\Change-IP-Windows"
if([System.IO.File]::Exists($path + "\userinput.txt")){
  Remove-Item –path $path\"userinput.txt"  
}

do  #repetera loopen tills användaren skrivit dhcp eller static
{

$args = read-host 
do{
[void][Reflection.Assembly]::LoadWithPartialName('Microsoft.VisualBasic')
$userinput = [Microsoft.VisualBasic.Interaction]::InputBox($msg, "Välj interface")
write-host($msg)
}

until(-not [string]::IsNullOrEmpty($userinput))
New-Item -Path $path -Name "userinput.txt" -Item "file"
Start-Sleep -s 2
if([System.IO.File]::Exists($path + "\userinput.txt")){
  Add-Content -path $path\userinput.txt -value $userinput
}
else{
  Add-Content -path $path\userinput.txt -value $userinput
}

if ($args -eq "dhcp"){
            netsh interface ip set address name = $userinput source = $args           
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
      netsh interface ip set address name= $userinput source = $args $newIp $newSubMask  
      } 
      catch [System.Exception]{
        $ErrorMessage = $_.Exception.Message
        write-host = $ErrorMessage
        Start-Sleep -Seconds 3
        exit
      }
                      
		$a = "quit"
    } 
    elseif ($args -eq "quit"){
        exit    
    }
    elseif ($args -eq "about"){
        "############################################"
		    "ÅF PÖYRY AB"
        "David Ragnarsson"
	      "Fabian Fasth"
        "############################################"
        $a = "continue"
    }
else{ 
        "Write dhcp or static"
          $a = "continue"   
    }
}
    
until ($a –eq "quit")

for ($i = 1; $i -le 100; $i++){
    Write-Progress -Activity "Aktiverar konfiguration" -Status "$i% Complete:" -PercentComplete $i;
}
#netsh interface ipv4 show config $userinput
if($ErrorMessage -ne '')
{
  read-host
}
else {
  ipconfig /all  
  read-host
}
exit




 





    
