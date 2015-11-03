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


```json
default['server']['hosts'] = [
  { 'hostname' =>  'host_name', 
    'mac' => 'xx:xx:xx:xx:xx:xx', 
    'ip_address' => '10.x.x.x',
    'perm_address' => '10.x.x.x'
  } 
```


-------------------
Authors: 
Tim Cook tim.cook@hightail.com 
