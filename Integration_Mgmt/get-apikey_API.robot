*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem



*** Variables ***
${Altius_Hub_Base_Url}      https://nbee96jmfc.execute-api.ap-south-1.amazonaws.com
${TOKEN}   Bearer  eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ1c2VyX25hbWUiOiJrZWVydGhpc2FnYXIuYUBoZXRlcm9kcnVncy5jb20iLCJleHAiOjE3MTQyMDc1Nzl9.ZJqDRlCCQ4lPRiCJPSWCQpuo4xZ4qdpWMXEs_i75Jfo
${INVALID_TOKEN}      QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ1c2VyX25hbWUiOiJrZWVydGhpc2FnYXIuYUBoZXRlcm9kcnVncy5jb20iLCJleHAiOjE3MTQyMDc1Nzl9.ZJqDRlCCQ4lPRiCJPSWCQpuo4xZ4qdpWMXEs_i75Jfo
${EXPIRED_TOKEN}     eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJza191c2VyX2lkIjoxMzksImlhdCI6MTY4ODAyODE1NH0.q8dP5AmAsKwn-b4u6vY80PA95DZi5ZgO55yCOSGYHds "


*** Test Cases ***
case1:integrations_conf/get-apikey API with positive flow
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
     ${params}=   create dictionary      id=1
    ${header}=  create dictionary   Authorization=${TOKEN}    Content-Type=application/json
     ${response}=    get request    post_01   mah/api/integrations_conf/get-key/  headers=${header}    params=${params}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    200
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    true
       should contain   ${res_body}     Data fetched successfully


case7:integrations_conf/get-apikey API (with invalid method name)
      create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
   ${params}=   create dictionary  id=1
    ${header}=  create dictionary   Authorization=${TOKEN}     Content-Type=application/json
     ${response}=  post request    post_01   mah/api/integrations_conf/get-key/:id    headers=${header}    param=${params}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}     Method name is not correct

case8:integrations_conf/get-apikey API Without Token in the header section
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
     ${params}=   create dictionary  id=1
    ${header}=  create dictionary   Authorization=${EMPTY}     Content-Type=application/json
     ${response}=  post request    post_01   mah/api/integrations_conf/get-key/:id    headers=${header}    param=${params}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}

##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Token is required for authentication.

case9:integrations_conf/get-apikey API With invalid Token in the header section
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
     ${params}=   create dictionary  id=1
    ${header}=  create dictionary   Authorization=${INVALID_TOKEN}     Content-Type=application/json
     ${response}=  post request    post_01   mah/api/integrations_conf/get-key/:id    headers=${header}    param=${params}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}

##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Invalid token.

case10:integrations_conf/get-apikey API With Expired Token in the header section
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
      ${params}=   create dictionary  id=1
      ${header}=  create dictionary   Authorization=${EXPIRED_TOKEN}     Content-Type=application/json
        ${response}=  post request    post_01   mah/api/integrations_conf/get-key/:id    headers=${header}    param=${params}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      A Token is Expired