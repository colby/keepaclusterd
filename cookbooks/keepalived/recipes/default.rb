package %w(keepalived htop)
service = 'keepalived'

cookbook_file '/etc/keepalived/transition.sh' do
    cookbook 'keepalived'
    source   'transition.sh'
    owner    'root'
    group    'root'
    mode     '0774'
    action   :create
end

template '/etc/keepalived/ips.conf' do
    cookbook 'keepalived'
    source   'ips.conf.erb'
    owner    'root'
    group    'root'
    mode     '0664'
    notifies :restart, "service[#{service}]", :delayed
end

template '/etc/keepalived/keepalived.conf' do
    cookbook 'keepalived'
    source   'keepalived.conf.erb'
    owner    'root'
    group    'root'
    mode     '0664'
    notifies :restart, "service[#{service}]", :delayed
end

service service do
    action [:enable, :start]
end
