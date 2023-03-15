Write-Host "Hello!"
Write-Host "This script will: 
1. Copy the Experiment Template folder
2. Rename the files while replacing the placeholders, such as '[bacteria]', with the name you will enter.
`t* Currently the supported placeholders are: [rd], [bacteria], [name], [type], [date]`n`n" -ForegroundColor Green

#Check if theres a folder named "Created Notebooks" and if not, create one
$MainFolderName = "Created Notebooks"
if (Test-Path $MainFolderName) {
   
    Write-Host "'$MainFolderName' folder exists, your folders and files will be created inside."
}
else {
  
    New-Item $MainFolderName -ItemType Directory | Out-Null
    Write-Host "Created a '$MainFolderName' folder, your folders and files will be created inside."
}
Write-Host "`n`n"
#Get the parameters from the user, and check if the folder already exists. If it does, ask the user to enter the information again.
function Get-Params {
    Write-Host "Please enter the following information: " -ForegroundColor Green
    $global:ExpID = Read-Host "Experiment ID to replace '[rd]' `n `tExample: RD123`n"
    $global:Bacteria = Read-Host "Bacteria Name to replace '[bacteria]' `n `tExample: LR`n"
    $global:ExpName = Read-Host "Experiment Name to replace '[name]' `n `tExample: Optimization of media`n"
    $global:Type = Read-Host "Abbreaviation of Experiment Type to replace '[name]' `n `tExample: F - Fermentation, L - Lyophilization, SS - Small Scale`n"
    $global:Date = Read-Host "Experiment Start Date to replace '[date]' `n `tExample: 10.03.23`n"

    
    $global:Folder = $ExpID + ", " + $ExpName + ", " + $Date
    if (Test-Path $MainFolderName\$Folder) {
        Write-Host "Folder with the same name already exists, please enter the information again." -ForegroundColor Red
        Get-Params
    }

}

Get-Params


#Copy the template folder and name it with the parameters
Copy-Item "Notebook Template_SCRIPT_USES_THIS_FOLDER" -Destination $MainFolderName\$Folder -Recurse
cd $MainFolderName\$Folder
$curloc = Get-Location

#Rename the files and folders in the copied folder
#Check if the folder was created
if ($curloc.tostring() -clike "*" + $Folder) {
    #recursive function to rename the files and folders
    get-childitem -recurse | Rename-Item -NewName {
    
        $_.name -replace "\[rd\]", $ExpID -replace "\[bacteria\]", $Bacteria -replace "\[name\]", $ExpName -replace "\[type\]", $Type
    }

    Write-Host "Success! 
    Created the following folders and files:" -ForegroundColor Green
    cd ..
    #Print the tree of the created folder
    Write-Host "$Folder"
    Tree $curloc /F | Select-Object -Skip 3
    #print the path of the created folder
    Write-Host "The used directory: $curloc`n"
    #ask the user if he wants to delete the created folder
    $input = Read-Host -Prompt "Press Enter to exit or write 'Del' to delete the created folder."
    if ($input -eq "Del") {
        Write-Host "Deleting the folder: $curloc" -ForegroundColor Red
        #double check to make sure the user wants to delete the folder
        $input = Read-Host -Prompt "Are you sure you want to delete the folder? (Y/N)"
        if ($input -eq "Y") {
            Remove-Item $curloc -Recurse
            Write-Host "Deleted the folder: $curloc" -ForegroundColor Green
        }
    }
}
else {
    Write-Host "Something Went Wrong" -ForegroundColor Red
    Read-Host -Prompt "Press Enter to exit"
}


