*** Settings ***
Library    SeleniumLibrary
Library    RequestsLibrary
Library    Collections
Library    OperatingSystem



*** Variables ***
${Altius_Hub_Base_Url}      https://nbee96jmfc.execute-api.ap-south-1.amazonaws.com
${TOKEN}     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJza191c2VyX2lkIjoxNDIsImlhdCI6MTY4ODAyOTc2M30.NlqGKOpf4fwHCh0Hk1SASDx_rUPFhY9UdnOkaG67M40"

*** Test Cases ***
case1:MAH_user_Create API with positive flow(mah_id is optional)
     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=niharjena@gmail.com     username=nihar12    password=NIhar@123      mah_id=1     user_role=location_user
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    200
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    true
       should contain   ${res_body}      User Created.

#Email id validations
case2:MAH_user_Create API with un registered email id
    create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=niharna@gmail.com     username=nihar12    password=NIhar@123      mah_id=1     user_role=location_user
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Invalid Email id/Unregistered email id

case3:MAH_user_Create API with invalid email id or wrong email id
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=${SPACE}${SPACE}kee${SPACE}${SPACE}rthisa${SPACE}${SPACE}gar.a@heter${SPACE}${SPACE}odrugs.com    username=nihar12    password=NIhar@123      mah_id=1     user_role=location_user
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
     ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Invalid email id provided

case4:MAH_user_Create API without email id
    create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary        username=nihar12    password=NIhar@123      mah_id=1     user_role=location_user
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
     ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Registered email id is required

case5:MAH_user_Create API with empty email id
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=${EMPTY}     username=nihar12    password=NIhar@123      mah_id=1     user_role=location_user
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
      ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}     please enter the email id

case6:MAH_user_Create API with only spaces in email id
      create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=${SPACE}${SPACE}${SPACE}${SPACE}     username=nihar12    password=NIhar@123      mah_id=1     user_role=location_user
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
    ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}     Invalid email id

case7:MAH_user_Create API without domian in valid enail id
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=niharjenagmail.com     username=nihar12    password=NIhar@123      mah_id=1     user_role=location_user
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
     ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}     An invalid email id provided
case8:MAH_user_Create APIwith invalid email id
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=ke@heterodrugs.com    username=nihar12    password=NIhar@123      mah_id=1     user_role=location_user
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
     ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}     An invalid email id provided


       #username validations

case1:MAH_user_Create API without username
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=niharjena@gmail.com       password=NIhar@123      mah_id=1     user_role=location_user
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      username field is required

ccase1:MAH_user_Create API with empty username(mah_id is optional)
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=niharjena@gmail.com     username=${EMPTY}    password=NIhar@123      mah_id=1     user_role=location_user
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Please enter the username

case1:MAH_user_Create API with only sapces in username(mah_id is optional)
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=niharjena@gmail.com     username=${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}    password=NIhar@123      mah_id=1     user_role=location_user
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Invalid user name

case1:MAH_user_Create API spaces in between the username(mah_id is optional)
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=niharjena@gmail.com     username=${SPACE}${SPACE}nih${SPACE}${SPACE}ar12${SPACE}${SPACE}    password=NIhar@123      mah_id=1     user_role=location_user
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Invalid user name

case1:MAH_user_Create API with invalid user name(mah_id is optional)
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=niharjena@gmail.com     username=4567%^&fdgh    password=NIhar@123      mah_id=1     user_role=location_user
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Invalid username

case1:MAH_user_Create API with min and max username in username(mah_id is optional)
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=niharjena@gmail.com     username=ni    password=NIhar@123      mah_id=1     user_role=location_user
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      username min char is 3 and max 50 characters

       #password validations

case1:MAH_user_Create API Password fields with empty(mah_id is optional)
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=niharjena@gmail.com     username=nihar12    password=${EMPTY}      mah_id=1     user_role=location_user
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      please enter the password

case1:MAH_user_Create API without password field(mah_id is optional)
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=niharjena@gmail.com     username=nihar12     mah_id=1     user_role=location_user
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      password field is required

case1:MAH_user_Create API only sapces in password field(mah_id is optional)
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=niharjena@gmail.com     username=nihar12    password=${SPACE}${SPACE}${SPACE}${SPACE}${SPACE}     mah_id=1     user_role=location_user
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Invalid password

case1:MAH_user_Create API with invalid password(mah_id is optional)
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=niharjena@gmail.com     username=nihar12    password=Ihar@123      mah_id=1     user_role=location_user
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      password is invalid

case1:MAH_user_Create API without password field(mah_id is optional)
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=niharjena@gmail.com     username=nihar12      mah_id=1     user_role=location_user
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      password field is required


       #user_role validations
case1:MAH_user_Create API without user_role(mah_id is optional)
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=niharjena@gmail.com     username=nihar12    password=NIhar@123      mah_id=1
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      User_role field is required

case1:MAH_user_Create API with empty user_role(mah_id is optional)
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=niharjena@gmail.com     username=nihar12    password=NIhar@123      mah_id=1     user_role=${EMPTY}
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      please entre the user_role

case1:MAH_user_Create API with only spaces in user_role(mah_id is optional)
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=niharjena@gmail.com     username=nihar12    password=NIhar@123      mah_id=1     user_role=${SPACE}${SPACE}${SPACE}${SPACE}
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Invalid user_role

case1:MAH_user_Create API with spaces in between the user_role(mah_id is optional)
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=niharjena@gmail.com     username=nihar12    password=NIhar@123      mah_id=1     user_role=${SPACE}${SPACE}locat${SPACE}${SPACE}ion_use${SPACE}${SPACE}r
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Invalid user_role

case1:MAH_user_Create API with invalid user role(mah_id is optional)
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=niharjena@gmail.com     username=nihar12    password=NIhar@123      mah_id=1     user_role=lo
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      user role min 5 and max character is 100

case1:MAH_user_Create API with with spacialc char in user role(mah_id is optional)
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=niharjena@gmail.com     username=nihar12    password=NIhar@123      mah_id=1     user_role=@#$%^&$#%
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Invalid user role

case1:MAH_user_Create API user role with only numbers(mah_id is optional)
     create session    post_01   ${Popial_Base_Url}     verify=${TRUE}
    ${body}=   create dictionary    email=niharjena@gmail.com     username=nihar12    password=NIhar@123      mah_id=1     user_role=234567890
    ${header}=  create dictionary    Content-Type=application/json
     ${response}=   post request    post_01   mah/api/principle_database/mah-user-create      data=${body}     headers=${header}
    Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
  ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    400
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    false
       should contain   ${res_body}      Invalid user role

