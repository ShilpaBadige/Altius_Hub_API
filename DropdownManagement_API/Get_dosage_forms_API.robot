*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem



*** Variables ***
${Altius_Hub_Base_Url}      https://nbee96jmfc.execute-api.ap-south-1.amazonaws.com

*** Test Cases ***
case1:dosage-forms API with positive flow
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
#   ${body}=   create dictionary   to json    ${EMPTY}
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=  get request    post_01   /mah/api/principle_database/dosage-forms     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    200
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    true
       should contain   ${res_body}     Data fetched successfully