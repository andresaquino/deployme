#!/usr/bin/env ruby 
# vim: set ts=2 sw=2 sts=2 et si ai: 
# 
# configuration.rb -- read YAML setup for an enviroment
# = 
# Copyright (c) 2010
# Andres Aquino <andres.aquino@gmail.com>
# 
# Licensed under the BSD Licence:
# http://creativecommons.org/licenses/BSD/

require "yaml"

area = "cambios".upcase
stpConfig = YAML::load(File.open("setup/#{area}.yml"))
stp = stpConfig[area]

puts stp["NOE"]["NAME"]


# 
