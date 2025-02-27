#!/bin/sh

# This example based on the currently published UNHCR report:
# https://reliefweb.int/report/south-sudan/profiling-refugees-and-returnees-renk-sudan-emergency-response-november-2024

# To be used in conjunction with the schema at https://test.reliefweb-int.ahconu.org/post-api-schemas/v2/report.json
# Look there for field descriptions, maximum numbers of options, character counts, etc.

# Configuration for all api calls.
rw_api_url="https://test.api-reliefweb-int.ahconu.org/v2"
#rw_api_url="https://api.reliefweb.int/v2"
appname="TEST-APP-NAME"
rw_api_namespace="8e27a998-c362-5d1f-b152-d474e1d36af2"
example_post_api_key="REPLACE_WITH_YOUR_API_KEY"
example_post_api_provider="REPLACE_WITH_PROVIDER_UUID"
# Directory where files can be found.
file_path="/home/$USER/Documents"
# source_id: 2868 "UN High Commissioner for Refugees"
source_id="2868"
source_name="UN High Commissioner for Refugees"

# Taxonomy lookup hints:
# Find a country id: https://api.reliefweb.int/v2/countries?appname=${appname}&query[value]=*
# E.g: https://api.reliefweb.int/v2/countries?appname=${appname}&query[value]=cameroon
# Find a language id: https://api.reliefweb.int/v2/references/languages?appname=${appname}&query[value]=*
# E.g: https://api.reliefweb.int/v2/references/languages?appname=${appname}&query[value]=french

# Configuration for a single report.
# Required fields.

# URL.
report_url="https://data.unhcr.org/en/documents/details/112858"

# UUID.
uuid="$(uuidgen --sha1 --namespace ${rw_api_namespace} --name ${report_url})"

# Title.
title="Profiling of Refugees and Returnees in Renk - Sudan Emergency Response (November 2024)"

# Sources.
sources="[${source_id}]"

# Countries.
echo "For reference, these are the most common countries ${source_name} reports are tagged with:"
echo "https://api.reliefweb.int/v2/reports?appname=${appname}&facets[0][field]=country&facets[0][filter][field]=source.id&facets[0][filter][value]=${source_id}&facets[0][sort]=count:desc&limit=0"
# country_id: 8657 South Sudan
# country_id: 220 Sudan
countries="[8657, 220]"

# Formats.
echo "For reference, these are the most common formats ${source_name} reports are tagged with:"
echo "https://api.reliefweb.int/v2/reports?appname=${appname}&facets[0][field]=format&facets[0][filter][field]=source.id&facets[0][filter][value]=${source_id}&facets[0][sort]=count:desc&limit=0"
# format_id: 5 Assessment
formats="[5]"

# Languages.
echo "For reference, these are the most common languages ${source_name} reports are tagged with:"
echo "https://api.reliefweb.int/v2/reports?appname=${appname}&facets[0][field]=language&facets[0][filter][field]=source.id&facets[0][filter][value]=${source_id}&facets[0][sort]=count:desc&limit=0"
# language_id: 267 English
languages="[267]"

# Published: 3 December 2024
published="2024-12-03T00:00:00+00:00"

# Body.
body="**Executive summary**\nWith no end in sight to the Sudan conflict, the humanitarian response in Renk continues to focus on providing lifesaving assistance at points of entry, transit centers, and onward movement. With the ongoing flow of new arrivals and emerging trends to consider, such as the increasing number of refugees and returnees unwilling to proceed to onward destinations, several options have been identified to facilitate the immediate, medium-term, and long-term response.\nA profiling exercise was initially carried out in June 2024 (round 1). A total of 5,440 interviews were conducted, respondents included (18% refugee, 82% returnees), which formed the basis of the proposed approaches encapsulated in the draft Renk Interagency Transition Roadmap. The document has been reviewed and endorsed by all the humanitarian actors on the ground. Given the transitory nature of the population, a second profiling exercise (round 2) was conducted in September 2024 to ensure that the proposed course of action remains relevant and responsive to the needs of the population. Respondents included 8,115 families (14.5 % refugees, 85.4 % returnees). This document presents the findings of the two exercises."

# Not mandatory fields - include as much of this information as exists.

# Embargo date, if there is one, in the ISO 8601 format e.g."2024-11-21T00:00:00+00:00"
embargoed=""

# Origin.
origin="https://data.unhcr.org/en/documents/details/112858"

# File.
# (This pdf is generated on demand at https://data.unhcr.org/en/documents/download/112858, I've invented a url and filename)
file_url="https://data.unhcr.org/en/documents/download/112858.pdf"
file_uuid=$(uuidgen --sha1 --namespace $uuid --name "${file_url}")
file_filename="Profiling of Refugees and Returnees in Renk - November 2024.pdf"
file_checksum=$(sha256sum "${file_path}/${file_filename}" | cut -f 1 -d " ")
file_language="en"

# Image.
# There is no image for this report.
image_url=""
if [ -n "$image_url" ]; then
  image_uuid=$(uuidgen --sha1 --namespace $uuid --name "${image_url}")
  image_checksum=$(curl -s $image_url | sha256sum | cut -f 1 -d " ")
fi
image_description=""
image_copyright=""

# Disasters.
echo "For reference, these are the most common disasters ${source_name} reports are tagged with:"
echo "https://api.reliefweb.int/v2/reports?appname=${appname}&facets[0][field]=disaster&facets[0][filter][field]=source.id&facets[0][filter][value]=${source_id}&facets[0][sort]=count:desc&limit=0"
# No disasters for this report.
# disasters="[]"

# Disaster types.
echo "For reference, these are the most common disaster types ${source_name} reports are tagged with:"
echo "https://api.reliefweb.int/v2/reports?appname=${appname}&facets[0][field]=disaster_type&facets[0][filter][field]=source.id&facets[0][filter][value]=${source_id}&facets[0][sort]=count:desc&limit=0"
# No disaster types for this report.
# disaster_types="[]"

# Themes.
echo "For reference, these are the most common themes ${source_name} reports are tagged with:"
echo "https://api.reliefweb.int/v2/reports?appname=${appname}&facets[0][field]=theme&facets[0][filter][field]=source.id&facets[0][filter][value]=${source_id}&facets[0][sort]=count:desc&limit=0"
# theme_id: 4600 Protection and Human Rights
# theme_id: 4601 Recovery and Reconstruction
themes="[4600, 4601]"

# Notify: using a made-up example.
notify="test@example.com"

echo "\n"

data="\"url\": \"${report_url}\", \"uuid\": \"${uuid}\", \"title\": \"${title}\", \"source\": ${sources}, \"country\": ${countries}, \"format\": ${formats}, \"language\": ${languages}, \"published\": \"${published}\", \"body\": \"${body}\""

if [ -n "$embargoed" ]; then
  data="${data}, \"embargoed\": \"${embargoed}\""
fi
if [ -n "$origin" ]; then
  data="${data}, \"origin\": \"${origin}\""
fi
if [ -n "$file_url" ]; then
  data="${data}, \"file\": [ { \"url\": \"$file_url\", \"uuid\": \"${file_uuid}\", \"filename\": \"${file_filename}\", \"checksum\": \"$file_checksum\", \"file_language\": \"${file_language:-en}\" } ]"
fi
if [ -n "$image_url" ]; then
  data="${data}, \"image\": [ { \"url\": \"$image_url\", \"uuid\": \"${image_uuid}\", \"checksum\": \"$image_checksum\", \"description\": \"${image_description}\", \"copyright\": \"${image_copyright}\" } ]"
fi
if [ -n "$disasters" ]; then
  data="${data}, \"disaster\": ${disasters}"
fi
if [ -n "$disaster_types" ]; then
  data="${data}, \"disaster_type\": ${disaster_types}"
fi
if [ -n "$themes" ]; then
  data="${data}, \"theme\": ${themes}"
fi
if [ -n "$notify" ]; then
  data="${data}, \"notify\": \"${notify}\""
fi

echo "curl -X PUT ${rw_api_url}/reports/${uuid}?appname=${appname} --header \"X-RW-POST-API-KEY: ${example_post_api_key}\" --header \"X-RW-POST-API-PROVIDER: ${example_post_api_provider}\" --header \"Content-Type: application/json\" --data '{${data}}'"
