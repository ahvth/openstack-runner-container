# TODO: implement logging or other feedback

FROM ubuntu:latest
RUN apt update && apt install -y git python3
EXPOSE 8090/tcp
CMD git clone https://github.com/ahvth/openstack-runner && cd openstack-runner && python3 openstack-runner.py
