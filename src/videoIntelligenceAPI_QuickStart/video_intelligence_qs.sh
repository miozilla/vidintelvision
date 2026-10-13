#!/bin/bash

# Script function:
# Set up authorization for a custom service account
# Send an annotate video request to the Video Intelligence API & received results.

# Set up authorization

gcloud iam service-accounts create quickstart

# gcloud iam service-accounts keys create key.json --iam-account quickstart@<your-project-123>.iam.gserviceaccount.com
gcloud iam service-accounts keys create key.json --iam-account quickstart@qwiklabs-gcp-03-afc002a94899.iam.gserviceaccount.com

gcloud auth activate-service-account --key-file key.json

gcloud auth print-access-token

# Make an annotate video request

cat > request.json <<EOF
{
   "inputUri":"gs://spls/gsp154/video/train.mp4",
   "features": [
       "LABEL_DETECTION"
   ]
}
EOF

# Curl to make a videos:annotate request passing the filename of the entity request
curl -s -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer '$(gcloud auth print-access-token)'' \
    'https://videointelligence.googleapis.com/v1/videos:annotate' \
    -d @request.json

# Request information on the operation by calling the v1.operations endpoint. (Replace PROJECTS, LOCATIONS and OPERATION_NAME)
#
# curl -s -H 'Content-Type: application/json' \
#     -H 'Authorization: Bearer '$(gcloud auth print-access-token)'' \
#     'https://videointelligence.googleapis.com/v1/projects/PROJECTS/locations/LOCATIONS/operations/OPERATION_NAME'
    
curl -s -H 'Content-Type: application/json' \
    -H 'Authorization: Bearer '$(gcloud auth print-access-token)'' \
    'https://videointelligence.googleapis.com/v1/projects/955683653042/locations/us-east1/operations/5177858443111007956' \
    -o output.json

