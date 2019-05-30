FROM telegraf:latest

ADD telegraf.conf .

ENTRYPOINT ["/entrypoint.sh"]
CMD ['telegraf --config="/telegraf.conf"']
