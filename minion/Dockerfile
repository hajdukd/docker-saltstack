FROM centos

RUN yum install -y epel-release && \
    yum install -y --nogpgcheck https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm && \
    yum update -y && \
    yum install -y virt-what salt-minion && \
    yum clean all && \
    rm -rf /var/cache/yum

RUN rm /etc/salt/minion && \
    echo '# Starting from empty file' >> /etc/salt/minion && \
    echo 'master: salt-master' >> /etc/salt/minion

ENTRYPOINT ["salt-minion", "-l", "debug"]
