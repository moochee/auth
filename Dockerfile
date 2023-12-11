FROM lakhansamani/authorizer:1.3.4

EXPOSE 8080

USER root

CMD [ "./build/server" ]
