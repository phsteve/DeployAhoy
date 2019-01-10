email=$(git log --format="%ae" HEAD^!)

name=$(curl \
  -d "token=$SLACK_TOKEN&email=$email" \
  https://slack.com/api/users.lookupByEmail | jq -r .user.name)

echo "The value of name is ${name}"

curl -X POST -H 'Content-type: application/json' \
  --data "{\"text\":\"The build for $repo from the $tag branch is ready for $email @$name\",\"link_names\":true}" \
  https://hooks.slack.com/services/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
