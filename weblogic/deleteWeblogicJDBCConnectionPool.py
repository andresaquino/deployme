#----------------------------------------------------------------------
# $Revision: 7876 $:
# $Author: john.snell $:
# $Date: 2009-09-03 09:48:29 +0700 (Thu, 03 Sep 2009) $:
# $HeadURL: http://svn01.erapidsuite.com:999/svn/dev/swiftsuite/swiftconfigurator/branches/core/v1.2.1/resource/swiftconfigurator_config/deleteWeblogicJDBCConnectionPool.py $:
# $Id: deleteWeblogicJDBCConnectionPool.py 7876 2009-09-03 02:48:29Z john.snell $:
#----------------------------------------------------------------------

import sys
from java.lang import System

def init (admin_user, admin_password, admin_url):
    connect(admin_user, admin_password, admin_url)
    edit()
    startEdit()

def removeJDBC(jndiName, printDebug):

    if printDebug:
        print("")
        print("*** Deleting JDBC Pool:")

        print("   jndiName = " + jndiName)

    delete(jndiName, "JDBCSystemResource")
    save()
    activate(block="true")

