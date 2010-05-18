# vim: set ts=2 sw=2 sts=2 et si ai: 

# deployme.rb -- put here a short description 
# ----------------------------------------------------------------------------
# (c) 2010 StrategyLabs!
# Andres Aquino <andres.aquino@gmail.com>
# All rights reserved.
# 

require 'rubygems'
require 'daemons'


# principal
class Demonio  
	def initialize  
		Daemons.daemonize  
		loop do  
			f = File.new('/tmp/timestamp', 'a')  
			f.write("#{Time.now}\n")  
			f.close 
			sleep(3)  
		end 
	end  
end  
  
Demonio.new  

# 
