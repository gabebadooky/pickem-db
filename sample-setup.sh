# Copy this file and rename as setup.sh
# Replace my-password, path/to/directory, username, and database_name for PICKEM_DB

# Connection parametersc
export MYSQL_PWD=""
username="my-username"
host="localhost"
port=3306
database="my_db"
directory=./path/to/directory/*.sql


mysql -u $username -e "CREATE DATABASE IF NOT EXISTS $database"
echo "$database Database Created!"

for script in $directory
do
  echo "Executing $script"
  mysql -u $username $database < $script
done

mysql -u $username $database -e "CALL PROC_CREATE_DB()"

unset MYSQL_PWD
