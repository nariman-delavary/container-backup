#!/bin/bash
scriptPath=$(dirname "$(readlink -f "$0")")
source "${scriptPath}/.env.sh"
if [ "$BACKUP_TYPE" = "files" ];
  then
    PATH='/data'
    PATH+=$BACKUP_TARGET_PATH
    DATE=$(/bin/date +%d-%b-%Y-%H-%M-%S)
    NAME=$BACKUP_NAME-$DATE
    BACKUP_PATH=/tmp/$NAME.tar.gz
    DELPREFIX=$(/bin/date -d "now -$BACKUP_DELETE_DAY day" +"$BACKUP_NAME-%d-%b")
    /bin/tar -cvf - -P $PATH | /bin/gzip > $BACKUP_PATH
    if [ "$BACKUP_DRIVER" = "ftp" ];
      then
        /usr/bin/ftp -p -inv $FTP_HOST << EOF
          user $FTP_USER $FTP_PASSWORD
          cd $FTP_DEST_DIR
          mkdir backup
          cd backup
          mkdir $BACKUP_NAME
          cd $BACKUP_NAME
          put $BACKUP_PATH $FTP_DEST_DIR/backup/$BACKUP_NAME/$NAME.tar.gz
          mdelete "$DELPREFIX*"
          bye
EOF
      rm -f $BACKUP_PATH
    fi
elif [ "$BACKUP_TYPE" = "mysql" ];
  then
    DATE=$(/bin/date +%d-%b-%Y-%H-%M-%S)
    NAME=$BACKUP_NAME-$DATE
    BACKUP_PATH=/tmp/$NAME.sql.gz
    DELPREFIX=$(/bin/date -d "now -$BACKUP_DELETE_DAY day" +"$BACKUP_NAME-%d-%b")
    mysqldump --routines -h $MYSQL_HOST -u $MYSQL_USER --password="$MYSQL_PASS" --single-transaction $MYSQL_DATABASE | gzip > $BACKUP_PATH
    if [ "$BACKUP_DRIVER" = "ftp" ];
      then
        /usr/bin/ftp -p -inv $FTP_HOST << EOF
          user $FTP_USER $FTP_PASSWORD
          cd $FTP_DEST_DIR
          mkdir backup
          cd backup
          mkdir $BACKUP_NAME
          cd $BACKUP_NAME
          put $BACKUP_PATH $FTP_DEST_DIR/backup/$BACKUP_NAME/$NAME.sql.gz
          mdelete "$DELPREFIX*"
          bye
EOF
      rm -f $BACKUP_PATH
    fi
else
  echo 'Operation failed'
fi
