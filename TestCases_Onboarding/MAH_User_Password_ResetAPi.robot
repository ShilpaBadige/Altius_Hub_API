*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem



*** Variables ***
${Altius_Hub_Base_Url}      https://nbee96jmfc.execute-api.ap-south-1.amazonaws.com
${TOKEN}     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJza191c2VyX2lkIjoxNDIsImlhdCI6MTY4ODAyOTc2M30.NlqGKOpf4fwHCh0Hk1SASDx_rUPFhY9UdnOkaG67M40"

*** Test Cases ***
case1:MAH_user_Password_Reset API with positive flow
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= 985686   email=niharjena@gmail.com  new_password=Jena@1234    re_entered_password=Jena@1234
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    200
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    true
       should contain   ${res_body}      Password updated successfully.

 #Auth_code validations
case2:MAH_user_Password_Reset API wrong auth code
      create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= 985686   email=niharjena@gmail.com  new_password=Jena@1234    re_entered_password=Jena@1234
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Wrong Auth_code

case3:MAH_user_Password_Reset API with empty Auth code
      create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= ${EMPTY}   email=niharjena@gmail.com  new_password=Jena@1234    re_entered_password=Jena@1234
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      please enter Auth code

case4:MAH_user_Password_Reset API with with expired Auth code
 create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= 876546   email=niharjena@gmail.com  new_password=Jena@1234    re_entered_password=Jena@1234
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Auth_code is invalid/expired

case5:MAH_user_Password_Reset API with only spaces in Auth code
    create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= ${SPACE}${SPACE} ${SPACE} ${SPACE} ${SPACE}   email=niharjena@gmail.com  new_password=Jena@1234    re_entered_password=Jena@1234
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Auth_code is invalid/expired

case6:MAH_user_Password_Reset API with characters in Auth code
      create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= TwoThreeFour  email=niharjena@gmail.com  new_password=Jena@1234    re_entered_password=Jena@1234
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Auth_code is invalid/expired

case7:MAH_user_Password_Reset API without Auth_code
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary     email=niharjena@gmail.com  new_password=Jena@1234    re_entered_password=Jena@1234
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Auth_code field is required

#Email validations
case8:MAH_user_Password_Reset API with un registered email id
    create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= 985686   email=niharje@gmail.com  new_password=Jena@1234    re_entered_password=Jena@1234
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Email id is invalid/not registered

case9:MAH_user_Password_Reset API with invalid email id or wrong email id
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= 985686   email=${SPACE}${SPACE}kee${SPACE}${SPACE}rthisa${SPACE}${SPACE}gar.a@heter${SPACE}${SPACE}odrugs.com  new_password=Jena@1234    re_entered_password=Jena@1234
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Invalid email id provided

case10:MAH_user_Password_Reset API with invalid email id or wrong email id
    create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= 985686   email=niharjena@gmail.com  new_password=Jena@1234    re_entered_password=Jena@1234
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    200
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    true
       should contain   ${res_body}      Password updated successfully.

case11:MAH_user_Password_Reset API without email id
    create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= 985686     new_password=Jena@1234    re_entered_password=Jena@1234
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Email id field is required

case12:MAH_user_Password_Reset API with empty email id
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= 985686   email=${EMPTY}  new_password=Jena@1234    re_entered_password=Jena@1234
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      please enter  email id

case13:MAH_user_Password_Reset API with only spaces in email id
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= 985686   email=${SPACE}${SPACE}${SPACE}${SPACE}  new_password=Jena@1234    re_entered_password=Jena@1234
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Invalid email id

case14:MAH_user_Password_Reset API without domian in valid enail id
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= 985686   email=niharjenagmail.com  new_password=Jena@1234    re_entered_password=Jena@1234
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    fasle
       should contain   ${res_body}      An invalid email id provided


case15:MAH_user_Password_Reset API with un invalid email id
    create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= 985686   email=n@gmail.com  new_password=Jena@1234    re_entered_password=Jena@1234
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Email id is invalid/not registered

#New_password  and re enter passwordvalidations
case16:MAH_user_Password_Reset API without new password
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= 985686   email=niharjena@gmail.com     re_entered_password=Jena@1234
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      new password filed is required

case17:MAH_user_Password_Reset API without re enter password
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= 985686   email=niharjena@gmail.com  new_password=Jena@1234
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      re_enter_password filed is required

case18:MAH_user_Password_Reset API with new password empty
      create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= 985686   email=niharjena@gmail.com  new_password=${EMPTY}    re_entered_password=Jena@1234
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}     plase eneter the new password

case19:MAH_user_Password_Reset API with re entered password empty
      create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= 985686   email=niharjena@gmail.com  new_password=Jena@1234    re_entered_password=${EMPTY}
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}     plase eneter the re entered password

case20:MAH_user_Password_Reset API with re entered password empty and new password empty
      create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= 985686   email=niharjena@gmail.com  new_password=${EMPTY}    re_entered_password=${EMPTY}
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}     plase neter the passwords

case21:MAH_user_Password_Reset API with mismatching the passwords
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= 985686   email=niharjena@gmail.com  new_password=Nihar@1234567     re_entered_password=Nihar@12345
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Passwords are not matched/password mismatch

case22:MAH_user_Password_Reset API with passwords with only Alphabets
    create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= 985686   email=niharjena@gmail.com  new_password=Nihardsfghjk     re_entered_password=Nihardsfghjk
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Password must contain combination of alphabets,numbers,special char

case23:MAH_user_Password_Reset API with passwords only numbers
       create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= 985686   email=niharjena@gmail.com  new_password=4567812345     re_entered_password=4567812345
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Password must contain combination of alphabets,numbers,special char

case24:MAH_user_Password_Reset API with only spacial characters
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    auth_code= 985686   email=niharjena@gmail.com  new_password=@#$%^&*(    re_entered_password=@#$%^&*(
   ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/reset-password      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
     ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Password must contain combination of alphabets,numbers,special char















