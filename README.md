# Rename Placeholders In All Subfolders

The user is asked to enter values that will replace placeholders such as [rd], [bacteria], [name], [type], [date]

The script uses a folder named "Notebook Template_SCRIPT_USES_THIS_FOLDER" (should be located in the same folder as the script)
and renames all the placeholders in the file names with the entered values. 


A new folder will be created inside 'Created Notebooks'. The name of the new folder will be a combination of [rd], [name], [date]

# Usage
* Download the ps1 file
* In the same directory, create your template folder 'Notebook Template_SCRIPT_USES_THIS_FOLDER' ready with all the files inside (with placeholders in their names)
* Right click and use 'Run with PowerShell' to start up

# Optional - You can create an exe from the ps1 file by using ps2exe 
* Open PoewrShell as Admin
* Install ps2exe
`Install-Module ps2exe`
* Run 
`Invoke-ps2exe '.\Right Click and Run with Powershell.ps1' '.\Run me to create a new notebook.exe'`
