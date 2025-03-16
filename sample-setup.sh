# Copy this file and rename to setup.sh
# Replace my-password, path/to/directory, username, and database_name for PICKEM_DB

export MYSQL_PWD="my-password"

for sql_file in /path/to/directory/*.sql
do
  mysql -u username -p database_name < $sql_file
done

unset MYSQL_PWD