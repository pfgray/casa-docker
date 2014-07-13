#!/bin/bash

cd /root/casa/casa-engine/

bundle exec rackup -p 3000 &

cd /root/casa/casa-admin-outlet
bundle exec rackup -p 5000




