package %w(nginx)
service = 'nginx'

template '/etc/nginx/sites-available/default' do
    source  'vhost.conf.erb'
    owner   'root'
    group   'root'
    mode    '0664'
    notifies :restart, "service[#{service}]", :delayed
end

service service do
    action [:enable, :start]
    # NOTE: if a node is not keepalived master, nginx will fail on binding to
    # the VIP
    ignore_failure true
end
