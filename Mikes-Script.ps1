 #Version 1 base version orginal 2 functions 
 try
   {
        function Import_Users
        {
            Import-Module ActiveDirectory #I Assume it takes functions from the ActiveDirectiry feature 
            $Return_Flag = "False"
            Try
            {
            $Path = Read-Host -Prompt "Enter import user file path (csv)"  -ErrorAction stop

            #Stores the csv file data in a variable so we can parse through it 
            $UserFile = Import-Csv $Path 
            }
            Catch
            {
                Write-Host "Invalid file path " -ForegroundColor Red
                Write-Host $Error.ScriptStackTrace

            }
            #Loop through line by line in the user csv file
            try
            {
                foreach ( $Line in $UserFile) 
                {
                    $Username = $Line.SamAccountName #  SamAccountName per line in file placed in variable 

                    if (Get-ADUser -F {SamAccountName -eq $Username} )  #Search if generated user is already in Active Directory
                    {
                        Write-Warning "$Username already exist Bro. Guess you screwed up ha."
                        $Return_Flag = "False"
                    }
                    else 
                    {
                        $UserCreated_Instance = @{
                    SamAccountName = $Line.SamAccountName
                    AccountPassword = (ConvertTo-SecureString $Line.password -AsPlainText -Force)
                    GivenName =$Line.GivenName
                    Surname = $Line.Surname
                    Name = $Line.Name
                    DisplayName = $Line.DisplayName 
                    UserPrincipalName = $Line.UserPrincipalName
                    Department = $Line.Department
                    Description = $Line.Description
                    Office = $Line.Office
                    OfficePhone = $Line.OfficePhone
                    }           #end of hash user instance/object creation   
                    New-ADUser @UserCreated_Instance
                    $Return_Flag = "True"
                     #An account is created on a line per line basis
                    }

                }
 
            }
            Catch 
            {
                Write-Host "User generation failed" -ForegroundColor Red
                $Error.Exception.Message
            }
            if ($Return_Flag -eq "True")
            {
              return Write-Host "User generation success"
            }
            elseif ($Return_Flag -eq "False")
            {
                return Write-Host "User generation failure" 
            }
        }
}
Catch 
{
        Write-Host "Import function could not be called" -ForegroundColor Red #Additional check for if the function could be called 
        $Error.Exception.Message 
}
try 
{
    function Optimizer 
    {
        $Return_Message = "False" # This variable determines the return output for this function 
        try 
        { #Takes user input 
            $User_Second_Choice = Read-Host "
            Enter which action you which to use (CaseSensitive)
            1:Analyze 
            2:Defrag
            3:Retrim 
            4:SlabConsolidate
            5:Cleanmgr  
            Enter here:"
            $Return_Message = "True"
            # Optimize-Volume C User_Second_Choice -Verbose This produced caused the command to not recongize the -Analyze input    
            try # Maybe convert $Userchoice into an object would prevent the error 
            {
                if($User_Second_Choice -eq "Analyze" -or $User_Second_Choice -eq "1") #Simple check on user input on which command to use 
                {
                    Optimize-Volume C -Analyze -Verbose
                }
                elseif($User_Second_Choice -eq "Defrag" -or $User_Second_Choice -eq "2")
                {
                    Optimize-Volume C -Defrag -Verbose
                }
                elseif($User_Second_Choice -eq "Retrim" -or $User_Second_Choice -eq "3")
                {
                    Optimize-Volume C -Retrim -Verbose
                }
                elseif($User_Second_Choice -eq "SlabConsolidate" -or $User_Second_Choice -eq "4")
                {
                    Optimize-Volume C -SlabConsolidate -Verbose
                }
                elseif($User_Second_Choice -eq "Cleanmgr" -or $User_Second_Choice -eq "5")
                {
                    Start-Process -FilePath "c:\windows\SYSTEM32\cleanmgr.exe " -ArgumentList "/Sageset:1 /Sagerun:1"
                }
                else 
                {
                    Write-Host "Invaild input "
                    $Return_Message = "False"
                }
            }
            catch 
                {
                 $Error.Exception.Message
                }
        }
        catch
        {
            "Use 'Analyze','Defrag','Retrim','SlabConsolidate'and 'Cleanmgr' when selecting functions "
             $Error.Exception.Message
        }


    if ($Return_Message -eq "False")
       {
         return Write-Host "Optimizer Failure" 
       }
    elseif ($Return_Message -eq "True")
       {
         return Write-Host "Optimizer Success"
       }

    }
}
catch 
{
    Write-Host "Optimizer failure"
    $Error.Exeception.Message 

}




#Functions had to be above this code so it has already been executed for this to call it 
for ($index = 0; $index -le 5; $index++)
{
try 
{ #Write-Host "Invalid file path "
        try #For easier testing C:\Users\Administrator\Desktop\Powershell\My-Powershell-Script\New_Test.csv
        {
            $User_Choice = Read-Host "
            Enter which function you want to use 
            1:Import Users
            2:Optimizer
            3:Quit
            Enter here:"

            if($User_Choice -eq "Import Users" -or $User_Choice -eq "import users" -or $User_Choice -eq "import user" -or $User_Choice -eq "Import User" -or $User_Choice -eq "1")
            {
                Import_Users # Calls the import users function
            }
            if($User_Choice -eq "Quit" -or $User_Choice -eq "quit" -or $User_Choice -eq "q" -or $User_Choice -eq "3")
            {
                clear
                exit # Exits the programs 
            }
            if( $User_Choice -eq "Optimizer" -or $User_Choice -eq "optimizer" -or $User_Choice -eq "2")
            {
                Optimizer
            }
            else
            {
                Write-Host "Invalid input please type 'Import Users' or 'PC Optimzation'"
    
            }
        }
        catch 
        {
            Write-Host "Unkwown error"
            $Error.Exception.Message

        } 
}
Catch #Checking for another error  
{
    Write-Host "Error with user UI please check spelling or file paths for import users"
    $Error.Exception.Message
}
}

try
{
    function PC_Optimzation 
    {
    
    }


}
Catch 
{

}
