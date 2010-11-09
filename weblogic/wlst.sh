# #################################################################
# $Revision: 8270 $:
# $Author: olivier.deruelle $:
# $Date: 2009-09-25 14:13:11 +0700 (Fri, 25 Sep 2009) $:
# $HeadURL: http://svn01.erapidsuite.com:999/svn/dev/swiftsuite/swiftconfigurator/branches/core/v1.2.1/resource/swiftconfigurator_config/wlst.sh $:
# $Id: wlst.sh 8270 2009-09-25 07:13:11Z olivier.deruelle $:
# #################################################################

#!/bin/bash
export WLHOME=/opt/apps/wl10mp3/bea/wlserver_10.3
export JAVA_HOME=/opt/java1.6
export CLASSPATH="${WLHOME}/server/lib/weblogic.jar:${WLHOME}/common/eval/pointbase/lib/pbembedded57.jar:${WLHOME}/common/eval/pointbase/lib/pbtools57.jar:${WLHOME}/common/eval/pointbase/lib/pbclient57.jar"
$JAVA_HOME/bin/java weblogic.WLST 

# set up common environment
. "${WL_HOME}/server/bin/setWLSEnv.sh" > /dev/null 2>&1

${JAVA_HOME}/bin/java -Dprod.props.file=${WL_HOME}/.product.properties weblogic.WLST $* 

