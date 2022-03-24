FROM docker.io/python:3.6-slim

ENV CAIRIS_DIR="/cairis"
ENV CAIRIS_SRC="${CAIRIS_DIR}/cairis"
ENV CAIRIS_CFG_DIR="${CAIRIS_SRC}/config"

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update --yes \
    && apt install --no-install-recommends --yes \
    curl \
    dblatex \
    docbook \
    docbook-utils \
    inkscape \
    pandoc \
    python3-pip \
    texlive-latex-extra

RUN pip3 install flask
RUN mkdir /latex
COPY LaTeXApi.py /latex
RUN touch __init__.py

RUN curl --location \
    https://github.com/yuuyins/cairis/archive/refs/heads/docker.tar.gz \
    | tar --directory=/ -xz \
    && mv /cairis-docker "${CAIRIS_DIR}" \
    && mv "${CAIRIS_SRC}/core/armid.py" "/latex/" \
    && mv "${CAIRIS_CFG_DIR}" /tmp \
    && rm --recursive --force --verbose "${CAIRIS_DIR}" \
    && mkdir --parents "${CAIRIS_SRC}" \
    && mv /tmp/config "${CAIRIS_SRC}/"

    # && find "${CAIRIS_DIR}/" \
    # -path "${CAIRIS_CFG_DIR}" -prune -o \
    # ! -path "${CAIRIS_DIR}/" \
    # -exec rm --recursive --force --verbose {} +

RUN apt remove --purge --yes curl \
    && apt autoremove --yes

EXPOSE 5000

CMD ["/latex/LaTeXApi.py"]
