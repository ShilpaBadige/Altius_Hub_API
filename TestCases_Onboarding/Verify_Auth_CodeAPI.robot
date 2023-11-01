*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem



*** Variables ***
${Altius_Hub_Base_Url}      https://nbee96jmfc.execute-api.ap-south-1.amazonaws.com
${TOKEN}     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJza191c2VyX2lkIjoxNDIsImlhdCI6MTY4ODAyOTc2M30.NlqGKOpf4fwHCh0Hk1SASDx_rUPFhY9UdnOkaG67M40"

*** Test Cases ***
case1:verify_Auth_Code API with positive flow
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code=985686
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/verify-auth-code      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    200
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    true
       should contain   ${res_body}      Auth code sent successfully.

case2:verify_Auth_Code API with wrong auth code
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code=985686
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/verify-auth-code      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Invalid Auth code provided

case3:verify_Auth_Code API with empty
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code=${EMPTY}
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/verify-auth-code      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Please enter the auth code

case4:verify_Auth_Code API with expired Auth code
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code=985686
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/verify-auth-code      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Auth code is expired

case5:verify_Auth_Code API with only spaces
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code=${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/verify-auth-code      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Auth code is invalid

case6:verify_Auth_Code API with characters
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code=Twothreefour
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/verify-auth-code      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Auth code is invalid


case7:verify_Auth_Code API without Auth_code
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    to json    ${EMPTY}
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/verify-auth-code      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Auth_code field is required

