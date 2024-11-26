#!/bin/sh

# Find a country id: https://api.reliefweb.int/v1/countries?appname=REPLACE-WITH-A-DOMAIN-OR-APP-NAME&query[value]=*
# E.g: https://api.reliefweb.int/v1/countries?appname=REPLACE-WITH-A-DOMAIN-OR-APP-NAME&query[value]=cameroon
# Find a language id: https://api.reliefweb.int/v1/references/languages?appname=REPLACE-WITH-A-DOMAIN-OR-APP-NAME&query[value]=*
# E.g: https://api.reliefweb.int/v1/references/languages?appname=REPLACE-WITH-A-DOMAIN-OR-APP-NAME&query[value]=french

rw_api_url="https://rwint-api-local.test/v2"
appname="TEST-APP-NAME"
rw_api_namespace="8e27a998-c362-5d1f-b152-d474e1d36af2"
example_post_api_key="yourApiKey"
example_post_api_provider="yourProviderUUID"
# Directory where files live
file_path="/home/andy/Desktop"

# Required fields.
report_url="https://www.unocha.org/news/todays-top-news-occupied-palestinian-territory-lebanon-cuba"
uuid="$(uuidgen --sha1 --namespace ${rw_api_namespace} --name ${report_url})"
title="Ethiopia Food Security Outlook Update: Dry conditions in south/southeast threaten pastoral livelihoods once again, October 2024 - June 2025"
# source_id: 529 "Famine Early Warning System Network"
sources="[529]"
# country_id: 87 Ethiopia
countries="[87]"
# format_id: 3 Analysis
formats="[3]"
# language_id: 267 English
languages="[267]"
# Published: 21 Nov 2024
published="2024-11-21:00:00+00:00"
body="short test body"
# body="Key Messages\n\nEmergency (IPC Phase 4) outcomes will likely persist through at least May in pastoral areas of Zone 2 and Zone 4 of Afar that were severely impacted by the 2020-2022 conflict in northern Ethiopia. In these areas, the conflict severely eroded livestock holdings (the primary household asset). Currently, poor households have minimal to no livestock, resulting in constrained food and income and atypically high reliance on social support and coping strategies, such as selling firewood and charcoal, labor migration, migrating to live with relatives, and consumption of wild foods.\nIn the pastoral south and southeast, Crisis (IPC Phase 3) outcomes are expected, but there is potential for rapid deterioration if the current and subsequent rainy seasons fail. The October to December deyr/hageya rains performed poorly in October, and it is increasingly likely that recovery of livestock holdings from the historic 2020-2023 drought will stagnate due todiminishing pasture and water resources.Declines in livestock productivity will in turn suppress household capacity to purchase sufficient food. Furthermore, the gu/genna rains in early 2025 are also expected to be below average. If both rainy seasons were to fail, food assistance needs would rise sharply and Emergency (IPC Phase 4) outcomes would likely emerge by mid-2025.\nAcross the rest of Ethiopia, the near-average national meher harvest and favorable consecutive livestock production seasons are resulting in moderate improvements in acute food insecurity outcomes.While staple food prices are not expected to decline with the meher harvest, cash income from a rebound in agricultural labor opportunities should partially improve household purchasing power. However, Crisis (IPC Phase 3) outcomes persist in areas where recovery from drought and conflict is prolonged.\nCrisis (IPC Phase 3) outcomes are expected to become more widespread in early to mid-2025 as households gradually exhaust their harvested food stocks and become increasingly market reliant amid high food prices. In hard-to-reach areas of Tigray where market and income-earning activity is highly limited, Emergency (IPC Phase 4) outcomes are expected in early 2025.\n\nThe analysis in this report is based on information available as of October 30, 2024."

# Not mandatory fields - include as much of this information as exists.
origin="https://fews.net/east-africa/ethiopia/food-security-outlook/october-2024"
# (The pdf is generated on demand at https://fews.net/node/35258/print/download, I've invented a url and filename)
file_url="https://fews.net/files/35258.pdf"
file_uuid=$(uuidgen --sha1 --namespace $uuid --name "${file_url}")
file_filename="Ethiopia_Food_Security_Outlook_Update-October_2024-June_2025.pdf"
file_checksum=$(sha256sum "${file_path}/${file_filename}" | cut -f 1 -d " ")
file_language="en"
# No image.
image_url=""
if [ -n "$image_url" ]; then
  image_uuid=$(uuidgen --sha1 --namespace $uuid --name "${image_url}")
  image_checksum=$(curl -s $image_url | sha256sum | cut -f 1 -d " ")
fi
image_description=""
image_copyright=""
# disaster_id: 23121 Ethiopia: Drought - 2015-2024
# disaster_id: 52004 Ethiopia: Floods - May 2024
disasters="[23121, 52004]"
# disaster_type_id: 4672 Drought
# disaster_type_id: 4611 Flood
disaster_types="[4672, 4611]"
# theme_id: 4587 Agriculture
# theme_id: 4593 Food and Nutrition
themes="[4587, 4593]"
# notify: test@example.com
notify="test@example.com"

data="\"url\": ${report_url}, \"uuid\": ${uuid}, \"title\": ${title}, \"source\": ${sources}, \"country\": ${countries}, \"format\": ${formats}, \"language\": ${languages}, \"published\": ${published}, \"body\": ${body}"
if [ -n "$file_url" ]; then
  data="$data, \"file\": [ { \"url\": $file_url, \"uuid\": ${file_uuid}, \"filename\"${file_filename}, \"checksum\": $file_checksum, \"file_language\": ${file_language:-en} } ]"
fi
if [ -n "$image" ]; then
  data="$data, \"image\": [ { \"url\": $image_url, \"uuid\": ${image_uuid}, \"checksum\": $image_checksum, \"description\"${image_description}, \"copyright\": ${image_copyright} } ]"
fi
if [ -n "$disasters" ]; then
  data="$data, \"disaster\": ${disasters}"
fi
if [ -n "$disaster_types" ]; then
  data="$data, \"disaster_type\": ${disaster_types}"
fi
if [ -n "$themes" ]; then
  data="$data, \"theme\": ${themes}"
fi
if [ -n "$notify" ]; then
  data="$data, \"notify\": ${notify}"
fi

echo "curl -k -X PUT ${rw_api_url}/reports/${uuid}?appname=${appname} --header \"X-RW-POST-API-KEY: ${example_post_api_key}\" --header \"X-RW-POST-API-PROVIDER: ${example_post_api_provider}\" --header \"Content-Type: application/json\" --data \"{${data}}\""
