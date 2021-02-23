# TODO: implement logging or other feedback

# build stage

FROM registry.access.redhat.com/ubi8/python-38 AS builder
RUN git clone https://github.com/ahvth/openstack-runner
WORKDIR openstack-runner
COPY requirements.txt .
RUN python -m pip install --upgrade pip
RUN pip install -r requirements.txt
RUN pyinstaller --onefile openstack-runner.py

# run stage

FROM registry.access.redhat.com/ubi8/ubi
RUN yum install -y python3
RUN mkdir openstack-runner
WORKDIR openstack-runner
COPY --from=builder /opt/app-root/src/openstack-runner .
RUN python3 -m pip install --upgrade pip
RUN pip install -r requirements.txt
EXPOSE 8090/tcp
RUN chmod +x openstack-runner.py
CMD python3 openstack-runner.py
