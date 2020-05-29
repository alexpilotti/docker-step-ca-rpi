FROM alpine:latest
COPY step /bin/
COPY step-ca /bin/
WORKDIR /ca
ENV STEPPATH /ca
EXPOSE 4443
CMD ["/bin/step-ca", "/ca/config/ca.json", "--password-file=/ca/password"]

