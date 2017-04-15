#!groovy
node{
    stage 'scm'
    git ''
    echo 'clean'
    mvn clean --settings="/media/naruto/Stuty&Work/Program Green/apache-maven-3.3.9/conf/settings_ubuntu.xml"
    stage 'build'
    mvn package --settings="/media/naruto/Stuty&Work/Program Green/apache-maven-3.3.9/conf/settings_ubuntu.xml"
    stage 'deploy'
    step([$class: ‘ArtifactArchiver’, artifacts: ‘**/target/*.jar’, fingerprint: true])
}
