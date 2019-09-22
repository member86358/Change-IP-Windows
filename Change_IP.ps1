####################
#PRC Engineering AB (C)
#Author: David Ragnarsson
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
 #> C:\Users\A482457\Documents\WindowsPowerShell\Data.ps1
"____________________________________
Program To Toggle Dynamic/Static IP
____________________________________
Select Interface to Configure. 
____________________________________"
$list = netsh interface ipv4 show interfaces

$list

$network_interfaces = read-host 
write-host = "You Selected Interface" $network_interfaces "="

<# 
if ($network_interfaces -eq "2")
       
        {            
            $selected_interace = "Ethernet 4"
        }
		
elseif ($network_interfaces -eq "21")
		{
			$selected_interace = "Wi-Fi"
		}
elseif ($network_interfaces -eq "5")
		{
			$selected_interace = "Ethernet"
		}	
		
 #>



do  #repetera loopen tills användaren skrivit dhcp eller static
{
write-host = "Press 1 for DHCP or Press 2 for STATIC" "="
$args = read-host 


if ($args -eq "1")
       
        {            
            netsh interface ip set address name=$network_interfaces source = "dhcp"
            $a = "quit"
        }
elseif ($args -eq "2")
    {
        "Enter Static IP in format: xxx.xxx.xxx.xxx (only numbers)"
        $newIp = read-host
        "Enter Submask in format: xxx.xxx.xxx.xxx (only numbers)"
        $newSubMask = 255.255.255.0
      try 
      { 
      netsh interface ip set address name= $network_interfaces source = "static" $newIp $newSubMask  
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

        "Author: David Ragnarsson"
        "Support: david.ragnarsson@afconsult.com"

        "############################################"
        
        $a = "continue"
    }
else 
    
    {
        "Try Again"
          $a = "continue"
        
    }
 
}
    
until ($a –eq "quit")

write-host = "Done!"
start-sleep -s 2
write-host = "ipconfig will follow!"
start-sleep -s 2

netsh interface ip show addresses $selected_interace

write-host = "Updating BGInfo Desktop"
start-sleep -s 2
C:\Users\A482457\Documents\BGinfo\BGinfo64.exe C:\Users\A482457\Documents\BGinfo\BGinfo.bgi /Timer:0 /nolicprompt /silent



'Press a Key To Exit'
$arg = read-host


exit




 





    
