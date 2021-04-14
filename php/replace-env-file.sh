# Get all env variables 
function replace_env() {
  local input="$(< /dev/stdin)"
  local file="$(echo $input | cut -d "=" -f 2)"
  if [ ! -f "$file" ]; then
    return
  fi

  local file_content=$(< $file)
  local new_variable="$(echo $input | cut -d "=" -f 1 | sed 's/_SECRET_FILE//')"

  if [ ! -z "$var" ]
  then
      echo "export $new_variable=\"$file_content\""
  fi
}

echo "export PARSED=yes"  > tbs

printenv | grep _SECRET_FILE= | replace_env >> tbs

source tbs
