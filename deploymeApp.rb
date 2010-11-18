#!/usr/bin/env ruby 
# vim: set ts=2 sw=2 sts=2 et si ai: 
  
# deploymeApp.rb
# =
#	Copyright (c) 2010
#	Andres Aquino <andres.aquino@gmail.com>
#

# bundler gems encapsulated
require 'rubygems'
require 'bundler/setup'
require 'log4r'
require 'net/ssh'
require 'net/scp'
require 'libs/server'

uat = {}
uat['mxhpasa1'] = { 'user' => 'batch', 'host' => '10.103.138.159'}
uat['mexhplwx'] = { 'user' => 'devapp', 'host' => '10.103.12.151'}
uat['mxhpdmar'] = { 'user' => 'usrapp', 'host' => '10.103.12.119'}
uat['mxhpucci'] = { 'user' => 'web8sp6', 'host' => '10.103.12.142'}
uat['mxhpusc2'] = { 'user' => 'weblogi9', 'host' => '10.103.12.144'}

server = Server.new()
server.uid = 'CCI-BTCH-UAT'
server.family = 'CCI'
server.application = 'BATCH'
server.environment = 'UAT'
server.user = 'devapp'
server.host = '10.103.12.119'
server.path = '/opt/apps/nxtcomp/cci'

servers

environment = ['DEV', 'UAT', 'CAP', 'PROD']
servers.each do |server|
  server.sync() if server.has_environment?(environment[1])

end


server = new Server
logger = Log4r::Logger.new('logger')
logger.outputters = Log4r::Outputter.stdout
format = Log4r::PatternFormatter.new(:pattern => '%d [%l]: %m', :date_pattern => '%a %d %b %H:%M %p %Y')
logfile = Log4r::FileOutputter.new('fileOutputter', :filename => 'deploymeApp.log',:trunc => false)
logfile.formatter = format
logger.add(logfile)
logger.level = Log4r::DEBUG

uat.each do |host, server|
  user = server['user']
  host = server['host']
  opts = { :keys => [ '/Users/andresaquino/Dropbox/personal/keys/automagic_at_nextel' ], :logger => @logger }
  
  logger.debug('Connecting to '+host)
  session = Net::SSH.start(host, user, options = opts)
  session.exec!('rm -f ~/git.completions')
  out = session.exec!('ls -l')
  puts out
  #session.scp.upload!('git.completions','git.completions')
  session.close

end

