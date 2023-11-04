FROM lakhansamani/authorizer:latest

EXPOSE 8080

USER authorizer

CMD [ "/app/build/server" ]
