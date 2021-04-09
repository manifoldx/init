# [init](#)

> gnu/linux configuration

#### setuid / SUID
this allows a user to execute a binary with the privileges of the
binary's owner. This is often used to allow unprivileged users to utilize
certain functionality that is normally only reserved for the root user. As such,
many SUID binaries have a history of privilege escalation security
vulnerabilities. setgid / SGID is similar but for groups rather than users. To
find all binaries on the system with the setuid or setgid bit, execute:

```bash
find / -type f \( -perm -4000 -o -perm -2000 \)
```
You should then remove any unnecessary setuid / setgid bits on programs you
don't use, or, replace them with capabilities.

To remove the setuid bit, execute:

```bash
chmod u-s $path_to_program
```

To remove the setgid bit, execute:

```bash
chmod g-s $path_to_program
```

To add a capability to the file instead, execute:

```bash
setcap $capability+ep $path_to_program
```
Or, to remove an unnecessary capability, execute:
```bash
setcap -r $path_to_program
