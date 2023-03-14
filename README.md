# Powershell
Michael's PowerShell projects -  New_Test.csv \
Is a test user you can upload to your manager server to prove that the code works.However AD [Path] will need to be changed as it references ADUser.Mike.local and mike.local is where the domain goes. \
Example \
Destination - ADUser.mike.local \
Path - "OU=ADUser,DC=mike,DC=local"

Mikes_Script
Tested versions: Windows-Server (2019 64bit) \
Allows the user to choose between Optimizing the hardrive and uploading a user onto AD server. This is done through an csv file there isnt a way to directly upload a user straight from the commandline without a use of a .csv file. 

Note - Has been tested to work without admin privilages however permissions may change depending on local group policy. 
 
