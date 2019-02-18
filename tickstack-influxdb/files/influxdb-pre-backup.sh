#!/bin/bash

INFLUXDB_BACKUP_TMP=/tmp/influxdb_backup
INFLUXDB_BACKUP=/tmp/influxdb-duply

mkdir -p $INFLUXDB_BACKUP_TMP 2>/dev/null && \
mkdir -p $INFLUXDB_BACKUP 2>/dev/null && \
(influxd backup $INFLUXDB_BACKUP_TMP; influxd backup -database telegraf $INFLUXDB_BACKUP_TMP) && \
tar -zcvf $INFLUXDB_BACKUP/influxdb.tar $INFLUXDB_BACKUP_TMP -C $INFLUXDB_BACKUP_TMP && \
rm -rf $INFLUXDB_BACKUP_TMP
