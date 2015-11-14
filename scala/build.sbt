// ideaExcludeFolders += ".idea"
//
// ideaExcludeFolders += ".idea_modules"

resolvers += "Sonatype snapshots" at "http://oss.sonatype.org/content/repositories/releases/"

scalaVersion := "2.10.0"

scalacOptions ++= Seq("-feature", "-deprecation")

libraryDependencies += "org.scalatest" % "scalatest_2.11" % "2.2.4" % "test"

libraryDependencies += "com.github.mpeltonen" % "sbt-idea_2.10_0.13" % "1.6.0"
