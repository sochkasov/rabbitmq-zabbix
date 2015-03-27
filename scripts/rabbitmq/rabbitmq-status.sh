#!/bin/bash
#
# https://github.com/jasonmcintosh/rabbitmq-zabbix
#
#UserParameter=rabbitmq[*],<%= zabbix_script_dir %>/rabbitmq-status.sh
cd "$(dirname "$0")"

. .rab.auth

TYPE_OF_CHECK=$1
METRIC=$2
NODE=$3

if [[ -z "$HOSTNAME" ]]; then
    HOSTNAME=`hostname`
fi
if [[ -z "$NODE" ]]; then
    NODE=`hostname`
fi
#rabbitmq[queues]
#rabbitmq[server,disk_free]
#rabbitmq[check_aliveness]

# This assumes that the server is going to then use zabbix_sender to feed the data BACK to the server.  Right now, I'm doing that
# in the python script
# Отправка данных в Zabbix происходит при запросе с сервера какого-то параметра, например rabbitmq[queues]
# При этом происходит получение от rabbitmq данных, которые укаковываются в файл в /tmp и отсылаются при помощи
# zabbix-sender на сервер. Если данные от сервера не передаются более 5минут или происходит какая-либо ошибка при отправке данных
# на сервер, то срабатывает триггер
./api.py --hostname=$HOSTNAME --username=$USERNAME --password=$PASSWORD --check=$TYPE_OF_CHECK --metric=$METRIC --node="$NODE" --filters="$FILTER" --conf=$CONF --zabbix_server=$ZABBIX_SERVER --senderhostname=$ZABBIX

