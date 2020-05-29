# step-ca Raspberry Pi Docker image

*step-ca* is a nice and easy to deploy X509 / SSH CA plus ACME service
ideal for private networks.

The binaries are not included, **step-ca** and **step** can be
compiled locally or cross-compiled elsewhere for ARM (or ARM64):

```
git clone https://github.com/smallstep/certificates
cd certificates
GOARCH=arm make build
cp bin/step-ca ..
cd ..

git clone https://github.com/smallstep/cli
cd cli
GOARCH=arm make build
cp bin/step ..
cd ..
```

## Running it

Init the ca config:

```
mkdir step-ca
STEPPATH=$(pwd)/step-ca ./step ca init
```

Adjust the paths in *step-ca/config/ca.json* and
*step-ca/config/defaults.json* replacing *.../step-ca/* with */ca/*.
Optionally, put the ca key password in *step-ca/password* to
avoid entering it at each boot (this lowers the security, of course).

Update the db in *step-ca/config/ca.json* to use BadgerV2:

```
   "db": {
      "type": "badgerV2",
      "dataSource": "/ca/db",
      "badgerFileLoadingMode": "FileIO"
   },
```

Build the image:
```
docker build -t step-ca .
```

Now you can run the container:

```
docker run -d \
-v $(pwd)/step-ca:/ca \
-p 4443:4443 \
--name step-ca \
--restart=unless-stopped \
step-ca
```

