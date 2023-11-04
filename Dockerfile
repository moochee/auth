FROM lakhansamani/authorizer:latest

EXPOSE 8080

USER root

CMD [ "./build/server" ]
