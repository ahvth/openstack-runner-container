# TODO: implement logging or other feedback

# build stage
FROM registry.access.redhat.com/ubi8/python-38 AS builder
COPY requirements.txt .
RUN git clone https://github.com/ahvth/openstack-runner
WORKDIR openstack-runner
RUN python -m pip install --upgrade pip
RUN pip install -r requirements.txt
RUN pyinstaller --onefile --hidden-import cmath openstack-runner.py

# run stage

FROM registry.access.redhat.com/ubi8/ubi
EXPOSE 8090/tcp
CMD ./openstack-runner.py
