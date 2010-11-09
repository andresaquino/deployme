#----------------------------------------------------------------------
# $Revision: 8504 $:
# $Author: olivier.deruelle $:
# $Date: 2009-10-14 10:03:49 +0700 (Wed, 14 Oct 2009) $:
# $HeadURL: http://svn01.erapidsuite.com:999/svn/dev/swiftsuite/swiftconfigurator/branches/core/v1.2.1/resource/swiftconfigurator_config/createWeblogicJDBCConnectionPool.py $:
# $Id: createWeblogicJDBCConnectionPool.py 8504 2009-10-14 03:03:49Z olivier.deruelle $:
#----------------------------------------------------------------------

import sys
from java.lang import System

def init (admin_user, admin_password, admin_url):
    connect(admin_user, admin_password, admin_url)
    edit()
    startEdit()

def addJDBC(schemaName, schemaPassword, dbServerName, dbServerPort, sid, jndiName, saveAndActivate, printDebug):

    if printDebug:
        print("")
        print("*** Creating JDBC Pool:")

        print("   schemaName = " + schemaName)
        print("   schemaPassword = " + schemaPassword)
        print("   dbServerName = " + dbServerName)
        print("   dbServerPort = " + dbServerPort)
        print("   sid = " + sid)
        print("   jndiName = " + jndiName)

    servermb=getMBean("Servers/AdminServer")
    serverPath = "/Servers/AdminServer"
    jdbcPoolName = jndiName
    databaseURL = "".join(["jdbc:oracle:thin:@", dbServerName, ":", dbServerPort, ":", sid])
    driverName = "oracle.jdbc.OracleDriver"

    jdbcSystemResource = create(jdbcPoolName, "JDBCSystemResource")
    myFile = jdbcSystemResource.getDescriptorFileName()
    if printDebug:
        print ("HERE IS THE JDBC FILE NAME: " + myFile)

    jdbcResource = jdbcSystemResource.getJDBCResource()
    jdbcResource.setName(jdbcPoolName)

    # Create the DataSource Params
    dpBean = jdbcResource.getJDBCDataSourceParams()
    dpBean.setJNDINames([jndiName])

    # Create the Driver Params
    drBean = jdbcResource.getJDBCDriverParams()
    drBean.setPassword(schemaPassword)
    drBean.setUrl(databaseURL)
    drBean.setDriverName(driverName)

    propBean = drBean.getProperties()
    driverProps = Properties()
    driverProps.setProperty("user",schemaName)
    driverProps.setProperty("portNumber",dbServerPort)
    driverProps.setProperty("SID",sid)
    driverProps.setProperty("serverName",dbServerName)

    e = driverProps.propertyNames()
    while e.hasMoreElements() :
        propName = e.nextElement()
        myBean = propBean.createProperty(propName)
        myBean.setValue(driverProps.getProperty(propName))

    # Create the ConnectionPool Params
    ppBean = jdbcResource.getJDBCConnectionPoolParams()
    ppBean.setInitialCapacity(0)
    ppBean.setMaxCapacity(15)
    ppBean.setCapacityIncrement(1)
    ppBean.setTestTableName("SQL SELECT 1 FROM DUAL")
    ppBean.setTestFrequencySeconds(120)
    ppBean.setShrinkFrequencySeconds(120)
    ppBean.setTestConnectionsOnReserve(1)
    #2 hours = 2 * 60 * 60 = 7200
    ppBean.setStatementTimeout(7200)
    #removing statement cache due to memory overhead; plan to reinstitute in next release
    ppBean.setStatementCacheSize(10)

    # Adding KeepXaConnTillTxComplete to help with in-doubt transactions.
    xaParams = jdbcResource.getJDBCXAParams()
    xaParams.setKeepXaConnTillTxComplete(1)

    # Add Target
    jdbcSystemResource.addTarget(getMBean(serverPath))

    if saveAndActivate :
        save()
        activate(block="true")

