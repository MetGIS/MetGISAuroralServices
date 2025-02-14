FROM httpd:2.4-bullseye

COPY ./startup.sh /startup.sh

RUN chmod +x /startup.sh

COPY ./staticfiles/ /staticfiles/

EXPOSE 80

CMD ["/startup.sh"]
