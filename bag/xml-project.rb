#!/usr/bin/env ruby

# xml-project.rb -- put here a short description 
# ----------------------------------------------------------------------------
# (c) 2010
# Andres Aquino <andres.aquino@gmail.com>
# All rights reserved.
# 

require 'rubygems'
require 'xmlsimple'

project = File.open("/Users/andresaquino/Dropbox/nextel.com.mx/deployme.git/setup/noe-project.xml",File::RDONLY)

data = XmlSimple.xml_in(xml_data)

data['Result'].each do |item|
  item.sort.each do |k, v|
    if ["Title", "Url"].include? k
      print "#{v[0]}" if k=="Title"
      print " => #{v[0]}\n" if k=="Url"
    end
  end
end



# vim: set ts=2 sw=2 sts=2 et si ai: 
