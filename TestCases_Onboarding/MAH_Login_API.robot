*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem



*** Variables ***
${Altius_Hub_Base_Url}      https://nbee96jmfc.execute-api.ap-south-1.amazonaws.com
${TOKEN}     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJza191c2VyX2lkIjoxNDIsImlhdCI6MTY4ODAyOTc2M30.NlqGKOpf4fwHCh0Hk1SASDx_rUPFhY9UdnOkaG67M40"

*** Test Cases ***
case1:Sign with positive flow
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    username=keerthisagar.a@heterodrugs.com  password=Altius@123
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   /mah/api/principle_database/mah-login      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    200
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    true
       should contain   ${res_body}      Login in Successfully

case2:Sign with positive flow(with invalid method name)
     Create Session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    username=keerthisagar.a@heterodrugs.com  password=Altius@123
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   get request    post_01   /mah/api/principle_database/mah-login      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    405
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    detail
       should contain   ${res_body}     Method \\"GET\\" not allowed.

case3:Without Email parameter
     Create Session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    password=Altius@123
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   /mah/api/principle_database/mah-login      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Please enter the email field.

Case4:Without password parameter
     Create Session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    username=keerthisagar.a@heterodrugs.com
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   /mah/api/principle_database/mah-login      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      "\\"password\\" is required"

case5:Email with Empty field
     Create Session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    username=${EMPTY}  password=Altius@123
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   /mah/api/principle_database/mah-login     data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Please enter an email ID.

case6:Password fields with empty
     Create Session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    username=keerthisagar.a@heterodrugs.com  password=${EMPTY}
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   /mah/api/principle_database/mah-login      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Password is required

case7:Email with only numbers
     Create Session    post_01   ${Popial_Base_Url}     verify=${TRUE}
         ${body}=   create dictionary    username=32456789@terralogic.com  password=Altius@123
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   /mah/api/principle_database/mah-login     data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      email Pattern is missing

case8:Email with single character
     Create Session    post_01   ${Popial_Base_Url}     verify=${TRUE}
      ${body}=   create dictionary    username=k@heterodrugs.com  password=Altius@123
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   /mah/api/principle_database/mah-login     data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      email Pattern is missing

case9:Domain validations in Email field
     Create Session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    username=keerthisagar.aheterodrugs.com  password=Altius@123
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   /mah/api/principle_database/mah-login      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      email Pattern is missing

case10:with old password after resetting
     Create Session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    username=keerthisagar.a@heterodrugs.com  password=Altius@123
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   /mah/api/principle_database/mah-login      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}     The entered password is incorrect

case11:Space between the email_id
     Create Session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    username=keer${SPACE}${SPACE}thisagar.a@het${SPACE}${SPACE}erodrugs.com  password=Altius@123
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   /mah/api/principle_database/mah-login     data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      please provide correct email.


case12:Email field with special char
     Create Session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    username=@#$%^&*(*&@@heterodrugs.com  password=Altius@123
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   /mah/api/principle_database/mah-login      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      please provide correct email.

case13:Email id should not be a case sensitive
     Create Session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    USERNAME=KEERTHISAGAR.A@HETERODRUGS.COM PASSWORD=Altius@123
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   /mah/api/principle_database/mah-login     data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    200
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    true
       should contain   ${res_body}      Sign in Succesfull!

case14:With unregistered credentials(Email and password)
     Create Session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=shilpa.badigi12@terralogic.com  password=Intyent!01
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   /mah/api/principle_database/mah-login      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    401
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      User does not exist

