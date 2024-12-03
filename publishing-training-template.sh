#!/bin/sh

# Configuration for all api calls.
rw_api_url="https://test.api-reliefweb-int.ahconu.org/v2"
appname="TEST-APP-NAME"
rw_api_namespace="8e27a998-c362-5d1f-b152-d474e1d36af2"
example_post_api_key="yourApiKey"
example_post_api_provider="yourProviderUUID"
# source_id: 1817 "UN System Staff College"
source_id="1817"
source_name="UN System Staff College"

# To be used in conjunction with the schema at https://test.reliefweb-int.ahconu.org/post-api-schemas/v2/training.json
# Look there for field descriptions, maximum numbers of options, character counts, etc.

# Taxonomy lookup hints:
# Find a country id: https://api.reliefweb.int/v1/countries?appname=${appname}&query[value]=*
# E.g: https://api.reliefweb.int/v1/countries?appname=${appname}&query[value]=cameroon
# Find a language id: https://api.reliefweb.int/v1/references/languages?appname=${appname}&query[value]=*
# E.g: https://api.reliefweb.int/v1/references/languages?appname=${appname}&query[value]=french


# Configuration for a single training.
# Required fields.

# URL.
training_url="https://reliefweb.int/training/4048520/e-learning-path-data-analytics"

# UUID.
uuid="$(uuidgen --sha1 --namespace ${rw_api_namespace} --name ${training_url})"

# Title.
title="E-learning Path on Data Analytics"

# Source.
source="[${source_id}]"

# Format.
echo "For reference, these are the most common formats ${source_name} trainings are tagged with:"
echo "https://api.reliefweb.int/v1/reports?appname=${appname}&facets[0][field]=format&facets[0][filter][field]=source.id&facets[0][filter][value]=${source_id}&facets[0][sort]=count:desc&limit=0"
# format_id: 4607 online
formats="[4607]"

# Event URL.
event_url="https://www.unssc.org/courses/e-learning-path-data-analytics-0"

# Cost.
cost="fee-based"

# Category.
echo "For reference, these are the most common categories ${source_name} trainings are tagged with:"
echo "https://api.reliefweb.int/v1/jobs?appname=${appname}&facets[0][field]=type&facets[0][filter][field]=source.id&facets[0][filter][value]=${source_id}&facets[0][sort]=count:desc&limit=0"
# category_id: 4609 Training/Workshop
category="[4609]"

# Training language.
echo "For reference, these are the most common training_languages ${source_name} trainings are tagged with:"
echo "https://api.reliefweb.int/v1/training?appname=${appname}&facets[0][field]=training_language&facets[0][filter][field]=source.id&facets[0][filter][value]=${source_id}&facets[0][sort]=count:desc&limit=0"
# training_language_id: 267 English
training_languages="[267]"

# Languages.
echo "For reference, these are the most common languages ${source_name} trainings are tagged with:"
echo "https://api.reliefweb.int/v1/reports?appname=${appname}&facets[0][field]=language&facets[0][filter][field]=source.id&facets[0][filter][value]=${source_id}&facets[0][sort]=count:desc&limit=0"
# language_id: 267 English
languages="[267]"

# Body.
body="Example short test body. Can include any characters and punctuation. The only control characters allowed are new lines (\\\n) and spaces."
# body="Interested in using data effectively? The e-learning path on Data Analytics is designed to enhance your ability to analyse, visualize, report and communicate data effectively. Participants will complete modules and activities at their own pace. They will participate in engaging online forums and interact with faculty and peers.\n\n**Introduction**\n\nThe Secretary-General's Data Strategy highlights the need to start with "data action that adds immediate value for our organization and the people we serve". This programme is designed to enhance the ability of UN personnel to effectively apply and use data in their work. It is geared to those in research, analytics and reporting, as well as those who wish to expand their knowledge and ability to access, use, interpret and communicate data.\n\n**Objectives**\n\nUpon successful completion of the programme, participants will be able to:\n\n- Explain the different types of analytics and their applications in the UN context.\n- Implement a scoped data analysis of their needs for information.\n- Use data visualization and storytelling techniques to communicate key messages.\n- Identify applications of predictive analytics at their workplace.\n- Describe key features of predictive models, understanding risks and how to ensure an ethical use.\n\n**Course methodology**\n\nIt is a self-paced learning path delivered entirely online. Participants can start at any time and complete modules and activities at their own pace.\n\nThe e-learning path on Data Analytics offers:\n\n- A micro-learning experience characterized by small knowledge units (modules and micro-lessons) where participants consolidate and reflect on learnings through the creation of micro-content (multimodal forum replies, etc.).\n- Scenario-based learning exposing participants to unique real-life challenges and tasks of UN managers\n- Consolidation of takeaways through reflective practices and social learning to facilitate information exchange and peer-to-peer learning\n- Unlimited access to all modules for six months from the date of enrolment.\n- A large collection of relevant tools, readings, guidelines and examples that complement the concepts and theories covered in the course.\n\nParticipants will be granted unlimited access to the learning path for six months from the date of enrolment. UNSSC's dedicated e-learning platform tracks completion of individual modules. A final certificate will be given to participants upon completion of all modules in the learning path.\n\nEach module is estimated to require approximately three hours of study time to complete at your own pace.\n\nThis learning path forms part of the UNSSC Blueline learning platform. Subject to completion of this learning path, interested participants can sign up and access other E-Learning Paths in Blueline.\n\nThis learning path is also accessible through the UNKampus 30 platform for non-UN staff.\n\nPlease contact elp@unssc.org for further information.\n\n**Course contents**\n\nThe e-learning path on Data Analytics includes the following modules:\n\n- Data fundamentals\n- Data science project\n- Data exploration and analysis\n- Data visualization- Part 1\n- Data visualization- Part 2\n- Data storytelling\n- Data for decision making\n- Fundamentals of predictive analytics\n- The science of predictive analytics\n- Applying predictive analytics\n\nThe programme is delivered through UNSSC's Blueline e-learning platform. By completing the learning path, participants will have access to an exclusive alumni network for continuous learning and exchange.\n\n**Target audience**\n\nAll UN personnel (professional and general service staff) at headquarters and field locations.\n\nUNFPA personnel can gain free access to this path as part of their corporate subscription to the Blue Line by registering [HERE](https://www.unssc.org/courses/unfpa-corporate-subscription-extended-e-certificate-lm-e-learning-path-data-analytics-0).\n\nUN Secretariat personnel can gain free access to this path as part of their corporate subscription to the Blue Line by registering [HERE](https://www.unssc.org/courses/un-secretariat-corporate-subscription-extended-e-certificate-lm-blue-line)."

# How to register.
how_to_register="Interested participants can register here: [https://www.unssc.org/courses/e-learning-path-data-analytics-0](https://www.unssc.org/courses/e-learning-path-data-analytics-0)"


# Not mandatory fields - include as much of this information as exists.
# Country.
echo "For reference, these are the most common countries ${source_name} trainings are tagged with:"
echo "https://api.reliefweb.int/v1/jobs?appname=${appname}&facets[0][field]=country&facets[0][filter][field]=source.id&facets[0][filter][value]=${source_id}&facets[0][sort]=count:desc&limit=0"
# country_id: n/a
# countries="[]"

# City.
city=""

# Dates.
# Date, if appropriate, in the ISO 8601 format e.g."2024-11-21:00:00+00:00"
# Start: 21 March 2024
# End: 31 December 2024
# Registration_deadline: 31 December 2024
start_date="2024-03-21:00:00+00:00"
end_date="2024-12-31:00:00+00:00"
registration_deadline="2024-12-31:00:00+00:00"

# Fee information.
fee_information="The course fee is \$1,000, and covers full participation in the online course."

# Professional function.
echo "For reference, these are the most common functions ${source_name} trainings are tagged with:"
echo "https://api.reliefweb.int/v1/jobs?appname=${appname}&facets[0][field]=career_categories&facets[0][filter][field]=source.id&facets[0][filter][value]=${source_id}&facets[0][sort]=count:desc&limit=0"
# professional_function: 20971 Information management
professional_function="[20971]"

# Themes.
echo "For reference, these are the most common themes ${source_name} reports are tagged with:"
echo "https://api.reliefweb.int/v1/reports?appname=${appname}&facets[0][field]=theme&facets[0][filter][field]=source.id&facets[0][filter][value]=${source_id}&facets[0][sort]=count:desc&limit=0"
# theme_id: n/a
# themes="[]"

echo "\n"

data="\"url\": ${training_url}, \"uuid\": ${uuid}, \"title\": ${title}, \"source\": ${source}, \"format\": ${formats}, \"event_url\": \"${event_url}\", \"cost\": \"${cost}\", \"category\": ${category}, \"training_language\": ${training_languages}, \"language\": ${languages}, \"body\": \"${body}\", \"how_to_register\": \"${how_to_register}\""

if [ -n "$countries" ]; then
  data="${data}, \"country\": ${countries}"
fi
if [ -n "$city" ]; then
  data="${data}, \"city\": \"${city}\""
fi
if [ -n "$start_date" ]; then
  data="${data}, \"dates\": [ { \"start\": \"${start_date}\", \"end\": \"${end_date}\", \"registration_deadline\": \"${registration_deadline}\"} ]"
fi
if [ -n "$fee_information" ]; then
  data="${data}, \"fee_information\": \"${fee_information}\""
fi
if [ -n "$professional_function" ]; then
  data="${data}, \"professional_function\": ${professional_function}"
fi
if [ -n "$themes" ]; then
  data="${data}, \"theme\": ${themes}"
fi

echo "curl -X PUT ${rw_api_url}/training/${uuid}?appname=${appname} --header \"X-RW-POST-API-KEY: ${example_post_api_key}\" --header \"X-RW-POST-API-PROVIDER: ${example_post_api_provider}\" --header \"Content-Type: application/json\" --data '{${data}}'"
