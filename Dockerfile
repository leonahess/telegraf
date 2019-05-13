FROM telegraf:alpine

ADD telegraf.conf /etc/influxdb/

CMD ["telegraf"]
