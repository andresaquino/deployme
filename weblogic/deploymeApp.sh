#!/bin/sh 
# vim: set ts=2 sw=2 sts=2 et si ai: 

# deploymeApp.sh 
# ----------------------------------------------------------------------------
# (c) 2010 
# Andres Aquino <andres.aquino@gmail.com>
# All rights reserved.
# 

export WLHOME=/opt/apps/wl10mp3/bea/wlserver_10.3
export JAVA_HOME=/opt/java1.6
export CLASSPATH="${WLHOME}/server/lib/weblogic.jar:${WLHOME}/common/eval/pointbase/lib/pbembedded57.jar:${WLHOME}/common/eval/pointbase/lib/pbtools57.jar:${WLHOME}/common/eval/pointbase/lib/pbclient57.jar:${HOME}/deployme.git/weblogic/classes/mysql-connector-java-5.0.4-bin.jar:${HOME}/deployme.git/weblogic/classes/postgresql-8.4-702.jdbc3.jar:${HOME}/deployme.git/weblogic/classes/postgresql-8.4-702.jdbc4.jar"

# set up common environment
. "${WLHOME}/server/bin/setWLSEnv.sh" > /dev/null 2>&1

#${JAVA_HOME}/bin/java -Dprod.props.file=${WL_HOME}/.product.properties weblogic.WLST $* 
${JAVA_HOME}/bin/java weblogic.WLST deploymeApp.py 

