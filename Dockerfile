FROM telegraf:latest

ADD telegraf.conf /tmp/

CMD ["telegraf --config /tmp/telegraf.conf"]
