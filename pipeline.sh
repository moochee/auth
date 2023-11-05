#!/bin/sh -e

alias dokku='ssh -t dokku@moochee.us'

echo "Deploy new version"
app_name=auth
if dokku apps:exists ${app_name}; then
    dokku apps:destroy ${app_name} --force
fi
dokku apps:create ${app_name}
dokku storage:mount ${app_name} /var/lib/dokku/data/storage/moochee/auth:/auth
dokku certs:add ${app_name} /home/dokku/server.crt /home/dokku/server.key
dokku ports:set ${app_name} http:80:8080 https:443:8080

git remote add dokku dokku@moochee.us:${app_name} || git remote set-url dokku dokku@moochee.us:${app_name}
dokku config:set --no-restart ${app_name} \
    ENV="production" \
    ADMIN_SECRET=$ADMIN_SECRET \
    DATABASE_TYPE=$DATABASE_TYPE \
    DATABASE_URL=$DATABASE_URL \
    AUTHORIZER_URL="https://auth.moochee.us"
git push dokku main
