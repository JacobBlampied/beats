#
# Cookbook:: beats
# Spec:: default
#
# Copyright:: 2018, The Authors, All Rights Reserved.

require 'spec_helper'

describe 'beats::default' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::SoloRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it "runs apt get update" do
      expect(chef_run).to update_apt_update 'update_sources'
    end

    it "should create file filebeat.yml in /etc/filebeat/" do
      expect(chef_run).to create_template('/etc/filebeat/filebeat.yml')
    end

    it 'should enable the filebeat service' do
      expect(chef_run).to enable_service "filebeat"
    end

    it 'should start the filebeat service' do
      expect(chef_run).to start_service "filebeat"
    end
  end

end
