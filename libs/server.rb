#!/usr/bin/env ruby 
# vim: set ts=2 sw=2 sts=2 et si ai: 
  
# server.rb
# =
#	Copyright (c) 2010
#	Andres Aquino <andres.aquino@gmail.com>
#

class Server
  attr_accessor :ipaddress
  attr_accessor :user

  def initialize(ipaddress = nil, user = nil)
    @ipaddress = ipaddress
    @user = user
  end


end

