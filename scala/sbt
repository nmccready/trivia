#!/bin/sh
test -f ~/.sbtconfig && . ~/.sbtconfig
exec java -Xms1024m -Xmx1024m -Xmx1024M -Xss1M -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=1G ${SBT_OPTS} -jar ./sbt-launch.jar "$@"
