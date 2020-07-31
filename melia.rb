#!/usr/bin/env ruby

require 'oktakit'
require 'slop'

require_relative 'config/config.rb'
require_relative 'idp/okta.rb'

opts = Slop.parse do |option|
  option.string '-p', '--path', 'Path to configuration file'
  option.on '--help', 'Print help action'
end

if ARGV.empty? || opts[:help]
  puts opts
end

config = Configuration.new
configFile = config.loadConfig(opts[:path].to_s)

if configFile["IDP"] != "Okta"
  abort("Only Okta is currently supported as an IDP")
end

okta = Okta.new
client = okta.createClient(configFile["APIKEY"], configFile["ORGANIZATION"])
userList = okta.getUserList(client)

puts userList.inspect

userList.each do |user|
  status = okta.isUserApproved(client, user, configFile)
  next if status.eql? "true"

end


