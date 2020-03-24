FROM registry.fedoraproject.org/fedora:31

LABEL maintainer "Lorenzo Dalrio <lorenzo.dalrio@gmail.com>"

RUN groupadd -g 1001 public \
    && useradd -g public -u 973 -m public

RUN mkdir /shares && \
    chown public:public /shares && \
    chmod 755 /shares

RUN dnf --setopt=install_weak_deps=False --best -y upgrade && \
    dnf --setopt=install_weak_deps=False --best -y install samba && \
    dnf clean all

COPY smb.conf /etc/samba/

EXPOSE 445

VOLUME /shares

CMD ["smbd", "-FSi", "-d", "2"]
