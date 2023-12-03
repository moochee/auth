FROM lakhansamani/authorizer:1.3.0

EXPOSE 8080

USER root

CMD [ "./build/server" ]
