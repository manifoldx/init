#!/bin/sh
# Linux Paranoia - Security Settings 
// randomizes page allocator freelists,
page_alloc.shuffle=1

//  enables Kernel Page Table Isolation which mitigates Meltdown and prevents some KASLR bypasses. 
pti=on

// disables vsyscalls as they are obsolete and have been replaced with vDSO
vsyscall=none

// only signed kernal modules
module.sig_enforce=1

// LSM mode
lockdown=confidentiality

// disable webcam
install uvcvideo /bin/false

// debian dont be retarded
// see: https://manpages.debian.org/buster/dpkg/dpkg-statoverride.1.en.html
chmod 700 /home/$user
chmod 700 /boot /usr/src /lib/modules /usr/lib/modules
