#!/bin/bash
base_path=`pwd`
echo "base_path is $base_path"
token_file="$base_path/data/token.txt"
db_file="$base_path/data/data.db"
if [[ -f $token_file ]] && [[ -s $token_file ]]; then
  user_token=$(head -n1 $token_file)
  sqlite3 $db_file <<EOF
update x_storages set addition = json_replace(addition, '$.refresh_token',"$user_token") where driver = 'AliyundriveShare';
EOF
  echo $(date) "User's own token $user_token has been updated into database successfully"
else
  echo $(date) "User's own token is not found, please check your token file."
fi
