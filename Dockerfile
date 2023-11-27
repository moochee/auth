FROM lakhansamani/authorizer:1.2.4

EXPOSE 8080

USER root

CMD [ "./build/server" ]
