#
# Cookbook:: beats
# Recipe:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

apt_update 'update_sources' do
  action :update
end

execute "elasticsearch key" do
  command 'wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -'
end

execute "install filebeat" do
  command 'echo "deb https://artifacts.elastic.co/packages/5.x/apt stable main" | sudo tee -a /etc/apt/sources.list.d/elastic-5.x.list'
end

execute "update all" do
  command "sudo apt-get update"
end

execute "install filebeat" do
  command 'apt-get install filebeat -y'
end

service 'filebeat' do
  supports status: true, restart: true, reload: true
  action [:enable, :start]
end

template '/etc/filebeat/filebeat.yml' do
  source 'filebeat.yml.erb'
  notifies :restart, 'service[filebeat]'
end

execute "start filebeat" do
  command "sudo service filebeat start"
end
