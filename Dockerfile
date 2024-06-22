FROM python:3.7-alpine as build

RUN apk add build-base libffi-dev

WORKDIR /wheels

RUN --mount=type=bind,target=/data \
    cp -a /data /data2 \
 && pip wheel /data2

# ----

FROM python:3.7-alpine

RUN --mount=type=bind,target=/wheels,from=build,source=/wheels \
    pip install --no-index -f /wheels/ proxybroker

ENV PYTHONUNBUFFERED=1
ENTRYPOINT [ "/usr/local/bin/proxybroker" ]
