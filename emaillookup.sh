email='steve@teacherspayteachers.com'
repo='tpt-frontend'
branch='my-awesome-branch'

name=$(curl \
  -d "token=xoxp-517926574081-518426450451-518376735460-5a1042f12e921349c2ef081576744e06&email=$email" \
  https://slack.com/api/users.lookupByEmail | jq -r .user.name)

echo "The value of name is ${name}"

curl -X POST -H 'Content-type: application/json' \
  --data "{\"text\":\"The build for $repo from the $branch branch is ready for $email @$name\",\"link_names\":true}" \
  https://hooks.slack.com/services/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
