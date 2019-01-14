email=$(git log --format="%ae" HEAD^!)

name=$(curl \
  -d "token=$SLACK_TOKEN&email=$email" \
  https://slack.com/api/users.lookupByEmail | jq -r .user.name)

if [ "$name" != "null" ]
then message="The build for $repo from the $tag branch is ready for @$name"
else message="The build for $repo from the $tag branch is ready for ${email}. If you would like to be @ mentioned, please change your git email to your tpt email."
fi

curl -X POST -H 'Content-type: application/json' \
  --data "{\"text\":\"$message\",\"link_names\":true}" \
  "$SLACK_CHANNEL_URL"

