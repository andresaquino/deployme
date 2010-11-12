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

uat = {}
uat['mexhplwx'] = { 'user' => 'devapp', 'host' => '10.103.12.151'}
#uat['mxhpdmar'] = { 'user' => 'usrapp', 'host' => '10.103.12.119'}
#uat['mxhpucci'] = { 'user' => 'web8sp6', 'host' => '10.103.12.142'}
#uat['mxhpusc2'] = { 'user' => 'weblogi9', 'host' => '10.103.12.144'}

logger = Log4r::Logger.new('logger')
logger.outputters = Log4r::Outputter.stdout
format = Log4r::PatternFormatter.new(:pattern => "[%l] %d :: %m")
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
  out = session.exec!('ls -l')
  puts out
  session.scp.download!('gitcompletion.bash', 'git.completions')
  session.close

  #  puts 'Uploading VERSION to ' + server['user'] + '@' + server['host'] + ':/opt/apps/nxtcomp'
  #  session.upload!('~/Dropbox/nextel.com.mx/deployme.git/VERSION', '/opt/apps/nxtcomp/')
  #  session.loop
  
end





