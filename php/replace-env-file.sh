# Get all env variables 
function replace_env() {
  local input="$(< /dev/stdin)"
  local file="$(echo $input | cut -d "=" -f 2)"
  local file_content=$(< $file)
  local new_variable="$(echo $input | cut -d "=" -f 1 | sed 's/_SECRET_FILE//')"

  echo "export $new_variable=\"$file_content\""
}

echo "" > tbs

printenv | grep _SECRET_FILE= | replace_env >> tbs

source tbs
