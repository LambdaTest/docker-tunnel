FROM alpine:latest
RUN wget https://downloads.lambdatest.com/tunnel/v3/linux/64bit/LT_Linux.zip && \ 
    unzip LT_Linux.zip && \
    rm LT_Linux.zip && \
    chmod +x /LT
 
ENTRYPOINT [ "/LT" ]
