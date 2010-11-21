#!/usr/bin/env ruby 
# vim: set ts=2 sw=2 sts=2 et si ai: 
# 
# test-log4r.rb -- put here a short description 
# = 
# Copyright (c) 2010
# Andres Aquino <andres.aquino@gmail.com>
# 
# Licensed under the BSD Licence:
# http://creativecommons.org/licenses/BSD/

# bundler gems encapsulated
require 'rubygems'
require 'yaml'
require 'bundler/setup'
require 'log4r'
require 'log4r/configurator'

# configure logging
Log4r::Configurator['logpath'] = './logs'
#Configurator.load_xml_file('log4r_config.xml')
Log4r::Configurator.load_xml_file('log4r_config.xml')
  
log = Log4r::Logger["MainLogger"]
log.warn("warning")
log.debug("debug")

# 
