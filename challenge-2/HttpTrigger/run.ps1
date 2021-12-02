
#region DONOTCHANGE
### DO NOT CHANGE THIS PART ###
using namespace System.Net
param($Request, $TriggerMetadata)

################################
#endregion





## Start Making changes from here ##

$url = "https://htfapi.azurewebsites.net/api/the-real-donald"
$method = "POST"
$body = @{
    {
    "sendFakeDonaldData" = "true";
    }
}
$jsonBody = $body | ConvertTo-Json









### DO NOT CHANGE THIS PART ###
#region DONOTCHANGE2
$teamId = $env:teamId
$headers = @{
    'Content-Type' = 'application/json'
    'x-team-id'     = $teamId
}
$finalUrl = $url + "?code=$teamId&clientId=$teamId"
$response = Invoke-RestMethod -Method $method -Uri $finalUrl -Body $jsonBody -Headers $headers -ContentType "application/json"
Push-OutputBinding -Name Response -Value ([HttpResponseContext]@{
        StatusCode  = [HttpStatusCode]::OK
        Body        = $response
        ContentType = 'text/html'
    })
################################
#endregion