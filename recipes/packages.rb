#-*- encoding : utf-8 -*-
package 'curl' do
  action :install
end

package 'tree' do
  action :install
end

package 'monit'
service 'monit' do
  action [:enable, :start]
end
