# # encoding: utf-8

# Inspec test for recipe beats::default

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe service 'filebeat' do
  it {should be_running}
  it {should be_enabled}
end

# describe port(5044) do
#   it {should be_sending}
# end

describe port(5044) do
  its('protocols') { should include 'tcp' }
end
