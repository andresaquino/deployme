#!/usr/bin/env ruby 
# vim: set ts=2 sw=2 sts=2 et si ai: 
# 
# syncme.rb -- put here a short description 
# =
#	Copyright (c) 2010
#	Andres Aquino <andres.aquino@gmail.com>
#

# bundler gems encapsulated
require 'rubygems'
require 'bundler/setup'
require 'net/ssh'
require 'net/sftp'
require 'find'
require 'digest'

#
# syncme
# syncme --from=/opt/apps/nxtcomps --to=usrapp@10.103.12.144:/opt/apps/nxtcomps

source='/Users/andresaquino/Public/NEXTEL/UniversidadNextel.git'
destiny='/opt/devapp/temp'
user='devapp'
host='10.103.12.151'
opts = { :keys => [ '/Users/andresaquino/Dropbox/personal/keys/automagic_at_nextel' ] }

contents = {}
print 'Indexing source : '
Find.find(source) do |path|
  if FileTest.file?(path)
    psource, fsource = path.split(source)
    md5source = Digest::MD5.hexdigest(path)
    contents[md5source] = fsource
    print('.')
  end
end

session = Net::SSH.start(host, user, options = opts)
session.sftp.upload!(source, destiny) do |event, uploader, *args|
  case event
  when :open then
    # args[0] : file metadata
    puts "starting upload: #{args[0].local} -> #{args[0].remote} (#{args[0].size} bytes}"
  when :put then
    # args[0] : file metadata
    # args[1] : byte offset in remote file
    # args[2] : data being written (as string)
    puts "writing #{args[2].length} bytes to #{args[0].remote} starting at #{args[1]}"
  when :close then
    # args[0] : file metadata
    puts "finished with #{args[0].remote}"
  when :mkdir then
    # args[0] : remote path name
    puts "creating directory #{args[0]}"
  when :finish then
    puts "all done!"
  end
end
session.close


# 
