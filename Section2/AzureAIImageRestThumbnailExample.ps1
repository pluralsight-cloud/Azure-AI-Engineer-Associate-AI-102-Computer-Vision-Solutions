$endpoint = $env:AI_SVC_ENDPOINT
$read_image_url = "https://raw.githubusercontent.com/johnthebrit/RandomStuff/master/Misc/shields.jpg"

$desired_aspect_ratio = "1, 1.5"

#We shall call the smart crop only but include the desired aspect ratio
$ai_url = $endpoint + "computervision/imageanalysis:analyze?api-version=2024-02-01&features=SmartCrops&smartcrops-aspect-ratios=$desired_aspect_ratio"

$headers = @{
    'Content-Type'='application/json'
    'Ocp-Apim-Subscription-Key'=$env:AI_SVC_KEY
}
$body = @{
    "url"=$read_image_url
} | ConvertTo-Json

$resp = Invoke-RestMethod -Uri $ai_url -Method Post -Headers $headers -Body $body

#The returned bounding box for our smart crop
$resp.smartCropsResult.values