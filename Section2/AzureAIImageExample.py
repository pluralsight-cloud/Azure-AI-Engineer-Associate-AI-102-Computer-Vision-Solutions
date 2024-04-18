#based on https://learn.microsoft.com/en-us/python/api/overview/azure/ai-vision-imageanalysis-readme?view=azure-python-preview
#pip install azure-ai-vision-imageanalysis

#Get your endpoints setup
#setx AI_SVC_KEY YOURKEY
#setx AI_SVC_ENDPOINT YOURENDPOINT

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
read_image_url = "https://raw.githubusercontent.com/johnthebrit/RandomStuff/master/Misc/dogsongrass.jpg"

features = [VisualFeatures.TAGS, VisualFeatures.OBJECTS, VisualFeatures.READ]

# Analyze the image
result = imageanalysis_client.analyze_from_url(image_url=read_image_url, visual_features=features)

print("Raw JSON response")
print(result)

print("\nImage analysis results:")

tags = result['tagsResult']['values']
# Print each tag and its confidence
for tag in tags:
    print(f"Tag: {tag['name']}, Confidence: {tag['confidence']:.4f}")

objects = result['objectsResult']['values']
# Print each tag and its confidence
for obj in objects:
    print(f"Bounding Box: {obj['boundingBox']}")
    for tag in obj['tags']:
        print(f"  Tag: {tag['name']}, Confidence: {tag['confidence']:.4f}")

lines = result['readResult']['blocks'][0]['lines']

# Print each line and its words
for line in lines:
    line_text = line['text']
    words = [word['text'] for word in line['words']]
    print(f"Line: {line_text}, Words: {', '.join(words)}")