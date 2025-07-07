# Copy this file and rename as setup.sh
# Replace my-password, path/to/directory, username, and database_name for PICKEM_DB
# Ensure `setup.sh` stays included in the .gitignore file

# Connection parametersc
export MYSQL_PWD=""
username="my-username"
host="localhost"
port=3306
database="my_db"
directory=./procedures/*.sql


mysql -u $username -e "CREATE DATABASE IF NOT EXISTS $database"

for script in $directory
do
  echo "Executing $script"
  mysql -u $username $database < $script
done

mysql -h $host -P $port -u $username $database -e "CALL \`$database\`.PROC_CREATE_DB"

echo "$database Database Created!"

unset MYSQL_PWD
