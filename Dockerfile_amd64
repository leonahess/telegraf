FROM telegraf:latest

ADD telegraf_amd64.conf .

RUN rm -f /etc/telegraf/telegraf.conf
RUN mv telegraf_amd64.conf telegraf.conf
RUN cp /telegraf.conf /etc/telegraf/


ENTRYPOINT ["/entrypoint.sh"]
CMD ["telegraf"]
