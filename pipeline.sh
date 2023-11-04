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
    ENV=$ENV \
    ADMIN_SECRET=$ADMIN_SECRET \
    DATABASE_TYPE=$DATABASE_TYPE \
    DATABASE_URL=$DATABASE_URL \
    PORT=$PORT \
    AUTHORIZER_URL=$AUTHORIZER_URL \
    DISABLE_BASIC_AUTHENTICATION=$DISABLE_BASIC_AUTHENTICATION \
    ROLES=$ROLES \
    DEFAULT_ROLES=$DEFAULT_ROLES \
    JWT_ROLE_CLAIM=$JWT_ROLE_CLAIM \
    COOKIE_NAME=$COOKIE_NAME \
    GOOGLE_CLIENT_ID=$GOOGLE_CLIENT_ID \
    GOOGLE_CLIENT_SECRET=$GOOGLE_CLIENT_SECRET
git push dokku main

echo "Maping public route"
dokku domains:add ${app_name} moochee.us