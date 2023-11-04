FROM lakhansamani/authorizer:latest

EXPOSE 8080

CMD [ "./build/server" ]
