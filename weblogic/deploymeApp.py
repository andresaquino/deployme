#!/usr/bin/env jython 
#  vim: set ts=3 sw=3 sts=3 si ai: 
#  
#	deploymeApp.py
#  -----------------------------------------------------------------------------
#	(c) 2010 
#	Andres Aquino <andres.aquino@gmail.com>
#	All rights reserved.
# 

import sys
from java.lang import System

class deploymeApp:	
	# private
	instance = {}
	
	# public 
	def __init__(self):
		self.instance['user'] = 'admin'
		self.instance['pasw'] = 'nextel123'
		self.instance['wurl'] = 't3://10.103.12.151:7001'
	
	def connect(self):
		try:
			connect(self.instance['user'], self.instance['pasw'], self.instance['wurl'])
			edit()
			startEdit()
			cd('Servers/AdminServer')
			set('Notes','Hey, look this information')
			save()
			activate(block="true")
		except:
			print('Cannot connect to these server')
	
	def getInformation(self):
		print get('RootDirectory')
	

#if __name__ == "__main__":
server = deploymeApp()
server.connect()
server.getInformation()

#
