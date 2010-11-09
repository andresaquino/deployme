#----------------------------------------------------------------------
# $Revision: 7052 $:
# $Author: john.snell $:
# $Date: 2009-07-17 14:34:03 +0700 (Fri, 17 Jul 2009) $:
# $HeadURL: http://svn01.erapidsuite.com:999/svn/dev/swiftsuite/swiftconfigurator/branches/core/v1.2.1/resource/swiftconfigurator_config/createDomain.py $:
# $Id: createDomain.py 7052 2009-07-17 07:34:03Z john.snell $:
#----------------------------------------------------------------------

#=======================================================================================
# Open a domain template.
#=======================================================================================

admin_password  = sys.argv[1]

bea_home        = sys.argv[2]
bea_domain_home = sys.argv[3]
domain_name     = sys.argv[4]
server_name     = sys.argv[5]

readTemplate(bea_home + "/wlserver_10.3/common/templates/domains/wls.jar")

#=======================================================================================
# Configure the Administration Server and SSL port.
#
# To enable access by both local and remote processes, you should not set the
# listen address for the server instance (that is, it should be left blank or not set).
# In this case, the server instance will determine the address of the machine and
# listen on it.
#=======================================================================================

cd("Servers/" + server_name)
set('ListenAddress','')
set('ListenPort', 7001)

create(server_name,'SSL')
cd("SSL/" + server_name)
set('Enabled', 'True')
set('ListenPort', 7002)

#=======================================================================================
# Define the user password for weblogic.
#=======================================================================================

cd('/')
cd('Security/base_domain/User/weblogic')
cmo.setPassword(admin_password)

#=======================================================================================
# Create a JMS Server.
#=======================================================================================

cd('/')
create('myJMSServer', 'JMSServer')

#=======================================================================================
# Create a JMS System resource.
#=======================================================================================

cd('/')
create('myJmsSystemResource', 'JMSSystemResource')
cd('JMSSystemResource/myJmsSystemResource/JmsResource/NO_NAME_0')

#=======================================================================================
# Create a JMS Queue and its subdeployment.
#=======================================================================================

myq=create('myQueue','Queue')
myq.setJNDIName('jms/myqueue')
myq.setSubDeploymentName('myQueueSubDeployment')

cd('/')
cd('JMSSystemResource/myJmsSystemResource')
create('myQueueSubDeployment', 'SubDeployment')



#=======================================================================================
# Target resources to the servers.
#=======================================================================================

cd('/')
assign('JMSServer', 'myJMSServer', 'Target', server_name)
assign('JMSSystemResource.SubDeployment', 'myJmsSystemResource.myQueueSubDeployment', 'Target', 'myJMSServer')

#=======================================================================================
# Write the domain and close the domain template.
#=======================================================================================

setOption('OverwriteDomain', 'true')
writeDomain(bea_domain_home + "/" + domain_name)
closeTemplate()

#=======================================================================================
# Exit WLST.
#=======================================================================================

exit()
