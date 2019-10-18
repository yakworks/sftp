#!/bin/bash

# run this from the root project dir
cd examples/docker

# docker build -t yakworks/sftp .
docker stop sftp || true && docker rm sftp || true

# --cap-add=SYS_ADMIN is for the mounts
# --cap-add=NET_ADMIN is for fail2ban iptables
docker run --name sftp --cap-add=SYS_ADMIN --cap-add=NET_ADMIN \
  -p 9922:22 \
  -e DATA_MOUNT=/sftp-data \
  -v $(pwd)/sftp-vol:/sftp-data \
  -v $(pwd)/users.conf:/etc/sftp/users.conf \
  -v $(pwd)/user-keys:/etc/sftp/authorized_keys.d \
  -v $(pwd)/host-keys:/etc/sftp/host_keys.d \
  -d yakworks/sftp

#to brute force test to see if fail2ban is working
#hydra -l ftp -x 3:3:a -t 4 -s 30022 ssh://127.0.0.1/
