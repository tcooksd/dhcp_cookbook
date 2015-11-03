dhcp_mod Cookbook
=================
TODO: Created to be ran under solo with the add_node script ..

This cookbook 
A. updates /tftpboot/pxelinux.cfg/default adding the ability to choose from all images manually from pxe menu . 
B. updates /etc/dhcp/dhcpd.conf adding additional nodes parsed from attributes and restarts dhcpd 
C. adds host to /var/www/html/pxe/centos/7/ks/hostname.cfg from a template 
D. adds host to /tftpboot/pxelinux.cfg/hostname adding the ability to pre sym link ips in the hex form to auto install when loaded. 

Requirements
------------
dhcpd 
pxe 
tftpboot 
apache 

Attributes
----------
#### dhcp_mod::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['server']['hosts']</tt></td>
    <td>Hash</td>
    <td>hostname mac ip_address perm_ip_address</td>
    <td><tt>false</tt></td>
  </tr>
</table>

Usage
-----
#### dhcp_mod::default
TODO: Write usage instructions for each cookbook.

e.g.
Just include `dhcp_mod` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[dhcp_mod]"
  ]
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

-------------------
Authors: 
Tim Cook tim.cook@hightail.com 
