#!/usr/bin/env ruby 
# vim: set ts=2 sw=2 sts=2 et si ai: 
  
# deploymeApp.rb
# =
#	Copyright (c) 2010
#	Andres Aquino <andres.aquino@gmail.com>
#

# bundler gems encapsulated
require 'rubygems'
require 'bundler/setup'
require 'net/ssh'

uat = {}
uat['mxhpdmar'] = { 'user' => 'usrapp', 'ip' => '10.103.12.119'}
uat['mxhpucci'] = { 'user' => 'web8sp6', 'ip' => '10.103.12.142'}
uat['mxhpusc2'] = { 'user' => 'weblogi9', 'ip' => '10.103.12.144'}

uat.each do |host, server|
  puts 'Connectingo to: ' + server['user'] + '@' + server['ip']
  Net::SSH.start( server['ip'], server['user'] ) do |session|
    session.exec!('cd /opt/apps/nxtcomp')
    puts session.exec!('ls -l')
    session.loop
  end
  
end





