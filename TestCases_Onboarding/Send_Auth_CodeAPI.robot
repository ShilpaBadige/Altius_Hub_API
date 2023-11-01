*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem



*** Variables ***
${Altius_Hub_Base_Url}      https://nbee96jmfc.execute-api.ap-south-1.amazonaws.com
${TOKEN}     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJza191c2VyX2lkIjoxNDIsImlhdCI6MTY4ODAyOTc2M30.NlqGKOpf4fwHCh0Hk1SASDx_rUPFhY9UdnOkaG67M40"

*** Test Cases ***
case1:Send auth code with positive flow
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=keerthisagar.a@heterodrugs.com
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=    post request    post_01   mah/api/principle_database/send-auth-code      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    200
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    true
       should contain   ${res_body}      Auth code sent successfully.

case2:with un registered email id
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=keerthisag.a@heterodrugs.com
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=    post request    post_01   mah/api/principle_database/send-auth-code      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}     un registered emial id/Wrong enail id provided

case3:Send auth code with invalid email id or wrong email id
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=${SPACE}${SPACE}kee${SPACE}${SPACE}rthisa${SPACE}${SPACE}gar.a@heter${SPACE}${SPACE}odrugs.com
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=    post request    post_01   mah/api/principle_database/send-auth-code      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Invalid email id provided

case4:Send auth code without email id
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    to json    ${EMPTY}
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=    post request    post_01   mah/api/principle_database/send-auth-code      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Registered email id is required

case5:Send auth code with empty email id
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=${EMPTY}
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=    post request    post_01   mah/api/principle_database/send-auth-code      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}     please enter the email id

case6:Send auth code with only spaces in email id
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=${SPACE}${SPACE}${SPACE}${SPACE}
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=    post request    post_01   mah/api/principle_database/send-auth-code      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}     Invalid email id

case7:Send auth code without domian in valid email id
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=keerthisagar.aheterodrugs.com
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=    post request    post_01   mah/api/principle_database/send-auth-code      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}     An invalid email id provided


case8:Send auth code with invalid email id
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=ke@heterodrugs.com
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=    post request    post_01   mah/api/principle_database/send-auth-code      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}     An invalid email id provided
