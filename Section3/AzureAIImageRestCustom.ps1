$endpoint = $env:AI_SVC_ENDPOINT
$read_image_url = "https://raw.githubusercontent.com/johnthebrit/RandomStuff/master/Misc/dogsongrass.jpg"

#We shall call the Read, Objects and Tags features
$ai_url = $endpoint + "computervision/imageanalysis:analyze?api-version=2024-02-01&model-name=orangesandapples"

$headers = @{
    'Content-Type'='application/json'
    'Ocp-Apim-Subscription-Key'=$env:AI_SVC_KEY
}
$body = @{
    "url"=$read_image_url
} | ConvertTo-Json

$resp = Invoke-RestMethod -Uri $ai_url -Method Post -Headers $headers -Body $body

#Objects
$resp.objectsResult.values
#Tags
$resp.tagsResult.values
#Read
$resp.readResult.blocks.lines