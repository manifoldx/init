#!/bin/sh
export PATH="$HOME/bin:$PATH";
 
# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;
 
# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;
 
# Append to the Bash history file, rather than overwriting it
shopt -s histappend;
 
sudo yum install tuned -y
sudo systemctl start tuned
sudo systemctl enable tuned
sudo tuned-adm profile throughput-performance
tuned-adm active

# NTP Config
sudo yum -y install ntp || true
sudo sed -i '/^server/d' /etc/ntp.conf
sudo tee -a /etc/ntp.conf << EOF
server time1.google.com iburst
server time2.google.com iburst
server time3.google.com iburst
server time4.google.com iburst
EOF
sudo systemctl restart ntp &> /dev/null || true
sudo systemctl restart ntpd &> /dev/null || true
sudo service ntp restart &> /dev/null || true
sudo service ntpd restart &> /dev/null || true
sudo restart ntp &> /dev/null || true
sudo restart ntpd &> /dev/null || true
ntpq -p
 
# TCP Config
sudo sh -c 'echo "* hard nofile 100000" >> /etc/security/limits.conf'
sudo sh -c 'echo "* soft nofile 100000" >> /etc/security/limits.conf'
sudo sh -c 'echo "root hard nofile 100000" >> /etc/security/limits.conf'
sudo sh -c 'echo "root soft nofile 100000" >> /etc/security/limits.conf
