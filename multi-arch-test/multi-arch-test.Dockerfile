FROM alpine:latest
COPY hello.sh /app/hello.sh
RUN chmod +x /app/hello.sh
CMD ["/app/hello.sh"]
