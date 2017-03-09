package %w(nginx)
service = 'nginx'

service service do
    action [:enable, :start]
end
