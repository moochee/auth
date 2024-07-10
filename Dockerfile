FROM lakhansamani/authorizer:1.4.3

EXPOSE 8080

USER root

CMD [ "./build/server" ]
