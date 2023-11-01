*** Settings ***
Library   RequestsLibrary
Library   OperatingSystem
Library   Collections


*** Variables ***
${Altius_Hub_Base_Url}   https://nbee96jmfc.execute-api.ap-south-1.amazonaws.com
${FILE_PATH}     C:\Users\Badigi Shilpa-2877\Downloads\Upload.csv
${TOKEN}    Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxLCJ1c2VyX25hbWUiOiJrZWVydGhpc2FnYXIuYUBoZXRlcm9kcnVncy5jb20iLCJleHAiOjE3MTM4NjUzODh9.1AZYH1EYJod9Br6z_pNdv3K0NZ0LtdT3e_1JQK2hPW4





#*** Test Cases ***
#Upload XLSX File Test
#     create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
#      ${multipart}=   get file for streaming upload    csv_file=@${FILE_PATH}
#    ${header}     create dictionary   Authorization=${TOKEN}   Content-Type=multipart
##    ${files}    create dictionary    file_name= @${FILE_PATH}
##    ${response}   post request    ${Altius_Hub_Base_Url}   headers=${header}    file=${files}
#      ${response}=   post request    post_01   /mah/api/principle_database/upload-csv-mah      headers=${header}    data=${multipart}
#    Log To Console    ${response.status_code}
#    Log To Console    ${response.content}
###validations
#   ${status_code}=    convert to string    ${response.status_code}
#       should be equal    ${status_code}    200
#       ${res_body}=    convert to string    ${response.content}
#       should contain   ${res_body}    true
#       should contain   ${res_body}     Processed 2 records



*** Test Cases ***
Upload XLSX File Test
       create session    post_01   ${Altius_Hub_Base_Url}     verify=${TRUE}
     ${headers} =    create dictionary      Authorization=${TOKEN}    Content-Type=multipart/form-data
    ${multipart} =   create dictionary    csv_file=@${FILE_PATH}
    ${data} =        create dictionary     key3=${multipart}
    ${response} =  post request   post_01   /mah/api/principle_database/upload-csv-mah     headers=${headers}    data=${data}
     Log To Console    ${response.status_code}
    Log To Console    ${response.content}
##validations
   ${status_code}=    convert to string    ${response.status_code}
       should be equal    ${status_code}    200
       ${res_body}=    convert to string    ${response.content}
       should contain   ${res_body}    true
       should contain   ${res_body}     Processed 2 records



