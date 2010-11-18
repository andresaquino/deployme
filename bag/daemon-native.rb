#!/usr/bin/env ruby 
# vim: set ts=2 sw=2 sts=2 et si ai: 
# 
# daemon-native.rb -- put here a short description 
# = 
# Copyright (c) 2010
# Andres Aquino <andres.aquino@gmail.com>
# 
# Licensed under the BSD Licence:
# http://creativecommons.org/licenses/BSD/

require 'rubygems'
require 'bundler/setup'
require 'daemons'
require 'log4r'

logger = Log4r::Logger.new('logger')
logfile = Log4r::FileOutputter.new('fileOutputter', :filename => File.basename(__FILE__, '.rb')+'.log',:trunc => false)
logfile.formatter = Log4r::PatternFormatter.new(:pattern => '%d [%l]: %m', :date_pattern => '%a %d %b %h:%m %p %y')
logger.add(logfile)
logger.level = Log4r::DEBUG

Daemons.run_proc(
  'background_service', # name of daemon
  #  :dir_mode => :normal
  #  :dir => File.join(pwd, 'tmp/pids'), # directory where pid file will be stored
  #  :backtrace => true,
  #  :monitor => true,
  :log_output => true
) do
  exec "ruby #{file}"
end

# 
