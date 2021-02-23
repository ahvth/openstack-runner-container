# TODO: implement logging or other feedback

# build stage

FROM registry.access.redhat.com/ubi8/python-38 AS builder
RUN git clone https://github.com/ahvth/openstack-runner
WORKDIR openstack-runner
COPY requirements.txt .
RUN python -m pip install --upgrade pip
RUN pip install -r requirements.txt
RUN pyinstaller --onefile openstack-runner.py
RUN pwd

# run stage

FROM registry.access.redhat.com/ubi8/ubi
RUN mkdir openstack-runner
WORKDIR openstack-runner
COPY --from=builder /opt/app-root/src/openstack-runner .
EXPOSE 8090/tcp
RUN chmod +x openstack-runner.py
CMD ./openstack-runner.py
