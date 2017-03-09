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
end
