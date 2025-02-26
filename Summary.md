## Database Design and Development Approach
1. Identify and list desired data elements from each source website 
2. Normalize the data model to mitigate redundancy ([Data Normalization Draft Doc](https://docs.google.com/spreadsheets/d/12aBpKssCciR3sFBb1Mrp15PZSPBCHbsKBGePMRpX4PY/edit?usp=sharing))
3. Create Entity Relationship Diagram for Pickem database ([CFB Pickem ERD](https://lucid.app/lucidchart/b23cbf7a-b9f9-4ce6-b310-3fb8cbcc6329/edit?viewport_loc=-1207%2C-1018%2C3577%2C2203%2C0_0&invitationId=inv_fb883cc0-8449-4625-9a2e-8be28ce6ef22))
4. Develop `PROC_CREATE_TABLES` procedure to instantiate each database table (if they do not exist)
5. Develop `PROC_CREATE_VIEWS` procedure to instantiate each database view (if they do not exist)
6. Develop `PROC_DELETE_DATA` procedure to delete all table data without violating foreign key constraints
7. Develop `PROC_CREATE_USER` procedure to insert new user and picks records into the database
8. Develop `PROC_UPDATE_USER` procedure to execute update on USERS table for given USER_ID
    - Later modularized into separate procedures for each account element: 
        - `PROC_UPDATE_USER_EMAIL`
        - `PROC_UPDATE_USER_NOTIFICATION_PREFERENCE`
        - `PROC_UPDATE_USER_PHONE`
9. Develop `PROC_SUBMIT_PICK` procedure to execute update on PICKS table for given USER_ID and GAME_ID
10. Develop `PROC_DROP_DB` procedure to drop all database objects
11. Develop `PROC_CREATE_DB` procedure to create all database objects
12. Instantiate database locally from scripts
13. Unit test each database object
    - Later enhanced database to develop procedures to load external data (insert new records, or update existing records)
        - `PROC_LOAD_GAMES`
        - `PROC_LOAD_TEAMS`
        - `PROC_LOAD_ODDS`
        - `PROC_LOAD_STATS`
        - `PROC_LOAD_RECORDS`
        - `PROC_LOAD_LOCATION`
        - `PROC_LOAD_BOX_SCORE`
