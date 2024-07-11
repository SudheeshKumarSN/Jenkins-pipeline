pipeline{
    agent {
        label 'slave1'
    }
    tools {
        maven 'maven_3.9.8'
    }
        stages{
            stage('checkout'){
                steps{
                git branch: 'main', credentialsId: 'Git-Jenkins', url: 'https://github.com/SudheeshKumarSN/Jenkins-pipeline.git'
                }
            }
            stage('compile test and integration test'){
                steps{
                    sh ''' cd ./java_app && ls -ltr
                     mvn test && mvn package
                    ''' 
                }
            }
            stage('tomcat-deploy'){
                steps{
                    deploy adapters: [tomcat9(credentialsId: 'tomcat', url: 'http://13.233.75.146:8080', path: '')],
                                        contextPath: '/java_app',
                                        war: '/Calculator/java_app/target/calculator.war'
                }
            }

        }
}   
