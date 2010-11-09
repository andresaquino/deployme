#----------------------------------------------------------------------
# $Revision: 7052 $:
# $Author: john.snell $:
# $Date: 2009-07-17 14:34:03 +0700 (Fri, 17 Jul 2009) $:
# $HeadURL: http://svn01.erapidsuite.com:999/svn/dev/swiftsuite/swiftconfigurator/branches/core/v1.2.1/resource/swiftconfigurator_config/deployApp.py $:
# $Id: deployApp.py 7052 2009-07-17 07:34:03Z john.snell $:
#----------------------------------------------------------------------

import sys
from java.lang import System

admin_user     = sys.argv[1]
admin_password = sys.argv[2]
admin_url      = sys.argv[3]
ear_path       = sys.argv[4]
server_name    = sys.argv[5]

connect(admin_user, admin_password, admin_url)

edit()
startEdit()

application_name = 'swiftconfigurator'

deploy(application_name, ear_path, targets=server_name, timeout=120000, securityModel='Advanced', upload='true', stageMode='stage', gracefulProductionToAdmin='true')

save()
activate(block="true")
