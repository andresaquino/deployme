#!/usr/bin/env ruby 
# vim: set ts=2 sw=2 sts=2 et si ai: 
# 
# read-directory.rb -- put here a short description 
# = 
# Copyright (c) 2010
# Andres Aquino <andres.aquino@gmail.com>
# 
# Licensed under the BSD Licence:
# http://creativecommons.org/licenses/BSD/

require 'find'

myPath='/Users/andresaquino/Dropbox/nextel.com.mx/deployme.git/setup/VERSIONES'
Find.find(myPath) do |path|
  if FileTest.directory?(path)
    puts("See: " + path)
  end

end

# 
