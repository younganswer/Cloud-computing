FROM python:3.11-slim

ENV HOME=/usr/src/app

WORKDIR $HOME

EXPOSE 8089

COPY . .

RUN mv docker-entrypoint.sh /usr/local/bin && \
	chmod +x /usr/local/bin/docker-entrypoint.sh

RUN apt-get update && \
	apt-get install -y --no-install-recommends \
		gcc \
		libffi-dev \
		libssl-dev \
		build-essential && \
	rm -rf /var/lib/apt/lists/* && \
	pip install --no-cache-dir --upgrade pip && \
	pip install --no-cache-dir -r requirements.txt

ENTRYPOINT [ "docker-entrypoint.sh" ]

CMD []