# Copy this file and rename to setup.sh
# Replace my-password, path/to/directory, username, and database_name for PICKEM_DB

# Connection parameters
export MYSQL_PWD="my-password"
username="my-username"
database="database-name"

for sql_file in /path/to/directory/*.sql
do
  mysql -u $username -p $database < $sql_file
done

unset MYSQL_PWD