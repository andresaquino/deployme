#!/usr/bin/env ruby 
# vim: set ts=2 sw=2 sts=2 et si ai: 
  
# deploymeApp.rb
# =
# Copyright (c) 2010
# Andres Aquino <andres.aquino@gmail.com>
#

# bundler gems encapsulated
require 'rubygems'
require 'yaml'
require 'bundler/setup'
require 'log4r'
require 'log4r/yamlconfigurator'

log4rconf = YAML::load_file('log4r.conf')



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

