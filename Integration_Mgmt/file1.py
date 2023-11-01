import requests

url = "https://nbee96jmfc.execute-api.ap-south-1.amazonaws.com"
files = {"file": ("file_name.csv", open("C:\Users\Badigi Shilpa-2877\Downloads\12005-19802-1-SM.pdf", "rb"))}

response = requests.post(url, files=files)
