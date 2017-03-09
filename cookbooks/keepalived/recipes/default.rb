package %w(keepalived htop ssmtp)
service = 'keepalived'

slave = node['hostname'].include? 'slave'

if slave
    priority = node['hostname'][-1].to_i * 100
else
    priority = 100
end

cookbook_file '/etc/keepalived/transition.sh' do
    source  'transition.sh'
    owner   'root'
    group   'root'
    mode    '0774'
    action  :create
end

cookbook_file '/etc/keepalived/sanitycheck.sh' do
    source  'sanitycheck.sh'
    owner   'root'
    group   'root'
    mode    '0774'
    action  :create
end

template '/etc/keepalived/ips.conf' do
    source  'ips.conf.erb'
    owner   'root'
    group   'root'
    mode    '0664'
    notifies :restart, "service[#{service}]", :delayed
end

template '/etc/keepalived/keepalived.conf' do
    source  'keepalived.conf.erb'
    owner   'root'
    group   'root'
    mode    '0664'
    notifies :restart, "service[#{service}]", :delayed
end

service service do
    action [:enable, :start]
end
