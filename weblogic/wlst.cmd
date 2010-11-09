@REM  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@
@REM  $Revision: 7912 $:
@REM  $Author: john.snell $:
@REM  $Date: 2009-09-04 11:35:13 +0700 (Fri, 04 Sep 2009) $:
@REM  $HeadURL: http://svn01.erapidsuite.com:999/svn/dev/swiftsuite/swiftconfigurator/branches/core/v1.2.1/resource/swiftconfigurator_config/wlst.cmd $:
@REM  $Id: wlst.cmd 7912 2009-09-04 04:35:13Z john.snell $:
@REM  @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@

set JAVA_HOME=D:\bea\jdk160_05
set CLASSPATH=d:\bea\wlserver_10.3\server\lib\weblogic.jar;
"%JAVA_HOME%\bin\java" weblogic.WLST %*
