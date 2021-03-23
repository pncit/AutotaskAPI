cd C:\Users\rob.gilbreath\Documents\GitHub\AutotaskAPI
$creds = Get-Credential
Import-PowerShellDataFile .\AutoTaskAPI.psd1
Import-Module .\AutoTaskAPI.psm1
Add-AutotaskAPIAuth -apiintegrationcode 'CP2GPPT4CQQVDINTF4UQOTI64BG' -credentials $creds

$x = Get-AutotaskAPIResource -Resource Tickets -SimpleSearch "ticketNumber eq T20200930.0068"

function assign {
  Param(
    [string]$ticketNumber,
    [string]$resource
  )
  $assignedResourceRoleId = 29683467
  if ( $resource -eq "Rob" ) { $assignedResourceID = 29682886; $assignedResourceRoleId = 29683465 }
  if ( $resource -eq "Adam" ) { $assignedResourceID = 29682890 }
  if ( $resource -eq "Colin" ) { $assignedResourceID = 29682891 }
  if ( $resource -eq "Caleb" ) { $assignedResourceID = 29682892 }
  if ( $resource -eq "Aidan" ) { $assignedResourceID = 29682893 }
  if ( $resource -eq "Aidan Will" ) { $assignedResourceID = 29682893 }
  if ( $assignedResourceID -eq $null ) { write-host "fail on $resource - $ticketNumber" }

    $x = Get-AutotaskAPIResource -Resource Tickets -SimpleSearch "ticketNumber eq $ticketNumber"
    $y = new-object psobject
    add-member -InputObject $y -MemberType NoteProperty -name id -value $x.id
    add-member -InputObject $y -MemberType NoteProperty -name assignedResourceID -value $assignedResourceID
    add-member -InputObject $y -MemberType NoteProperty -name assignedResourceRoleID -value $assignedResourceRoleId
    Set-AutotaskAPIResource -Resource Tickets -body $y

}

assign -ticketNumber  T20200407.0002 -Resource Caleb

