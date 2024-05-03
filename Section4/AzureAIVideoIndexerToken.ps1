#Need an Access Token first. Obtain via ARM since using ARM-based paid account
$AuthEndpoint = "https://management.azure.com/subscriptions/SUBID/resourceGroups/RG/providers/Microsoft.VideoIndexer/accounts/ACCOUNTNAME/generateAccessToken?api-version=2024-01-01"
$token = Get-AzAccessToken -ResourceUrl https://management.azure.com/
$headers = @{
    'Content-Type'='application/json'
    'Authorization'='Bearer ' + $token.Token
}

$body = @{
        "permissionType" = "Reader"
        "scope" = "Video"
        "videoId" = "85bc649582"
} | ConvertTo-Json

$resp = Invoke-RestMethod -Uri $AuthEndpoint -Method Post -Headers $headers -Body $body
#$resp.accessToken


#Get some insights about an existing indexed video
#AccountID can be found in the Overview of the resource in the azure portal
$VideoIndexerEndpoint = "https://api.videoindexer.ai/REGION/Accounts/ACCOUNTID/Videos/VIDEOID/Index?accessToken=$($resp.accessToken)"
$headers = @{
    'Content-Type'='application/json'
}
$videoResp = Invoke-RestMethod -Uri $VideoIndexerEndpoint -Method Get -Headers $headers
$videoResp.videos[0].insights