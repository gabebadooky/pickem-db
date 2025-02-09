# PICKEM_DB
> Relational database for the Confidence Pickem project

## Technologies 
- MySQL 8

## Getting Started
1. Install MySQL Community Server
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

2. Execute each script in the `mysql` folder against the MySQL database to instantiate each procedure
3. Instantiate all of the tables, constraints, relationships and views required for the 
Pickem application<br>
`CALL PROC_CREATE_DB();`
- If ever needed, execute the command below to delete all data and drop all objects in the pickem_db
`PROC_DROP_DB();`

## Usage
The database stores all relavent data in a normalized relational schema for the backend of the Pickem application. Additionally the database includes the following objects, for the foundational functionality of the application:<br>
- **PROC_CREATE_USER**
- **PROC_UPDATE_USER_NOTIFICATION_PREFERENCE**
- **PROC_UPDATE_USER_EMAIL**
- **PROC_UPDATE_USER_PHONE**
- **PROC_SUBMIT_PICK**
- **GET_PICKS_VW**
- **GET_GAMES_VW**
- **GET_TEAMS_VW**
- **PROC_DELETE_DATA**
- **PROC_DROP_DB**

