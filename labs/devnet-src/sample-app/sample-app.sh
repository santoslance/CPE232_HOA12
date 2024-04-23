#!/bin/bash

# Create directories
mkdir -p tempdir/templates
mkdir -p tempdir/static

# Copy files
cp sample_app.py tempdir/
cp -r templates/* tempdir/templates/
cp -r static/* tempdir/static/

# Create Dockerfile
cat > tempdir/Dockerfile <<EOF
FROM python
RUN pip3 install flask
COPY ./static /home/myapp/static/
COPY ./templates /home/myapp/templates/
COPY sample_app.py /home/myapp/
EXPOSE 8080
CMD python3 /home/myapp/sample_app.py
EOF

# Build Docker image
cd tempdir
docker build -t sampleapp .

# Run Docker container
docker run -t -d -p 8080:8080 --name samplerunning sampleapp

# List Docker containers
docker ps -a

