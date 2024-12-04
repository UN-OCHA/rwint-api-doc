#!/bin/sh

# This example based on the currently published IRC job:
# https://careers.rescue.org/us/en/job/req55952/Team-Lead-Health-Activity

# To be used in conjunction with the schema at https://test.reliefweb-int.ahconu.org/post-api-schemas/v2/job.json
# Look there for field descriptions, maximum numbers of options, character counts, etc.

# Configuration for all api calls.
rw_api_url="https://test.api-reliefweb-int.ahconu.org/v2"
appname="TEST-APP-NAME"
rw_api_namespace="8e27a998-c362-5d1f-b152-d474e1d36af2"
example_post_api_key="REPLACE_WITH_YOUR_API_KEY"
example_post_api_provider="REPLACE_WITH_PROVIDER_UUID"
# source_id: 2012 "International Rescue Committee"
source_id="2012"
source_name="International Rescue Committee"

# Taxonomy lookup hints:
# Find a country id: https://api.reliefweb.int/v2/countries?appname=${appname}&query[value]=*
# E.g: https://api.reliefweb.int/v2/countries?appname=${appname}&query[value]=cameroon
# Find a language id: https://api.reliefweb.int/v2/references/languages?appname=${appname}&query[value]=*
# E.g: https://api.reliefweb.int/v2/references/languages?appname=${appname}&query[value]=french


# Configuration for a single job.
# Required fields.

# URL.
job_url="https://careers.rescue.org/us/en/job/req55952/Team-Lead-Health-Activity"

# UUID.
uuid="$(uuidgen --sha1 --namespace ${rw_api_namespace} --name ${job_url})"

# Title.
title="Team Lead - Health Activity"

# Source.
source="[${source_id}]"

# Closing date: 2 Jan 2025
closing_date="2025-01-02T00:00:00+00:00"

# Body.
body="Example short test body. Can include any characters and punctuation. The only control characters allowed are new lines (\\\n) and spaces."
# body="The International Rescue Committee (IRC) responds to the world's worst humanitarian crises, helping to restore health, safety, education, economic wellbeing, and power to people devastated by conflict and disaster. Founded in 1933 at the call of Albert Einstein, the IRC is one of the world's largest international humanitarian non-governmental organizations (INGO), at work in more than 40 countries and 29 U.S. cities helping people to survive, reclaim control of their future and strengthen their communities. A force for humanity, IRC employees deliver lasting impact by restoring safety, dignity and hope to millions. If you're a solutions-driven, passionate change-maker, come join us in positively impacting the lives of millions of people world-wide for a better future.\n\nThe IRC began working in Afghanistan in 1988, launching relief programs for people displaced by the invasion of the Soviet Union. IRC is currently operational across eleven provinces by delivering critical life-saving as well as longer term development and resilience programmes, under the thematic areas of Emergency response, Health and Nutrition, Education, Integrated Protection and Environment Health.\n\n**Scope of work**\n\nThe IRC seeks a Team Lead (TL) for an upcoming FCDO Health activity in Afghanistan called ‘Health and Education in Afghanistan - Response and Transition (HEART)’. The recruitment is for the health component which seeks to improve access to quality and equitable primary healthcare, and reproductive, maternal, newborn and child health services and prevent further deterioration of health outcomes.\n\nThe Team Lead is responsible for overseeing the delivery of program outcomes and interventions and the program's daily operations. This includes direct management of key personnel roles and leadership of the program staff. The Team Lead is responsible for ensuring a strong working relationship with FCDO and the program consortium delivery partners. S/he will ensure appropriate performance management capabilities to deliver the program deliverables and will also be responsible for the program's overall contract and budget management. The Team Lead is expected to have extensive skills in complex project implementation, advocacy, and networking capabilities with government authorities, MOH and international, national institutions and development agencies. Other responsibilities will include supporting project staff by creating and maintaining a work environment that promotes teamwork, trust, and mutual respect and empowers staff to achieve project targets.\n\nThe Recruitment is contingent upon successful award of the programme, and selection of final applicant is subject to FCDO’s approval.\n\n**Responsibilities**\n\n**Key responsibilities**\n\n• Provide strategic and administrative leadership and direction, define and implement activities to achieve the greatest impact toward project goals and objectives.\n\n• Oversee technical direction and project delivery to ensure activities align with the performance framework and meet all standard operational policies and procedures.\n\n• Oversee the development, review, and monitoring of yearly work plans, project strategy documents, implementation measures, knowledge management, and sustainability efforts to achieve long-term and short-term impact goals.\n\n• Manage consortium partnerships and maintain collaborative partner relations, ensuring that all partners are aware of the project’s expectations and are actively involved in achieving the objectives while using the project management tools developed or adapted for the consortium.\n\n• Support the Finance Lead in providing financial and operations support that optimizes resources through sound budgets, consistent financial tracking, and timely submission of reports to the donor.\n\n• Report to FCDO through both formal and informal debriefings, annual and semi-annual reports, ensuring timely submission of high-quality content.\n\n• Maintain active and cooperative relationships with all key stakeholders, including government officials, project partners, other implementing agencies, and related institutions.\n\n• Represent the project and the organization in national, regional, and international fora, including technical conferences and policy briefings, and share information about project achievements and lessons learned within the organization and wider development community.\n\n• Ensure that contract, finance, and grants administration functions are in full compliance with IRC and FCDOs’ compliance requirements and are well supported with effective systems and procedures.\n\n• Lead efforts for overall consortium management, ensuring oversight and support align with partner-specific needs, donor compliance, and implementation plans.\n\n• As the programme’s primary focal point, manage key relationships with all levels of relevant stakeholders as well as required by the aims of the project.\n\n**Team Leader Profile & Qualifications**\n\n• A Master’s degree in the Medical Field, Public Health, International Development, International Relations, or related field.\n\n• A minimum of 10 years of relevant and progressive experience managing high-value, complex, multi-year, multi-partner projects implemented in international development and/or humanitarian settings, including at least 7 years in a senior-level position providing technical assistance and managerial oversight.\n\n• Experience and ability to provide leadership and direction and harness the multi-disciplinary skills of the technical personnel and consortium partners.\n\n• Experience and ability to work with and build effective partnerships between a broad range of stakeholders, including government, civil society, the private sector, multilaterals, and other donors.\n\n• Prior experience in operating effectively within complex and high-risk environments and managing the needs of multiple stakeholders.\n\n• Strong analytical communication and writing skills, with the ability to articulate complex information backed with evidence to promote and persuade influential stakeholders.\n\n• Excellent communication skills, both oral and written.\n\n• Strong interpersonal and communication skills, both oral and written. Knowledge of local languages (Pushto, Darri) a plus.\n\n• Willingness and ability to travel to project sites, including traveling to insecure environments, is required.\n\n• Qualified women and/or national candidates are highly encouraged to apply.\n\n***Please note that the JD is high level and indicative only at this stage and may be subject to change once the Terms of Reference for the programme is released and as the opportunity develops. This position will be contingent on the outcome of the bid.***\n\n**Standard of Professional Conduct:** The IRC and the IRC workers must adhere to the values and principles outlined in the IRC Way – our Code of Conduct. These are Integrity, Service, Accountability, and Equality.\n\n  \n**Commitment to Gender, Equality, Diversity, and Inclusion:** The IRC is committed to creating a diverse, inclusive, respectful, and safe work environment where all persons are treated fairly, with dignity and respect. The IRC expressly prohibits and will not tolerate discrimination, harassment, retaliation, or bullying of the IRC persons in any work setting. We aim to increase the representation of women, people that are from country and communities we serve, and people who identify as races and ethnicities that are under-represented in global power structures."

# How to apply.
how_to_apply="https://careers.rescue.org/us/en/job/req55952/Team-Lead-Health-Activity"

# Job Type
echo "For reference, these are the most common job_types ${source_name} jobs are tagged with:"
echo "https://api.reliefweb.int/v2/jobs?appname=${appname}&facets[0][field]=type&facets[0][filter][field]=source.id&facets[0][filter][value]=${source_id}&facets[0][sort]=count:desc&limit=0"
# job_type_id: 263 Job
job_type="[263]"

# Job Experience.
echo "For reference, these are the most common job_experiences ${source_name} jobs are tagged with:"
echo "https://api.reliefweb.int/v2/jobs?appname=${appname}&facets[0][field]=experience&facets[0][filter][field]=source.id&facets[0][filter][value]=${source_id}&facets[0][sort]=count:desc&limit=0"
# job_experience_id: 261 10+ years
job_experience="[261]"

# Career categories.
echo "For reference, these are the most common career_categories ${source_name} jobs are tagged with:"
echo "https://api.reliefweb.int/v2/jobs?appname=${appname}&facets[0][field]=career_categories&facets[0][filter][field]=source.id&facets[0][filter][value]=${source_id}&facets[0][sort]=count:desc&limit=0"
# career_categories_id: 6867 Program/Project Management
career_categories="[6867]"

# Not mandatory fields - include as much of this information as exists.
echo "For reference, these are the most common countries ${source_name} jobs are tagged with:"
echo "https://api.reliefweb.int/v2/jobs?appname=${appname}&facets[0][field]=country&facets[0][filter][field]=source.id&facets[0][filter][value]=${source_id}&facets[0][sort]=count:desc&limit=0"
# country_id: 13 Afghanistan
countries="[13]"

# city: Kabul
city="Kabul"

echo "For reference, these are the most common themes ${source_name} jobs are tagged with:"
echo "https://api.reliefweb.int/v2/jobs?appname=${appname}&facets[0][field]=theme&facets[0][filter][field]=source.id&facets[0][filter][value]=${source_id}&facets[0][sort]=count:desc&limit=0"
# theme_id: 4595 Health
themes="[4595]"

echo "\n"

data="\"url\": ${job_url}, \"uuid\": ${uuid}, \"title\": ${title}, \"source\": ${source}, \"closing_date\": \"${closing_date}\", \"body\": \"${body}\", \"how_to_apply\": \"${how_to_apply}\", \"job_type\": ${job_type}, \"job_experience\": ${job_experience}, \"career_category\": ${career_categories}"

if [ -n "$countries" ]; then
  data="${data}, \"country\": ${countries}"
fi
if [ -n "$city" ]; then
  data="${data}, \"city\": \"${city}\""
fi
if [ -n "$themes" ]; then
  data="${data}, \"theme\": ${themes}"
fi

echo "curl -X PUT ${rw_api_url}/jobs/${uuid}?appname=${appname} --header \"X-RW-POST-API-KEY: ${example_post_api_key}\" --header \"X-RW-POST-API-PROVIDER: ${example_post_api_provider}\" --header \"Content-Type: application/json\" --data '{${data}}'"
