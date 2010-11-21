#!/usr/bin/env ruby 
# vim: set ts=2 sw=2 sts=2 et si ai: 
# 
# test.rb -- put here a short description 
# = 
# Copyright (c) 2010
# Andres Aquino <andres.aquino@gmail.com>
# 
# Licensed under the BSD Licence:
# http://creativecommons.org/licenses/BSD/
require 'rubygems'
require 'yaml'
require 'bundler/setup'
require 'log4r'
require 'log4r/yamlconfigurator'

y = "log4r_config:

  # define all loggers ...
  loggers:
    - name      : production
      level     : INFO
      trace     : 'false'
      outputters:
        - stdout

  # define all outputters (incl. formatters)      
  outputters:
    - type     : StdoutOutputter
      name     : stdout
      formatter:
        date_pattern: '%Y-%m-%d %H:%M:%S'
        pattern     : '%d %l: #\{TEST\} %m '
        type        : PatternFormatter"

h = YAML.load y
log_cfg = Log4r::YamlConfigurator
log_cfg['TEST'] = 'foobar'
log_cfg.decode_yaml h['log4r_config']
@log = Logger['production']
@log.info 'test'

# 
