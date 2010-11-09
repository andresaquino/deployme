# #################################################################
# $Revision: 8482 $:
# $Author: olivier.deruelle $:
# $Date: 2009-10-12 17:28:11 +0700 (Mon, 12 Oct 2009) $:
# $HeadURL: http://svn01.erapidsuite.com:999/svn/dev/swiftsuite/swiftconfigurator/branches/core/v1.2.1/resource/swiftconfigurator_config/start_weblogic.sh $:
# $Id: start_weblogic.sh 8482 2009-10-12 10:28:11Z olivier.deruelle $:
# #################################################################
#/bin/bash

export USER_MEM_ARGS="-Xmx512m -XX:MaxPermSize=148m"

export WLS_REDIRECT_LOG="/home/weblogic/Oracle/Middleware/rapid_solutions/domains/primaryDomain/serverlog.txt"

nohup /home/weblogic/Oracle/Middleware/rapid_solutions/domains/primaryDomain/startWebLogic.sh &

