FROM local/c7-systemd:latest

ARG MINION_ID

RUN yum install -y epel-release && \
    yum install -y https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm && \
    yum update -y && \
    yum install -y virt-what salt-minion && \
    yum install -y less vim && \
    yum clean all && \
    rm -rf /var/cache/yum

RUN rm /etc/salt/minion && \
    echo '# Starting from empty file' >> /etc/salt/minion && \
    echo 'master: salt-master' >> /etc/salt/minion && \
    echo "id: ${MINION_ID}" >> /etc/salt/minion && \
    systemctl enable salt-minion

COPY config/etc/salt/grains /etc/salt/
#COPY config/usr/local/bin/docker-entrypoint.sh /usr/local/bin/

CMD ["/usr/sbin/init"]