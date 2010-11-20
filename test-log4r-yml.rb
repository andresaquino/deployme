#!/usr/bin/env ruby 
# vim: set ts=2 sw=2 sts=2 et si ai: 
 
# test-log4r.rb 
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
require 'log4r/yamlconfigurator'
require 'log4r/outputter/datefileoutputter'

include Log4r

# configure logging
logger = Log4r::YamlConfigurator
logger['logpath'] = '.'
logger.load_yaml_file('log4r.yml')

@log = Log4r::Logger['deployme']
@log.debug('Estamos revisando la documentacion')
@log.info('Estamos revisando la documentacion')
@log.warn('Estamos revisando la documentacion')
@log.error('Estamos revisando la documentacion')
@log.fatal('Generando fingerprints de cada archivo')

# 
