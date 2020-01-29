# Gets latest release of kali rolling from their repo
FROM registry.gitlab.com/kalilinux/build-scripts/kali-docker/kali-rolling
# Maintainer nick
MAINTAINER aJesus37
# Supresses some warnings during package update/install phase
ENV DEBIAN_FRONTEND noninteractive
# Make ports available to be published on runtime
EXPOSE 1337/tcp
EXPOSE 1338/tcp
EXPOSE 1339/tcp
EXPOSE 1340/tcp
# Set the workdir to the root's home
WORKDIR /root
# Set default shell for docker build
SHELL ["/bin/bash", "-c"]
# Adds zeek's repositories to SO
RUN echo 'deb http://download.opensuse.org/repositories/security:/zeek/Debian_9.0/ /' > \
/etc/apt/sources.list.d/security:zeek.list && \
wget -nv https://download.opensuse.org/repositories/security:zeek/Debian_9.0/Release.key \
-O Release.key && apt-key add - < Release.key
# Update packages on OS
RUN apt update && apt dist-upgrade -yqq
# Enable wireshark to be installed non-interactively
RUN echo "wireshark-common wireshark-common/install-setuid boolean true" | debconf-set-selections
# Install hacking tools from kali meta-packages and repos
RUN apt install -yqq kali-tools-headless 0trace hping3 \
masscan dnsenum dnsmap nbtscan dnsrecon theharvester  \
ncat dnswalk enum4linux fierce onesixtyone recon-ng smbmap \
smtp-user-enum nikto openvas dirb dotdotpwn proxychains \
wpscan rarcrack crunch mimikatz hash-identifier hashcat \
hashcat-utils passing-the-hash hashid wordlists set snmpcheck \
exploitdb dnschef tshark powersploit binwalk yara dnstracer \
tcpdump windows-privesc-check 0trace p0f gobuster iputils-ping \
tmux vim openvpn man tftp ftp snmp bash-completion perl-tk \
libterm-readkey-perl wfuzz sshfs exiftool steghide pngcheck \
zeek fping fpdns
# Install linux-smart-enumeration from github
RUN wget "https://raw.githubusercontent.com/diego-treitos/linux-smart-enumeration/master/lse.sh" -O lse.sh
RUN chmod +x lse.sh
RUN mv lse.sh /usr/bin/lse  
# Set root's .bashrc to the skel's default
RUN cp -f /etc/skel/.bashrc /root/.bashrc