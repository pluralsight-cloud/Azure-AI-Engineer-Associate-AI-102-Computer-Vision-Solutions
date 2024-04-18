$endpoint = $env:AI_SVC_ENDPOINT
$read_image_url = "https://raw.githubusercontent.com/pluralsight-cloud/Azure-AI-Engineer-Associate-AI-102-Computer-Vision-Solutions/master/Section3/TrainingData/Unknown%201.jpg"

#We shall call the Read, Objects and Tags features
$ai_url = $endpoint + "computervision/imageanalysis:analyze?api-version=2023-02-01-preview&model-name=orangesandapples"

$headers = @{
    'Content-Type'='application/json'
    'Ocp-Apim-Subscription-Key'=$env:AI_SVC_KEY
}
$body = @{
    "url"=$read_image_url
} | ConvertTo-Json

$resp = Invoke-RestMethod -Uri $ai_url -Method Post -Headers $headers -Body $body

#Objects
$resp.customModelResult.objectsResult.values