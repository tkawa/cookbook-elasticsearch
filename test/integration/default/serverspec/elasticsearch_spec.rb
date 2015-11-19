require 'spec_helper'

describe service('monit') do
  it { should be_enabled }
  it { should be_running }
end

describe service('elasticsearch') do
  it { should be_running }
end

describe command('curl -s localhost:9200') do
  its(:stdout) { should include '"status" : 200,'}
  its(:stdout) { should include '"number" : "1.5.2",'}
end

describe file('/etc/init.d/elasticsearch') do
  it { should be_file }
  its(:content) { should include 'elasticsearch' }
end

describe file('/etc/monit.d/elasticsearch.monitrc') do
  it { should be_file }
  its(:content) { should include 'elasticsearch' }
end

describe file('/data/elasticsearch/config/elasticsearch-env.sh') do
  it { should be_file }
  its(:content) { should include 'elasticsearch' }
end

describe file('/data/elasticsearch/config/elasticsearch.yml') do
  it { should be_file }
  its(:content) { should include 'elasticsearch' }
  its(:content) { should match /^node.master: true/ }
  its(:content) { should match /^node.data: true/ }
  its(:content) { should match /^discovery.zen.minimum_master_nodes: 1/ }
end
