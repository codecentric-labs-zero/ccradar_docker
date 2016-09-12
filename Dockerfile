FROM python:latest
ENV DOCKYARD_SRC=ccradarbackend

ENV DOCKYARD_SRVHOME=/srv

ENV DOCKYARD_SRVPROJ=/srv/ccradarbackend

RUN apt-get update && apt-get -y upgrade

RUN apt-get install -y python-psycopg2

WORKDIR $DOCKYARD_SRVHOME
RUN mkdir media static logs
VOLUME ["$DOCKYARD_SRVHOME/media/", "$DOCKYARD_SRVHOME/logs/"]

COPY $DOCKYARD_SRC $DOCKYARD_SRVPROJ

RUN pip install -r $DOCKYARD_SRVPROJ/requirements.txt

EXPOSE 8000

WORKDIR $DOCKYARD_SRVPROJ
COPY ./docker-entrypoint.sh /
ENTRYPOINT ["/docker-entrypoint.sh"]
