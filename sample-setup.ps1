# Copy this file and rename to setup.ps1
# Replace $SQLServer, $Database, $Username, $Password, and $ScriptDirectory for PICKEM_DB


# Import the required module
Install-Module -Name SimplySql
Get-Module SimplySQL


# Set variables
$Server = "host"             # Add your host
$Database = "my_database"    # Add your database name
$Username = "my_username"    # Add your database username
$Password = "my_password"    # Add your database password
$ScriptDirectory = "C:\Users\Adriana's PC\projects\pickem-db\procedures" # Inlude absolute or relative directory location of pickem-db/procedures folder


# Instantiate Connection
$Password = $Password | ConvertTo-SecureString -AsPlainText -Force
$Credential = New-Object System.Management.Automation.PSCredential ($Username, $Password)
$MySQLConnection = Open-MySqlConnection -Credential ($Credential) -Server $Server


# Create database if it does not exist
Invoke-SqlUpdate -Query "CREATE DATABASE IF NOT EXISTS $database"
$MySQLConnection = Open-MySqlConnection -Credential ($Credential) -Database $Database -Server $Server


# Get all SQL files in the directory
$SQLFiles = Get-ChildItem -Path $ScriptDirectory -Filter "*.sql" | Sort-Object Name


# Execute each SQL file
foreach ($file in $SQLFiles) {
    Write-Host "Executing $file"
    $sql = Get-Content "$ScriptDirectory\$file" -Raw
    Invoke-SqlQuery -Query $sql
}


Write-Host "$Database Database created!"
