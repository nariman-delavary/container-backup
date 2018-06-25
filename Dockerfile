FROM ubuntu:latest
MAINTAINER "Nariman Delavary ( nariman.delavary@gmail.com )"
LABEL version="1.0.0"
RUN apt-get update
RUN apt-get install -y ftp
RUN apt-get install -y cron
RUN apt-get install -y nano
RUN apt-get install -y mysql-client

#Environment Variables
ENV BACKUP_TYPE ''
ENV BACKUP_TARGET ''
ENV BACKUP_TARGET_PATH ''
ENV BACKUP_DRIVER ''
ENV BACKUP_TIME ''
ENV FTP_HOST ''
ENV FTP_USER ''
ENV FTP_PASS ''
ENV FTP_DEST_DIR ''
ENV BACKUP_DELETE_DAY ''
ENV BACKUP_TIME '@hourly'
ENV MYSQL_HOST ''
ENV MYSQL_DATABASE ''
ENV MYSQL_PASS ''
ENV MYSQL_USER ''

ADD ./src /src
WORKDIR /src
RUN chmod +x script.sh
RUN chmod +x run.sh
