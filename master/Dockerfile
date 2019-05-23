FROM local/c7-systemd:latest

# Master is also Minion of his own
ARG MASTER_ID

RUN yum install -y epel-release && \
    yum install -y https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm && \
    yum update -y && \
    yum install -y virt-what salt-master salt-minion && \
    yum install -y less vim && \
    yum clean all && \
    rm -rf /var/cache/yum

RUN rm /etc/salt/master && \
    echo '# Starting from empty file' >> /etc/salt/master && \
    echo 'auto_accept: True' >> /etc/salt/master && \
    echo 'yaml_utf8: True' >> /etc/salt/master && \
    mkdir -p /srv/salt && \
    rm /etc/salt/minion && \
    echo '# Starting from empty file' >> /etc/salt/minion && \
    echo 'master: salt-master' >> /etc/salt/minion && \
    echo "id: ${MASTER_ID}" >> /etc/salt/minion && \
    systemctl enable salt-master && \
    systemctl enable salt-minion

RUN touch /etc/profile.d/00-aliases.sh && \
    echo "alias base='cd /srv/salt/base'" >> /etc/profile.d/00-aliases.sh && \
    echo "alias pillar='cd /srv/salt/pillar'" >> /etc/profile.d/00-aliases.sh && \
    echo "alias overrides='cd /srv/salt/pillar/overrides'" >> /etc/profile.d/00-aliases.sh && \
    echo "alias saltlogs='cd /var/log/salt'" >> /etc/profile.d/00-aliases.sh

ADD config/srv/salt/base /srv/salt/base
ADD config/srv/salt/pillar /srv/salt/pillar
ADD config/srv/salt/overrides /srv/salt/pillar/overrides

COPY config/etc/salt/master.d/*.conf /etc/salt/master.d/
COPY config/etc/salt/grains /etc/salt/
#COPY config/usr/local/bin/docker-entrypoint.sh /usr/local/bin/

CMD ["/usr/sbin/init"]