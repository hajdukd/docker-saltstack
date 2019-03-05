FROM centos

RUN yum install -y epel-release && \
    yum install -y --nogpgcheck https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm && \
    yum update -y && \
    yum install -y virt-what salt-master && \
    yum install -y vim && \
    yum install -y less && \
    yum clean all && \
    rm -rf /var/cache/yum

RUN rm /etc/salt/master && \
    echo '# Starting from empty file' >> /etc/salt/master && \
    echo 'auto_accept: True' >> /etc/salt/master && \
    echo 'yaml_utf8: True' >> /etc/salt/master && \
    mkdir -p /srv/salt

ADD base.tar.gz /srv/salt
ADD pillar.tar.gz /srv/salt

COPY *.conf /etc/salt/master.d/

ENTRYPOINT ["salt-master", "-l", "debug"]
