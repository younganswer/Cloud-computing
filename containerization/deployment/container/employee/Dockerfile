FROM node:11-alpine

RUN mkdir -p /usr/src/app

ENV HOME /usr/src/app

WORKDIR $HOME

COPY . .

RUN mv docker-entrypoint.sh /usr/local/bin && \
	chmod +x /usr/local/bin/docker-entrypoint.sh

RUN npm install

ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD [ "node", "index.js" ]