from azure.ai.vision.imageanalysis import ImageAnalysisClient
from azure.ai.vision.imageanalysis.models import VisualFeatures
from azure.core.credentials import AzureKeyCredential
import os

#Authenticate
subscription_key = os.environ["AI_SVC_KEY"]
endpoint = os.environ["AI_SVC_ENDPOINT"]
imageanalysis_client = ImageAnalysisClient(endpoint, AzureKeyCredential(subscription_key))


#OCR: Read File using the Read API, extract text - remote
print("===== Read File - remote =====")
# Get an image with text
read_image_url = "https://raw.githubusercontent.com/johnthebrit/RandomStuff/master/Misc/shields.jpg"

features = [VisualFeatures.SMART_CROPS]

# Analyze the image
result = imageanalysis_client.analyze_from_url(image_url=read_image_url, visual_features=features, smart_crops_aspect_ratios=[1, 1.5])

print(result)

thumbnails = result['smartCropsResult']['values']
# Print each tag and its confidence
for thumbnail in thumbnails:
    print(f"Aspect ratio: {thumbnail['aspectRatio']}")
    print(f"Thumbnail: {thumbnail['boundingBox']}")