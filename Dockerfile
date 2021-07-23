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

#FROM node:10-stretch-slim
FROM node:10-slim

MAINTAINER EbolaWare

WORKDIR /install/
USER root

RUN 	apt-get update && \
	apt-get install -y git bzip2 python3 build-essential
  
RUN  	rm -rf /var/lib/apt/lists/* /var/cache/apt/* && \
	npm install -g grunt-cli 

RUN	git clone https://github.com/gchq/CyberChef 

WORKDIR /install/CyberChef
ENV	NODE_OPTIONS=--max_old_space_size=2048

RUN	npm install -g grunt-cli && npm install

#RUN	rm -fr ./build ./node_modules package-lock.json && git checkout .

#RUN	apt-get remove -y build-essential && apt -y autoremove
#RUN	grunt --help
EXPOSE 8080
ENTRYPOINT ["grunt"]
CMD ["prod","--force","-d","-v"]
CMD	["dev","-fv"]
