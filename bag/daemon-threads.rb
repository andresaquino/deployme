#!/usr/bin/env ruby 
# vim: set ts=2 sw=2 sts=2 et si ai: 
# 
# daemon-threads.rb -- put here a short description 
# = 
# Copyright (c) 2010
# Andres Aquino <andres.aquino@gmail.com>
# 
# Licensed under the BSD Licence:
# http://creativecommons.org/licenses/BSD/


require 'rubygems'
require 'bundler/setup'
require 'robustthread'
require 'log4r'

logger = Log4r::Logger.new('logger')
logfile = Log4r::FileOutputter.new('fileOutputter', :filename => __FILE__+'.log',:trunc => false)
logfile.formatter = Log4r::PatternFormatter.new(:pattern => '%d [%l]: %m', :date_pattern => '%a %d %b %H:%M %p %Y')
logger.add(logfile)
logger.level = Log4r::DEBUG


logger.debug('Starting daemon ')
RobustThread.logger = logger
RobustThread.exception_handler do |exception|
  exit
end

pid = fork do
  RobustThread.loop(:seconds => 5, :label => "Do something awesome!") do
    logger.debug('hey look that!')
  end
  sleep
end
Process.detach pid

# 
