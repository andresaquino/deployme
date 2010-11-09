#----------------------------------------------------------------------
# $Revision: 7052 $:
# $Author: john.snell $:
# $Date: 2009-07-17 14:34:03 +0700 (Fri, 17 Jul 2009) $:
# $HeadURL: http://svn01.erapidsuite.com:999/svn/dev/swiftsuite/swiftconfigurator/branches/core/v1.2.1/resource/swiftconfigurator_config/createWeblogicUser.py $:
# $Id: createWeblogicUser.py 7052 2009-07-17 07:34:03Z john.snell $:
#----------------------------------------------------------------------

import sys
from java.lang import System
from weblogic.management.security.authentication import UserEditorMBean

def init (admin_user, admin_password, admin_url):
    connect(admin_user, admin_password, admin_url)

def addUser(name, password, printDebug):
    if printDebug:
        print("*** Creating User with userName = " + name)
    atnr=cmo.getSecurityConfiguration().getDefaultRealm().lookupAuthenticationProvider("DefaultAuthenticator")
    atnr.createUser(name,password,'Created for SwiftConfigurator')

