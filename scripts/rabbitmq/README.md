Отправка данных в Zabbix происходит при запросе с сервера какого-то параметра,
например rabbitmq[queues]
При этом происходит получение от rabbitmq данных, которые укаковываются в файл в /tmp и отсылаются при помощи
zabbix-sender на сервер. Если данные от сервера не передаются более 5минут или происходит какая-либо ошибка при отправке данных
на сервер, то срабатывает триггер "Данные от очередей сервера RabbitMQ не поступают в мониторинг (Queue data status issue)"

   *Внимание!*
   Если при запросе параметра check_aliveness (aliveness-test/%2f) Вы получаете 
   `urllib2.HTTPError: HTTP Error 401: Unauthorized`
   Значит у пользователя, от которого Вы соеденяетесь с сервером RabbitMQ, нет соответствующих прав.
   
   Я ставлю такие права: 
   
   `Virtual host: /
  - Configure regexp: ^aliveness-test$
  - Write regexp: ^amq\.default$
  - Read regexp: ^aliveness-test$`
