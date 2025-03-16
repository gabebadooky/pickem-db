# Import the required module
Import-Module dbatools

# Set variables
$SQLServer = "your_server_name"
$Database = "your_database_name"
$Username = "your_username"
$Password = "your_password"
$ScriptDirectory = "C:\path\to\sql\scripts"

# Create a secure string for the password
$SecurePassword = ConvertTo-SecureString $Password -AsPlainText -Force

# Create a PSCredential object
$Credentials = New-Object System.Management.Automation.PSCredential ($Username, $SecurePassword)

# Get all SQL files in the directory
$SQLFiles = Get-ChildItem -Path $ScriptDirectory -Filter "*.sql" | Sort-Object Name

# Execute each SQL file
foreach ($file in $SQLFiles) {
    Write-Host "Executing $($file.Name)"
    Invoke-DbaQuery -SqlInstance $SQLServer -Database $Database -File $file.FullName -SqlCredential $Credentials
}

Write-Host "All SQL files executed successfully."
