FROM debian:stable-slim

RUN apt-get update && apt-get install -y bash dash ksh git && rm -rf /var/lib/apt/lists/*

WORKDIR /shpxunit

COPY . /shpxunit

ENV SHPXUNIT_ROOT=/shpxunit/ShPXUnit

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]