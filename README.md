# container-backup
you can use this image to regulary backup your data/sql 

# how to
use following example : 

mysql 
```
backup-mysql:
    image: narimandelavary/container-backup
    entrypoint: /src/run.sh
    environment:
        BACKUP_TYPE: 'mysql'
        BACKUP_NAME: 'database' #a name of your choice
        BACKUP_DRIVER: 'ftp'
        FTP_HOST: 'bakcupftphost'
        FTP_USER: 'bakcupftpuser'
        FTP_PASSWORD: 'bakcupftppass'
        FTP_DEST_DIR: 'bakcupftpaddress'
        BACKUP_DELETE_DAY: '1'
        BACKUP_TIME: '@hourly' #crontab format
        MYSQL_HOST: 'yourdbhost'
        MYSQL_DATABASE: 'yourdbname'
        MYSQL_USER: 'yourdbuser'
        MYSQL_PASS: 'yourdbpass'
```
storage
```
backup-storage:
    image: narimandelavary/container-backup
    entrypoint: /src/run.sh
    volumes:
        - ./targetdirectory:/data  #* 
    environment:
        BACKUP_TYPE: 'files'
        BACKUP_NAME: 'storagebackup' #a name of your choice
        BACKUP_DRIVER: 'ftp'
        FTP_HOST: 'bakcupftphost'
        FTP_USER: 'bakcupftpuser'
        FTP_PASSWORD: 'bakcupftppass'
        FTP_DEST_DIR: 'bakcupftpaddress'
        BACKUP_DELETE_DAY: '1'
        BACKUP_TIME: '@hourly' #crontab format
        BACKUP_DELETE_DAY: '1'
```

\* "./targetdirectory" is the directory that should be archived and sent to backup server,but the dest parametter is read-only,dont change it.


### Todo
- [ ] integrate mongodb backup 
- [ ] integrate postgress backup
- [ ] dropbox driver
- [ ] kubernetes documentation
- [ ] backup api


### Contributions
we will be happy if you help us.remember to press star button if you like this project.
### Creation

 * Nariman Delavary ([@ndelavary](https://twitter.com/ndelavary))
 * Arash Rasoulzadeh ([@x3n0b1a](https://twitter.com/x3n0b1a))


