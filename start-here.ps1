# Original Script located at:
# http://blogs.msdn.com/b/virtual_pc_guy/archive/2010/09/23/a-self-elevating-powershell-script.aspx

# Get the ID and security principal of the current user account
$myWindowsID=&#91;System.Security.Principal.WindowsIdentity]::GetCurrent()
$myWindowsPrincipal=new-object System.Security.Principal.WindowsPrincipal($myWindowsID)

# Get the security principal for the Administrator role
$adminRole=&#91;System.Security.Principal.WindowsBuiltInRole]::Administrator

# Check to see if we are currently running "as Administrator"
if ($myWindowsPrincipal.IsInRole($adminRole))

   {
   # We are running "as Administrator" - so change the title and background color to indicate this
   $Host.UI.RawUI.WindowTitle = $myInvocation.MyCommand.Definition + "(Elevated)"
   $Host.UI.RawUI.BackgroundColor = "DarkBlue"
   clear-host

   }
else
   {
   # We are not running "as Administrator" - so relaunch as administrator

   # Create a new process object that starts PowerShell
   $newProcess = new-object System.Diagnostics.ProcessStartInfo "PowerShell";

   # Specify the current script path and name as a parameter
   $newProcess.Arguments = $myInvocation.MyCommand.Definition;

   # Indicate that the process should be elevated
   $newProcess.Verb = "runas";

   # Start the new process
   &#91;System.Diagnostics.Process]::Start($newProcess);

   # Exit from the current, unelevated, process
   exit

   }

Set-ExecutionPolicy -executionPolicy unrestricted -force -scope process

& "$psScriptRoot\s2d-deploy.ps1"
& "$psScriptRoot\create-share.ps1"
& "$psScriptRoot\deploy-networking.ps1"
& "$psScriptRoot\dld-bob.boot.iso.ps1"
& "$psScriptRoot\agent-install.ps1"
