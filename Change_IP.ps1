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

do  #repetera loopen tills användaren skrivit dhcp eller static
{

$args = read-host 


if ($args -eq "dhcp")
       
        {
            netsh interface ip set address name="Ethernet" source  = $args           
            $a = "quit"  
        }
     
   
elseif ($args -eq "static")
    {
        "Enter Static IP in format: xxx.xxx.xxx.xxx (only numbers)"
        $newIp = read-host
        "Enter Submask in format: xxx.xxx.xxx.xxx (only numbers) or enter for standard"
        $newSubMask = read-host
        if ($newSubMask -eq "") {
            $newSubMask = "255.255.255.0"
        }
      try 
      { 
               
      netsh interface ip set address name="Ethernet" source = $args $newIp $newSubMask  
         
      } 
      
      catch [System.Exception]
      {
        $ErrorMessage = $_.Exception.Message
     
        write-host = $ErrorMessage
         
       
        $temp = read-host
        exit
        
      }
                      
		$a = "quit"
    } 
    elseif ($args -eq "quit")
    {
        exit    
    }
    elseif ($args -eq "about")
    {
        "############################################"
		"ÅF PÖYRY AB"
        "David Ragnarsson"
	    "Fabian Fasth"
        "############################################"
        
        $a = "continue"
    }
else 
    
    {
        "Write dhcp or static"
          $a = "continue"
        
    }
 
}
    
until ($a –eq "quit")

for ($i = 1; $i -le 100; $i++ )
{
    Write-Progress -Activity "Aktiverar konfiguration" -Status "$i% Complete:" -PercentComplete $i;
}
netsh interface ipv4 show config "Ethernet"
read-host

exit




 





    
