#!/usr/bin/env bash
#  Licensed to the Apache Software Foundation (ASF) under one
#  or more contributor license agreements.  See the NOTICE file
#  distributed with this work for additional information
#  regarding copyright ownership.  The ASF licenses this file
#  to you under the Apache License, Version 2.0 (the
#  "License"); you may not use this file except in compliance
#  with the License.  You may obtain a copy of the License at
#
#  http://www.apache.org/licenses/LICENSE-2.0
#
#  Unless required by applicable law or agreed to in writing,
#  software distributed under the License is distributed on an
#  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
#  KIND, either express or implied.  See the License for the
#  specific language go
#
# Author: Shamal Faily

curl --silent --location https://deb.nodesource.com/setup_10.x \
    | bash - && apt install --yes nodejs

apt install --yes gnupg
curl --silent --show-error https://dl.yarnpkg.com/debian/pubkey.gpg \
    | gpg --no-default-keyring \
    --keyring gnupg-ring:/etc/apt/trusted.gpg.d/yarnpkg.gpg \
    --import
chown _apt /etc/apt/trusted.gpg.d/yarnpkg.gpg
printf "%s\n" "deb https://dl.yarnpkg.com/debian/ stable main" \
    | tee /etc/apt/sources.list.d/yarn.list
apt update --yes
apt install --yes yarn

export UI_REPO=/tmp/cairis-ui
rm -rf "${UI_REPO}"
curl --location \
    https://github.com/cairis-platform/cairis-ui/archive/master.tar.gz \
    | tar --directory=/tmp -xz \
    && mv "/tmp/cairis-ui-master" "${UI_REPO}"

yarn --cwd "${UI_REPO}" install --ignore-engines
yarn --cwd "${UI_REPO}" run build
cp --recursive "${UI_REPO}/dist" "${CAIRIS_SRC}"
