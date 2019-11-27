#
# Because the others were not usable with the newest version of CyberChef!
# I stealed it from the others
#
# This Docker image encapsulates the CyberChef analysis tool by GCHQ
# from https://github.com/gchq/CyberChef
#
# To run this image in the background after installing Docker,
# use the following command:
#
# sudo docker run -d -p 8080:8080 remnux/cyberchef
#
# Then, connect to http://localhost:8080 using your web browser.
# To stop the container, use Docker's "ps" and "stop" commands.
#

FROM node:10-stretch-slim

MAINTAINER EbolaWare

WORKDIR /install/
USER root

RUN apt-get update && \
  apt-get install -y git bzip2 && \
  rm -rf /var/lib/apt/lists/* && \
  npm install -g grunt-cli && \ 
  git clone https://github.com/gchq/CyberChef && \
  cd CyberChef && \
  npm install

EXPOSE 8080
WORKDIR /install/CyberChef
ENTRYPOINT ["grunt"]
CMD ["dev"]
