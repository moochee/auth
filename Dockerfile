FROM lakhansamani/authorizer:latest

EXPOSE 8080

USER authorizer

CMD [ "/authorizer/app/build/server" ]
