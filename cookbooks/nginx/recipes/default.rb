package %w(nginx)
service = 'nginx'

template '/etc/nginx/sites-available/default' do
    source   'vhost.conf.erb'
    owner    'root'
    group    'root'
    mode     '0664'
    notifies :restart, "service[#{service}]", :delayed
    action   :create
end

template '/var/www/html/index.html' do
    source 'index.html.erb'
    owner  'root'
    group  'root'
    mode   '0664'
    action :create
end

service service do
    action [:enable, :start]
    # FIXME: prevent failure, rather than ignore it
    # NOTE: if a node is not keepalived master, nginx will fail on binding to the VIP
    ignore_failure true
end
