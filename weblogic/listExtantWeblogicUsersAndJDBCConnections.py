#----------------------------------------------------------------------
# $Revision: 7929 $:
# $Author: john.snell $:
# $Date: 2009-09-04 18:09:24 +0700 (Fri, 04 Sep 2009) $:
# $HeadURL: http://svn01.erapidsuite.com:999/svn/dev/swiftsuite/swiftconfigurator/branches/core/v1.2.1/resource/swiftconfigurator_config/listExtantWeblogicUsersAndJDBCConnections.py $:
# $Id: listExtantWeblogicUsersAndJDBCConnections.py 7929 2009-09-04 11:09:24Z john.snell $:
#----------------------------------------------------------------------

def init (admin_user, admin_password, admin_url):
    connect(admin_user, admin_password, admin_url)

def listExtantWeblogicUsersAndJDBCConnections(userNamePrefix, userListFileName, jdbcListFileName):
    atnr=cmo.getSecurityConfiguration().getDefaultRealm().lookupAuthenticationProvider("DefaultAuthenticator")
    searchMask = "".join([userNamePrefix, "*"])
    cursor = atnr.listUsers(searchMask,0);

    userListFile = open(userListFileName,'w')
    while atnr.haveCurrent(cursor):
        userListFile.write(atnr.getCurrentName(cursor))
        userListFile.write("\n")
        atnr.advance(cursor)
    atnr.close(cursor)
    userListFile.close()

    cd('JDBCSystemResources')
    redirect(jdbcListFileName)
    ls()
    stopRedirect()

