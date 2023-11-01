*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem



*** Variables ***
${Altius_Hub_Base_Url}     https://nbee96jmfc.execute-api.ap-south-1.amazonaws.com
${TOKEN}     " eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ1c2VyX25hbWUiOiJrZWVydGhpc2FnYXIuYUBoZXRlcm9kcnVncy5jb20iLCJleHAiOjE3MTM4NjUzODh9.1AZYH1EYJod9Br6z_pNdv3K0NZ0LtdT3e_1JQK2hPW4 "
${INAVALID TOKEN}     " JhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJza191c2VyX2lkIjoxNDMsImlhdCI6MTY4ODAzMzQwN30.QYol-trzGD8gfVJsuOL11SuMZfikUL_pmA9eh9Y9kYQ "
${EXPIRED TOKEN}     " eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJza191c2VyX2lkIjoxMzksImlhdCI6MTY4ODAyODE1NH0.q8dP5AmAsKwn-b4u6vY80PA95DZi5ZgO55yCOSGYHds "

*** Test Cases ***
case1:ResetPassword API with positive flow
     Create Session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary   new_password=Nihar@12345     re_entered_password=Nihar@12345

   ${header}=     create dictionary    Authorization=${TOKEN}    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/change-password     data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    200
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    true
       should contain   ${res_body}      Password updated successfully.

case2:ResetPassword API without new password
    Create Session    post_01   ${Altius_Hub_Base_Url}    verify=${TRUE}
     ${body}=   create dictionary        re_entered_password=Nihar@12345
    ${header}=     create dictionary    Authorization=${TOKEN}    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/change-password    data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      new password filed is required

case3:ResetPassword API without re enter password
     Create Session    post_01  ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary   new_password=Nihar@12345

   ${header}=     create dictionary    Authorization=${TOKEN}    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/change-password     data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      re_enter_password filed is required

case4:ResetPassword API with new password empty
     Create Session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary   new_password=${EMPTY}    re_entered_password=Nihar@12345

   ${header}=     create dictionary    Authorization=${TOKEN}    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/change-password    data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}     plase eneter the new password

case5:ResetPassword API with re entered password empty
     Create Session    post_01   ${Altius_Hub_Base_Url}    verify=${TRUE}
    ${body}=   create dictionary   new_password=Nihar@12345    re_entered_password=${EMPTY}

   ${header}=     create dictionary    Authorization=${TOKEN}    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/change-password     data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}     plase neter the re entered password

case6:ResetPassword API with re entered password empty and new password empty
     Create Session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary   new_password=${EMPTY}    re_entered_password=${EMPTY}

   ${header}=     create dictionary    Authorization=${TOKEN}    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/change-password    data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}     plase neter the passwords

case7:ResetPassword API with mismatching the passwords
     Create Session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary   new_password=Nihar@1234567     re_entered_password=Nihar@12345

   ${header}=     create dictionary    Authorization=${TOKEN}    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/change-password    data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Passwords are not matched/password mismatch

case8:ResetPassword API with passwords with only Alphabets
     Create Session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary   new_password=Nihardsfghjk     re_entered_password=Nihardsfghjk

   ${header}=     create dictionary    Authorization=${TOKEN}    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/change-password     data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
    ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Password must contain combination of alphabets,numbers,special char

case9:ResetPassword API with passwords only numbers
     Create Session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary   new_password=4567812345     re_entered_password=4567812345

   ${header}=     create dictionary    Authorization=${TOKEN}    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/change-password     data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
#validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Password must contain combination of alphabets,numbers,special char

case10:ResetPassword API with only spacial characters
     Create Session    post_01    ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary   new_password=@#$%^&*(    re_entered_password=@#$%^&*(

   ${header}=     create dictionary    Authorization=${TOKEN}    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/change-password     data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Password must contain combination of alphabets,numbers,special char

case12:Without Token in the header section
     Create Session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary   new_password=Nihar@12345     re_entered_password=Nihar@12345
   ${header}=  create dictionary    Authorization=${EMPTY}     Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/change-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      A token is required for authentication

case13:With invalid Token in the header section
     Create Session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary   new_password=Nihar@12345     re_entered_password=Nihar@12345
    ${header}=     create dictionary    Authorization=${INAVALID_Token}    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/change-password     data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}

##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Invalid token

case14:With Expired Token in the header section
     Create Session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary   new_password=Nihar@12345     re_entered_password=Nihar@12345

   ${header}=     create dictionary    Authorization=${EXPIRED_TOKEN}    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/change-password    data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}

##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      A Token is Expired

