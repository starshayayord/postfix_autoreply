# postfix_autoreply
Simple postfix autoreply script.
### Installation
Add user for filter execution, make directory. Finally, you need to copy .pl script and .html message to /var/spool/filter and grant execution rights,
```sh
useradd -r -c "Postfix Filters" -d /var/spool/filter filter
mkdir /var/spool/filter
ls /var/spool/filter/
  autoreply.pl  body.html
chown filter:filter /var/spool/filter -R
chmod 750 /var/spool/filter -R
```
Fix virtual maps to redurect message to special virtual domain:
```sh
cat /etc/postfix/virtual
  noreply@e-kontur.ru     noreply@autoreply.e-kontur.ru
postmap virtual
```
Fix transport to redirect messages from specila domain to filter-relay:
```sh
cat /etc/postfix/virtual
  autoreply.e-kontur.ru autoreply:
postmap transport
```
Enable this settings in main.cf:
```sh
virtual_alias_maps = hash:/etc/postfix/virtual
transport_maps =  hash:/etc/postfix/transport
```
Add filter to master.cf
```sh
autoreply unix  -       n       n       -       -       pipe
   flags=F user=filter     argv=/var/spool/filter/autoreply.pl ${sender} ${recipient}
```
Restart postfix
```sh
service postfix restart
```
