FROM lakhansamani/authorizer:1.3.3

EXPOSE 8080

USER root

CMD [ "./build/server" ]
