
template '/etc/dhcp/dhcpd.conf' do 
  source 'dhcp.erb'
  owner 'root'
  group 'root' 
  variables( 
    :hosts_to_add => node[:server][:hosts]
  ) 
  action :create 
  notifies :run, 'execute[restart-dhcpd]', :immediately 
end 


execute 'restart-dhcpd' do 
  command 'systemctl restart dhcpd.service'
  action :nothing
end   


template '/tftpboot/pxelinux.cfg/default' do 
  source 'ks.erb'
  owner 'root'
  group 'root' 
  variables( 
    :hosts_to_add => node[:server][:hosts]
  ) 
  action :create 
end


node['server']['hosts'].each do |files|
  template "/tftpboot/pxelinux.cfg/#{files['hostname']}" do  
    source 'ks_main.erb'
    owner 'root'
    group 'root'
    variables( 
      :host_to_add => files['hostname']
    )
    action :create 
  end 
end 


node['server']['hosts'].each do |web_files|
  template "/var/www/html/pxe/centos/7/ks/#{web_files['hostname']}.cfg" do  
    source 'net.erb'
    owner 'root'
    group 'root'
    variables( 
      :host_to_add => web_files['hostname'],
      :host_ip_address => web_files['perm_address']
    )
    action :create 
  end 
end 
