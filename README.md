# PICKEM_DB
> Relational database for the Confidence Pickem project

## Technologies 
- MySQL9.2

## Getting Started
0. Install MySQL Community Server
<br>
**MSI/DMG/TAR Installer**:<br>
https://dev.mysql.com/downloads/mysql/
<br>
**Chocolatey**:<br>
`choco install mysql`
<br>
**Homebrew**:<br>
`brew install mysql`
<br><br>

1. Create a copy of the `sample-setup` file and remove the 'sample-' prefix
    <br>
    
    **Bash**<br>
    `sample-setup.sh -> setup.sh`

    <br>

    **PowerShell**<br>
    `sample-setup.ps1 -> sample-setup.ps1`

    <br>


2. Modify the connection parameters in the newly created `setup` file
    - MYSQL_PWD
    - username
    - host
    - port
    - database


3. Run the setup script to create all of the objects in the target host/database:
    <br>
    
    **Bash**<br>
    `bash setup.sh`

    <br>
    
    **Powershell**<br>
    `powershell setup.ps1`


## Usage
The database stores all relavent data in a normalized relational schema for the backend of the Pickem application. Additionally the database includes the following objects, for the foundational services of the application:<br>
- **GET_USER_PICKS_VW**
- **PROC_CREATE_USER**
- **PROC_UPDATE_USER_NOTIFICATION_PREFERENCE**
- **PROC_UPDATE_USER_FAVORITE_TEAM**
- **PROC_UPDATE_USER_EMAIL**
- **PROC_UPDATE_USER_PHONE**
- **PROC_SUBMIT_PICK**
- **PROC_LOAD_BOX_SCORES**
- **PROC_LOAD_GAME**
- **PROC_LOAD_LOCATION**
- **PROC_LOAD_ODDS**
- **PROC_LOAD_RECORD**
- **PROC_LOAD_SCORING**
- **PROC_LOAD_STATS**
- **PROC_LOAD_TEAM**
- **PROC_DELETE_DATA**
- **PROC_DROP_DB**

