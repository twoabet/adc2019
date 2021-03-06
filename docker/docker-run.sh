#!/bin/sh
#

script=$(readlink -f "$0")
top_dir=$(cd $(dirname "$script")/../; pwd)
docker_dir="${top_dir}/docker"

docker run \
       --name adc2020 \
       -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
       -v /tmp/adc2020:/run \
       -v "${docker_dir}/env.conf":/etc/systemd/system/adc-server.service.d/env.conf \
       -p 20022:22 \
       -p 20080:8888 \
       ipsjdasadc/adc:latest
