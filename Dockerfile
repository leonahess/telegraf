FROM telegraf:latest

ADD telegraf.conf .

RUN rm -f /etc/telegraf/telegraf.conf
RUN cp /telegraf.conf /etc/telegraf/

ENTRYPOINT ["/entrypoint.sh"]
CMD ["telegraf"]
