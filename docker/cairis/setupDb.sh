#!/usr/bin/env bash

set -x

mysql --host=cairis --user=root --password=my-secret-pw < createdb.sql
mysql --host=cairis --user=cairis_test --password=cairis_test --database=cairis_test_default < "${CAIRIS_SRC}/sql/init.sql"
mysql --host=cairis --user=cairis_test --password=cairis_test --database=cairis_test_default < "${CAIRIS_SRC}/sql/procs.sql"
mysql --host=cairis --user=root --password=my-secret-pw <<!
set global max_sp_recursion_depth = 255;
flush tables;
flush privileges;
!
chown www-data /images
chgrp www-data /images
chmod 1777 /tmpDocker
mod_wsgi-express start-server "${CAIRIS_SRC}/bin/cairis.wsgi" --user www-data --group www-data
