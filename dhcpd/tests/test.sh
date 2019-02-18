#!/bin/bash

REGISTRY_ADDRESS="registry.example.com"
TEST_ON="centos debian"

echo 'Checking if there are leftover containers...'

docker rm -f ${TEST_ON} || echo 'No containers leftover. Proceed...'

echo 'Pulling images...'

for container in ${TEST_ON}; do
  docker pull ${REGISTRY_ADDRESS}/${container}:latest
done

echo 'Starting containers...'

for container in ${TEST_ON}; do
  docker run \
    --detach \
    --name=${container} \
    --cap-add=SYS_ADMIN \
    -v /sys/fs/cgroup:/sys/fs/cgroup:ro \
    --tmpfs /run \
    ${REGISTRY_ADDRESS}/${container}:latest init
done

ansible-playbook -i ./tests/inventory ./tests/test.yml --extra-vars host_group=testing-containers

echo 'Removing containers...'

for container in ${TEST_ON}; do
  docker rm -f ${container}
done
