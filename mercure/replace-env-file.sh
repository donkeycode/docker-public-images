# Get all env variables
function replace_env() {
  local input="$1"
  local file="$(echo $input | cut -d "=" -f 2)"

  echo "# Parse input ${input}"
  echo "# File is ${file}"

  if [ ! -f "$file" ]; then
    return
  fi

  local file_content=$(cat $file)
  local new_variable="$(echo $input | cut -d "=" -f 1 | sed 's/_SECRET_FILE//')"

  echo "export $new_variable=\"$file_content\""
}

echo "FILE_ENV_SECRET_LOADED=yes" > /etc/environment

for i in $(printenv | grep _SECRET_FILE)
do
  replace_env $i >> /etc/environment
done

source /etc/environment
