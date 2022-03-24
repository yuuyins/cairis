FROM docker.io/ubuntu:22.04
MAINTAINER Shamal Faily <admin@cairis.org>

ENV CAIRIS_DIR="/cairis"
ENV CAIRIS_SRC="${CAIRIS_DIR}/cairis"
ENV CAIRIS_CFG_DIR="${CAIRIS_SRC}/config"
ENV CAIRIS_CFG="${CAIRIS_CFG_DIR}/cairis.cnf"
ENV PYTHONPATH="${CAIRIS_DIR}"
ENV TZ=America/Sao_Paulo

ARG DEBIAN_FRONTEND=noninteractive

RUN apt update --yes \
    && apt install --no-install-recommends --yes \
    apache2 \
    apache2-dev \
    apt-transport-https \
    build-essential \
    ca-certificates \
    curl \
    default-libmysqlclient-dev \
    graphviz \
    libssl-dev \
    libxml2-dev \
    libxslt1-dev \
    mysql-client \
    poppler-utils \
    python3-apt \
    python3-dev \
    python3-mysqldb \
    python3-numpy \
    python3-pip \
    python3-setuptools

COPY requirements.txt wsgi_requirements.txt /
RUN pip3 install wheel \
    && pip3 install -r requirements.txt \
    && pip3 install -r wsgi_requirements.txt

RUN curl --location \
    https://github.com/yuuyins/cairis/archive/refs/heads/docker.tar.gz \
    | tar --directory=/ -xz \
    && mv /cairis-docker "${CAIRIS_DIR}" \
    && find "${CAIRIS_DIR}/" \
    -path "${CAIRIS_SRC}" -prune -o \
    ! -path "${CAIRIS_DIR}/" \
    -exec rm --recursive --force --verbose {} +

RUN mkdir /tmpDocker /images

COPY addAccount.sh cairis.cnf createdb.sql setupDb.sh /
COPY register_user.html "${CAIRIS_SRC}/daemon/templates/security"

RUN "${CAIRIS_SRC}/bin/installUI.sh"

RUN apt remove --purge --yes curl \
    && apt autoremove --yes

CMD ["/setupDb.sh"]
