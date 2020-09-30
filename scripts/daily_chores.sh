#!/bin/bash

source /srv/webapps/fundaction/shared/environment.sh
cd /srv/webapps/fundaction/current

bin/rake decidim:open_data:export
bin/rake decidim:metrics:all
