#!groovy
node{
    stage 'scm'
    git 'https://github.com/naruto198908/codeGenerator'
    echo 'clean'
    sh 'mvn clean --settings="/media/naruto/Stuty&Work/Program Green/apache-maven-3.3.9/conf/settings_ubuntu.xml"'
    stage 'build'
    sh 'mvn package --settings="/media/naruto/Stuty&Work/Program Green/apache-maven-3.3.9/conf/settings_ubuntu.xml"'
    stage 'deploy'
    #step([$class: 'ArtifactArchiver', artifacts: '**/target/*.jar', fingerprint: true])
}
