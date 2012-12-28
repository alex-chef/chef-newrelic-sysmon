#
# Cookbook Name:: newrelic_sysmon
# Recipe:: default
#
# Copyright 2012, Binary Marbles Trond Arve Nordheim
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

execute "apt-get update" do
  action :nothing
end

apt_repository "newrelic" do
  uri "http://apt.newrelic.com/debian/"
  distribution "newrelic"
  components ["non-free"]
  keyserver "subkeys.pgp.net"
  key "548C16BF"
  action :add
  notifies :run, "execute[apt-get update]", :immediately
end

package "newrelic-sysmond" do
  action :install
end

service "newrelic-sysmond" do
  action :enable
end

execute "configure newrelic-sysmond" do
  command "nrsysmond-config --set license_key=#{node[:newrelic_sysmon][:license_key]}"
  not_if "grep license_key=#{node[:newrelic_sysmon][:license_key]} /etc/newrelic/nrsysmond.cfg"
  notifies :restart, resources(:service => "newrelic-sysmond")
end

service "newrelic-sysmond" do
  action :start
end
