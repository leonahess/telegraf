FROM telegraf:latest


ADD telegraf.conf /tmp

ENTRYPOINT ["/entrypoint.sh"]
CMD ["telegraf --config /tmp/telegraf.conf"]
